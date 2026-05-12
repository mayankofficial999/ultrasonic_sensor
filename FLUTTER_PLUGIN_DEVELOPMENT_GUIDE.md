# Flutter Plugin Development in VSCode

## 🔍 **Understanding Flutter Plugin Structure**

Your project is a **Flutter plugin**, not a pure Android project. This is why the Gradle plugin doesn't recognize it as expected.

### **Project Structure**

```
ultrasonic_sensor/
├── lib/                    # 🎯 Main plugin code (Dart)
├── android/               # 🤖 Android platform implementation
├── ios/                   # 🍎 iOS platform implementation
├── example/               # 📱 Example Flutter app using the plugin
├── test/                  # 🧪 Plugin unit tests
└── pubspec.yaml           # 📦 Flutter plugin configuration
```

### **Key Differences from Android Projects**

- **Flutter plugins** use `flutter` commands, not direct `gradle` commands
- **Android directory** contains platform-specific code, not the main project
- **Main development** happens in Dart (`lib/` directory)
- **Build system** is Flutter's build system, not pure Gradle

## 🛠️ **VSCode Configuration for Flutter Plugin Development**

### **✅ What's Now Configured**

- **Flutter SDK Integration** - Proper SDK path and settings
- **Dart Language Support** - IntelliSense, debugging, formatting
- **Android/iOS Platform Support** - For platform-specific code
- **Flutter-Specific Tasks** - Build, test, run commands
- **Debug Configurations** - Run plugin example, tests, different platforms

### **🔧 Extensions Active**

- **Flutter** - Main Flutter development support
- **Dart** - Dart language support
- **Extension Pack for Java** - For Android platform code
- **Android Full Support** - For Android platform implementation

## 🚀 **Flutter Plugin Development Workflow**

### **1. Main Plugin Development (Dart)**

**Location:** `lib/` directory
**Language:** Dart
**Purpose:** Plugin interface and common logic

#### **Available Commands:**

- `Flutter: Get Dependencies` - Install dependencies
- `Flutter: Analyze` - Check code quality
- `Flutter: Format` - Format Dart code
- `Flutter: Run Tests` - Run plugin tests

### **2. Android Platform Implementation**

**Location:** `android/` directory
**Language:** Java/Kotlin
**Purpose:** Android-specific plugin functionality

#### **Available Commands:**

- `Android: Build Plugin (Gradle)` - Build Android platform code
- `Android: Clean Plugin (Gradle)` - Clean Android build

### **3. iOS Platform Implementation**

**Location:** `ios/` directory
**Language:** Swift/Objective-C
**Purpose:** iOS-specific plugin functionality

#### **Available Commands:**

- `iOS: Build Plugin (Xcode)` - Build iOS platform code

### **4. Example App Testing**

**Location:** `example/` directory
**Language:** Flutter/Dart
**Purpose:** Test and demonstrate plugin functionality

#### **Available Commands:**

- `Flutter: Run Plugin Example` - Run example app
- `Flutter: Build Plugin Example (Android)` - Build APK
- `Flutter: Build Plugin Example (iOS)` - Build iOS app

## 🔍 **Working with the Gradle Files**

### **Why Gradle Extension Doesn't Work Directly**

The Gradle extension expects Gradle files at the **root level**, but Flutter plugins have them in the `android/` subdirectory.

### **Solution: Use Flutter Commands Instead**

```bash
# ❌ Don't use direct Gradle commands at root
./gradlew build  # This won't work

# ✅ Use Flutter commands for plugin development
flutter pub get
flutter analyze
flutter test

# ✅ Use Flutter commands for example app
cd example/
flutter run
flutter build apk
flutter build ios

# ✅ Use Gradle commands in android/ directory
cd android/
./gradlew build
```

## 📋 **Common Development Tasks**

### **🧪 Testing Your Plugin**

```bash
# Run plugin tests
flutter test

# Run example app tests
cd example/
flutter test

# Run integration tests
cd example/
flutter test integration_test/
```

### **🔧 Building Your Plugin**

```bash
# Build Android version
cd example/
flutter build apk

# Build iOS version
cd example/
flutter build ios

# Build for specific platform
flutter build apk --target-platform android-arm64
```

### **📦 Publishing Your Plugin**

```bash
# Check plugin quality
flutter pub publish --dry-run

# Publish to pub.dev
flutter pub publish
```

## 🎯 **VSCode Features for Flutter Plugin Development**

### **Debug Configurations Available**

- **Flutter: Run Plugin Example** - Debug main example app
- **Flutter: Run Plugin Example (Android)** - Debug on Android
- **Flutter: Run Plugin Example (iOS)** - Debug on iOS
- **Flutter: Run Plugin Tests** - Debug plugin tests
- **Dart: Run Current File** - Debug any Dart file

### **Tasks Available**

- **Flutter: Get Dependencies** - `flutter pub get`
- **Flutter: Run Tests** - `flutter test`
- **Flutter: Analyze** - `flutter analyze`
- **Flutter: Format** - `dart format .`
- **Flutter: Clean** - `flutter clean`

### **Code Intelligence**

- **Auto-completion** - For Dart and Flutter APIs
- **Go to Definition** - Navigate to method definitions
- **Find References** - Find all usage of methods
- **Rename Refactoring** - Rename symbols across files
- **Code Formatting** - Auto-format on save

## 🏗️ **Working with Platform-Specific Code**

### **Android Platform Code**

**Location:** `android/src/main/kotlin/io/mayanksharma/ultrasonic_sensor/`
**Current File:** `UltrasonicSensorPlugin.kt`

#### **How to Work with It:**

1. Open the Kotlin file in VSCode
2. You'll get Java/Kotlin IntelliSense
3. Use `Android: Build Plugin (Gradle)` task to build
4. Test changes by running the example app

### **iOS Platform Code**

**Location:** `ios/Classes/`
**Current Files:** `UltrasonicSensorPlugin.swift`, `FrequencySpectrum.swift`, `Utility.swift`

#### **How to Work with It:**

1. Open the Swift files in VSCode
2. You'll get basic Swift syntax highlighting
3. Use `iOS: Build Plugin (Xcode)` task to build
4. Test changes by running the example app on iOS

## 📱 **Running and Testing Your Plugin**

### **Quick Test Workflow**

1. **Make changes** to your plugin code (`lib/` directory)
2. **Run example app** using `Flutter: Run Plugin Example`
3. **Test on device** - Example app will use your plugin
4. **Debug if needed** - Set breakpoints in Dart code

### **Platform-Specific Testing**

1. **Modify Android code** (`android/` directory)
2. **Run on Android** using `Flutter: Run Plugin Example (Android)`
3. **Modify iOS code** (`ios/` directory)
4. **Run on iOS** using `Flutter: Run Plugin Example (iOS)`

## 🔧 **Gradle Integration (The Right Way)**

### **For Android Platform Development**

```bash
# Navigate to android directory
cd android/

# Build Android platform code
./gradlew build

# Clean Android build
./gradlew clean

# Run Android tests
./gradlew test
```

### **For Example App Android Build**

```bash
# Navigate to example directory
cd example/

# Build Android APK using Flutter
flutter build apk

# Or build using Gradle (in example/android/)
cd android/
./gradlew assembleDebug
```

## 💡 **Pro Tips**

### **1. Use Flutter Commands First**

Always prefer Flutter commands over direct Gradle/Xcode commands for plugin development.

### **2. Test in Example App**

The `example/` directory is your testing ground. Make changes to the plugin and test them here.

### **3. Platform-Specific Debugging**

- **Android**: Use `flutter run` with Android device/emulator
- **iOS**: Use `flutter run` with iOS simulator/device
- **Both**: Use `flutter run -d all` to run on all connected devices

### **4. Hot Reload Works**

You can use hot reload when running the example app to see changes instantly.

## 🎉 **You're Ready for Flutter Plugin Development!**

Your VSCode is now properly configured for Flutter plugin development with:

- ✅ **Flutter SDK integration**
- ✅ **Dart language support**
- ✅ **Android/iOS platform code support**
- ✅ **Debug configurations**
- ✅ **Build and test tasks**
- ✅ **Code intelligence and formatting**

### **Next Steps:**

1. **Start the example app**: `Cmd+Shift+P` → "Flutter: Run Plugin Example"
2. **Make plugin changes**: Edit files in `lib/` directory
3. **Test changes**: Hot reload in the running example app
4. **Build for release**: Use Flutter build commands

Happy Flutter plugin development! 🚀
