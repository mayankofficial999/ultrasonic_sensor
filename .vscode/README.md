# VSCode Java & Android Development Setup

This setup provides a complete Java and Android development environment in VSCode, similar to Android Studio functionality.

## ✅ What's Configured

### Extensions Installed

- **Extension Pack for Java** - Complete Java development support
- **Android Full Support** - Android native development features
- **Java Auto Config** - Automatic JDK configuration and management

### Java Runtime Configuration

- **JDK 17** (Default) - Modern Java development
- **JDK 15** - Legacy support
- **Amazon Corretto 8** - Java 8 compatibility

### Android SDK Integration

- **Android SDK**: `~/Library/Android/sdk`
- **Platform Tools**: ADB, fastboot, etc.
- **Build Tools**: APK building and signing

## 🚀 Quick Start

### 1. Verify Installation

Open VSCode terminal and run:

```bash
java --version
echo $JAVA_HOME
```

### 2. Access Gradle Projects

- Open Command Palette (`Cmd+Shift+P`)
- Type "Java: Reload Projects"
- Navigate to any Android project and VSCode will detect Gradle automatically

### 3. Available Commands

#### Java Commands

- `Java: Reload Projects` - Refresh project dependencies
- `Java: Clean Java Language Server Workspace` - Reset Java environment
- `Java: Open Java Language Server Log File` - Debug Java issues

#### Android Commands

- `Android: Build debug apk` - Build debug APK
- `Android: Build release apk` - Build release APK
- `Android: Install on device` - Install APK via ADB
- `Android: Manage SDK` - Open SDK Manager GUI

#### Gradle Commands

- `gradle: clean` - Clean build artifacts
- `gradle: build` - Build the project
- `gradle: assemble` - Assemble all variants
- `gradle: test` - Run unit tests

## 🔧 Features Available

### Code Intelligence

- **Syntax Highlighting** - Full Java/Kotlin syntax support
- **Auto-completion** - IntelliSense for Android APIs
- **Error Detection** - Real-time syntax and compilation errors
- **Code Formatting** - Automatic code formatting on save
- **Organize Imports** - Automatic import management

### Build & Run

- **Gradle Integration** - Full Gradle project support
- **APK Building** - Build debug/release APKs
- **Device Installation** - Install APKs directly to devices
- **Testing** - Run unit and integration tests

### Debugging

- **Java Debugging** - Full debugging support
- **Breakpoints** - Set breakpoints in Java/Kotlin code
- **Variable Inspection** - Inspect variables during debugging
- **Call Stack** - View call stack during debugging

## 📁 Project Structure Support

VSCode will automatically detect and configure:

- `build.gradle` - Android Gradle projects
- `settings.gradle` - Multi-module projects
- `gradlew` - Gradle wrapper scripts
- `AndroidManifest.xml` - Android manifest files

## 🏗️ Building Projects

### Using VSCode Tasks

1. Open Command Palette (`Cmd+Shift+P`)
2. Type "Tasks: Run Task"
3. Select from available tasks:
   - `gradle: build`
   - `Android: Build Debug APK`
   - `Android: Build Release APK`

### Using Terminal

```bash
# Navigate to android directory
cd android

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Install to device
./gradlew installDebug
```

## 🔍 Gradle Projects Explorer

The Gradle extension provides a dedicated explorer view:

1. Look for the Gradle icon in the Activity Bar
2. Expand projects to see available tasks
3. Click on any task to run it
4. Pin frequently used tasks for easy access

## ⚙️ Configuration Files

### `.vscode/settings.json`

- Java runtime configuration
- Android SDK paths
- Gradle settings
- Editor preferences

### `.vscode/launch.json`

- Debug configurations
- Launch configurations for Java apps
- Remote debugging setup

### `.vscode/tasks.json`

- Build tasks for Gradle
- Android-specific build tasks
- Custom task definitions

## 🔧 Environment Variables

The following environment variables are automatically set in VSCode terminals:

- `JAVA_HOME` - Points to JDK 17
- `ANDROID_HOME` - Points to Android SDK
- `ANDROID_SDK_ROOT` - Points to Android SDK
- `PATH` - Includes Android tools and Java binaries

## 📚 Useful Shortcuts

### Navigation

- `Cmd+Shift+P` - Command Palette
- `Cmd+P` - Quick Open
- `Cmd+Shift+O` - Go to Symbol
- `F12` - Go to Definition

### Building

- `Cmd+Shift+B` - Run Build Task
- `Cmd+Shift+T` - Run Test Task

### Debugging

- `F5` - Start Debugging
- `F9` - Toggle Breakpoint
- `F10` - Step Over
- `F11` - Step Into

## 🐛 Troubleshooting

### Java Language Server Issues

1. Open Command Palette (`Cmd+Shift+P`)
2. Run "Java: Clean Java Language Server Workspace"
3. Select "Reload and delete"

### Gradle Sync Issues

1. Run "Java: Reload Projects"
2. Check Gradle wrapper permissions: `chmod +x gradlew`
3. Verify Android SDK path in settings

### Android SDK Issues

1. Run "Android: Manage SDK"
2. Ensure required SDK platforms are installed
3. Check Android SDK path: `~/Library/Android/sdk`

## 📖 Additional Resources

- [VSCode Java Documentation](https://code.visualstudio.com/docs/java/java-tutorial)
- [Android Developer Guide](https://developer.android.com/studio/build)
- [Gradle User Guide](https://docs.gradle.org/current/userguide/userguide.html)

## 🎉 You're Ready!

Your VSCode is now configured for Java and Android development with:

- ✅ Multiple JDK support
- ✅ Android SDK integration
- ✅ Gradle project support
- ✅ Code intelligence and debugging
- ✅ Build and deployment tools

Start coding! 🚀
