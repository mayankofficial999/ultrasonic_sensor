import AVFoundation
import Accelerate
import Foundation

class AudioAnalyzer {
    private let audioEngine = AVAudioEngine()
    private var fftSetup: FFTSetup?
    private let fftSize = vDSP_Length(1024)  // Example FFT size
    private var startTime: UInt64 = 0;
    private var endTime: UInt64 = 0;
    public var _maxFrequency = 0;
    public var _maxMagnitude = 0;
    public var _lastTime = 0;
    private var binaryBuffer = ""

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioSessionInterruption), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
        setupAudioEngine()
    }

    @objc func handleAudioSessionInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }

        if type == .began {
            // Interruption began, audio session is inactive
            // Save state or pause audio tasks
        } else if type == .ended {
            print("AudioSession Ended")
            // Interruption ended, possibly resume the audio session
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption ended. Attempt to resume the audio session
                    // Reactivate the audio session
                    do {
                        let audioSession = AVAudioSession.sharedInstance()
                        try audioSession.setCategory(.record, mode: .default)
                        try audioSession.setActive(true)
                    } catch {
                        print("Failed to set audio session category. Error: \(error)")
                    }
                }
            }
        }
    }

    func generateSineWave() {
        let audioEngine = AVAudioEngine()
        let playerNode = AVAudioPlayerNode()
        audioEngine.attach(playerNode)
        let frequency = 10000  // Frequency in Hz (e.g., 440 Hz for A4)
        let amplitude = 1    // Amplitude (volume)
        let sampleRate = 44100.0
        let durationInMilliseconds = 100.0 // Duration in milliseconds

        // Calculate the number of samples based on the duration and sample rate
        let numSamples = Int(durationInMilliseconds * 0.001 * sampleRate)

        // Create an array to store the waveform samples
        var waveform = [Float](repeating: 0, count: numSamples)

        // Calculate the phase increment for each sample
        let phaseIncrement = 2.0 * .pi * Double(frequency) / sampleRate

        // Generate the waveform samples
        for i in 0..<numSamples {
            let phase = Double(i) * phaseIncrement
            waveform[i] = Float(amplitude) * Float(sin(phase))
        }

        let outputFormat = audioEngine.outputNode.inputFormat(forBus: 0)
        audioEngine.connect(playerNode, to: audioEngine.outputNode, format: outputFormat)
        // Create an AVAudioPCMBuffer with the waveform
        guard let buffer = AVAudioPCMBuffer(pcmFormat: outputFormat, frameCapacity: AVAudioFrameCount(waveform.count)) else {
            fatalError("Failed to create AVAudioPCMBuffer")
        }
        buffer.frameLength = AVAudioFrameCount(waveform.count)
        for i in 0..<waveform.count {
            buffer.floatChannelData?.pointee[i] = waveform[i]
        }

        // Schedule the buffer for playback
        playerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch {
            
        }
        // Start playing
        playerNode.play()
        usleep(useconds_t(durationInMilliseconds * 1000))
        playerNode.stop()
        audioEngine.stop()
    }

    private func setupAudioEngine() {
        switch AVAudioSession.sharedInstance().recordPermission {
            case .undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    if granted {
                        print("Granted")
                        // Permission granted
                    } else {
                        // Handle permission denied
                        print("Not Granted")
                    }
                }
            case .denied:
                // Handle permission denied
                print("Denied, Asking again:")
                promptToOpenSettings()
            case .granted:
                // Permission granted
                print("Accepted")
            @unknown default:
                fatalError()
        }
        self.audioEngine.reset()
        let inputNode = audioEngine.inputNode
        let inputFormat = inputNode.inputFormat(forBus: 0)
        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) {
             [weak self] (buffer, _) in
                 self?.processAudioBuffer(buffer: buffer)
        }
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session category. Error: \(error)")
        }
        do {
            startTime = DispatchTime.now().uptimeNanoseconds
        //  generateSineWave();
            endTime = DispatchTime.now().uptimeNanoseconds
            print("Time taken for playback: \(endTime-startTime) ns")
           try audioEngine.start()
           startTime = DispatchTime.now().uptimeNanoseconds
        } catch {
            print("Audio engine failed to start. Error: \(error)")
        }
    }
    
    func promptToOpenSettings() {
        let alert = UIAlertController(title: "Microphone Access Denied", message: "Please enable access to the microphone in the Settings app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    }
    
    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000;
        let freq = 1000.0/(currentTimeMillis - Double(_lastTime));
//        print("Mic freq: \(freq)")
        guard let channelData = buffer.floatChannelData?[0] else { return }
        guard let fftSetup = vDSP_DFT_zop_CreateSetup(nil, 1024, vDSP_DFT_Direction.FORWARD) else { return }
        
        //output setup
        var realIn = [Float](repeating: 0, count: 1024)
        var imagIn = [Float](repeating: 0, count: 1024)
        var realOut = [Float](repeating: 0, count: 1024)
        var imagOut = [Float](repeating: 0, count: 1024)
        
        for i in 0...1023 {
            realIn[i] = channelData[i]
        }
        vDSP_DFT_Execute(fftSetup, &realIn, &imagIn, &realOut, &imagOut)

        //our results are now inside realOut and imagOut
        var complex = DSPSplitComplex(realp: &realOut, imagp: &imagOut)
        
        //setup magnitude output
        var magnitudes = [Float](repeating: 0, count: 1024)

        //calculate magnitude results
        vDSP_zvabs(&complex, 1, &magnitudes, 1, 1024)
        
        // Assuming you have the sampling rate in Hz
        let samplingRate: Float = 44100.0

        // Assuming the length of your magnitudes array is 512
        let numPoints = 1024

        // Create an array to store the frequencies
        var frequencies = [Float](repeating: 0, count: numPoints)

        // Calculate frequencies
        for i in 1..<numPoints {
            frequencies[i] = Float(i) / Float(numPoints) * samplingRate
        }
        
        // Find the index with the maximum magnitude
        var maxMagnitudeIndex = 0
        var maxMagnitude = magnitudes[maxMagnitudeIndex]

        for i in 1..<512 {
            if magnitudes[i] > maxMagnitude {
                maxMagnitude = magnitudes[i]
                maxMagnitudeIndex = i
            }
        }

        // Get the corresponding frequency for the maximum magnitude
        let maxFrequency = frequencies[maxMagnitudeIndex]

        // Print or use the max frequency and magnitude
//        print("Max Frequency: \(maxFrequency) Hz, Max Magnitude: \(maxMagnitude), index: \(maxMagnitudeIndex)")
        _maxFrequency = Int(maxFrequency);
        _maxMagnitude = Int(maxMagnitude);
         let bitVal = getBinaryStream(frequency: 16000)
        binaryBuffer += "\(bitVal)"
        if binaryBuffer.count == 32 {
            print("Binary no: \(binaryBuffer)")
            let obj = Utility()
            let hex = obj.binaryToHex(binaryBuffer)
            print("Hex no: \(hex)")
            let uChar = obj.hexToString(hex)
            print("Decoded char: \(uChar)")
            binaryBuffer = ""
        }
            
//         print(bitVal)
        // var normalizedMagnitudes = [Float](repeating: 0.0, count: 512)
        // print("Normalised Magnitides: \(normalizedMagnitudes))")
        // var scalingFactor = Float(25.0/512)
        // vDSP_vsmul(&magnitudes, 1, &scalingFactor, &normalizedMagnitudes, 1, 512)
//        print("Execution time(ms): \(Date().timeIntervalSince1970 * 1000 - currentTimeMillis)");
        _lastTime = Int(Date().timeIntervalSince1970 * 1000)

    }

    private func getBinaryStream(frequency: Int) -> Int {
        if Int(_maxFrequency) > (frequency - 50) && Int(_maxFrequency) < (frequency + 50) {
            return 1
        }
        else {
            return 0
        }
    }
    
    // Define a function that takes a callback function as a parameter
    func fetchData(completion: @escaping (String) -> Void) {
        // Simulate fetching data asynchronously
        DispatchQueue.global().async {
            // Call the completion handler with the fetched data
            completion(data)
        }
    }

    // Call this method to stop the audio engine when needed
    func stop() {
        audioEngine.stop()
    }
}
