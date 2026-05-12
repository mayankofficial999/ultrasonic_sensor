import Foundation
import AVFoundation

public class Utility {

    init() {}

    func stringToHex(_ input: String) -> String {
        return input.utf8.map { String(format: "%02x", $0) }.joined()
    }

    func hexToBinary(_ hex: String) -> String {
        let hexToBinDict = [
            "0": "0000", "1": "0001", "2": "0010", "3": "0011",
            "4": "0100", "5": "0101", "6": "0110", "7": "0111",
            "8": "1000", "9": "1001", "a": "1010", "b": "1011",
            "c": "1100", "d": "1101", "e": "1110", "f": "1111"
        ]
        
        var binaryString = ""
        for char in hex {
            if let binary = hexToBinDict[String(char).lowercased()] {
                binaryString += binary
            } else {
                print("Invalid hex character: \(char)")
                return ""
            }
        }
        return binaryString
    }

    func binaryToHex(_ binary: String) -> String {
        // Check if binary string length is a multiple of 4
        guard binary.count % 4 == 0 else {
            print("Invalid binary string")
            return ""
        }

        var hexString = ""
        // Process each 4-bit chunk
        for i in stride(from: 0, to: binary.count, by: 4) {
            let startIndex = binary.index(binary.startIndex, offsetBy: i)
            let endIndex = binary.index(startIndex, offsetBy: 4)
            let binChunk = String(binary[startIndex..<endIndex])
            
            if let hexDigit = binaryChunkToHex(binChunk) {
                hexString += hexDigit
            } else {
                print("Invalid binary chunk: \(binChunk)")
                return ""
            }
        }
        return hexString
    }

    func binaryChunkToHex(_ binChunk: String) -> String? {
        switch binChunk {
        case "0000": return "0"
        case "0001": return "1"
        case "0010": return "2"
        case "0011": return "3"
        case "0100": return "4"
        case "0101": return "5"
        case "0110": return "6"
        case "0111": return "7"
        case "1000": return "8"
        case "1001": return "9"
        case "1010": return "a"
        case "1011": return "b"
        case "1100": return "c"
        case "1101": return "d"
        case "1110": return "e"
        case "1111": return "f"
        default: return nil
        }
    }

    func hexToString(_ hex: String) -> String {
        var result = ""
        var bytes = [UInt8]()

        // Process each pair of characters in the hex string
        for i in stride(from: 0, to: hex.count, by: 2) {
            let start = hex.index(hex.startIndex, offsetBy: i)
            let end = hex.index(start, offsetBy: 2)
            let hexSlice = hex[start..<end]
            
            if let byte = UInt8(hexSlice, radix: 16) {
                bytes.append(byte)
            } else {
                print("Invalid hex code: \(hexSlice)")
                return ""
            }
        }

        // Convert byte array to string using UTF8 String decoding
        result = String(bytes: bytes, encoding: .utf8) ?? ""
        return result
    }

    public func getBinary(_ input:String) -> String {
        let hex = stringToHex(input)
        return hexToBinary(hex);
    }

    public func getString(_ binary:String) -> String {
        let hex = binaryToHex(binary)
        return hexToString(hex);
    }

    public func playBinaryStringSound(_ binaryString: String) {
        let sampleRate = 44100.0
        let frequency = 16000.0
        let durationPerBit = 0.1
        let frameCount = Int(durationPerBit * sampleRate)
        
        var audioSamples = [Float]()
        
        for char in binaryString {
            if char == "1" {
                // Generate a 16 kHz tone
                for i in 0..<frameCount {
                    let sample = sin(2.0 * .pi * Double(i) * frequency / sampleRate)
                    audioSamples.append(Float(sample))
                }
            } else {
                // Generate silence
                audioSamples.append(contentsOf: Array(repeating: 0.0, count: frameCount))
            }
        }
        
        // Convert to AVAudioPCMBuffer and play
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(audioSamples.count)) else {
            print("Failed to create audio buffer")
            return
        }
        
        buffer.frameLength = buffer.frameCapacity
        for i in 0..<audioSamples.count {
            buffer.floatChannelData!.pointee[i] = audioSamples[i]
        }
        
        let audioPlayer = AVAudioPlayerNode()
        let audioEngine = AVAudioEngine()
        audioEngine.attach(audioPlayer)
        audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: buffer.format)
        
        do {
            try audioEngine.start()
        } catch {
            print("Could not start audio engine: \(error)")
            return
        }
        
        audioPlayer.play()
        audioPlayer.scheduleBuffer(buffer, at: nil, options: .loops)
        
        // Keep the function alive while playing
        let duration = Double(binaryString.count) * durationPerBit
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            audioPlayer.stop()
            audioEngine.stop()
        }
    }
}