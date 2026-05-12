# Fixing "Unresolved Reference: Flutter" in VSCode

## 🔍 **Understanding the Issue**

The "unresolved reference: flutter" error occurs because VSCode's Java language server doesn't automatically recognize Flutter SDK dependencies the way Android Studio does. This is a common issue in Flutter plugin development.

## ✅ **Solution: Multiple Approaches**

### **Approach 1: Use Multi-Root Workspace (Recommended)**

1. **Open the workspace file** instead of the folder:

   ```bash
   code .vscode/ultrasonic_sensor.code-workspace
   ```

2. **This provides proper project structure recognition** with separate folders for:
   - Flutter Plugin (Root)
   - Android Platform
   - Example App

### **Approach 2: Restart Java Language Server**

1. **Open Command Palette** (`Cmd+Shift+P`)
2. **Run**: `Java: Clean Java Language Server Workspace`
3. **Select**: `Reload and delete`
4. **Wait for**: Java Language Server to restart

### **Approach 3: Build-First Approach**

1. **Build the example app first** to download all dependencies:

   ```bash
   cd example
   flutter build apk --debug
   ```

2. **Reload Java projects**:
   - Open Command Palette (`Cmd+Shift+P`)
   - Run: `Java: Reload Projects`

### **Approach 4: Configure Java Classpath**

The VSCode settings have been configured to point to the built dependencies:

```json
{
  "java.project.referencedLibraries": [
    "example/build/host/outputs/repo/**/*.jar",
    "example/android/app/build/intermediates/flutter/**/*.jar"
  ]
}
```

## 🛠️ **Step-by-Step Solution**

### **Step 1: Build Flutter Project**

```bash
# From project root
flutter pub get
cd example
flutter pub get
flutter build apk --debug
```

### **Step 2: Restart Java Language Server**

- `Cmd+Shift+P` → `Java: Clean Java Language Server Workspace`
- Select `Reload and delete`

### **Step 3: Open Multi-Root Workspace**

```bash
code .vscode/ultrasonic_sensor.code-workspace
```

### **Step 4: Verify Resolution**

- Open `android/src/main/kotlin/io/mayanksharma/ultrasonic_sensor/UltrasonicSensorPlugin.kt`
- Check if `import io.flutter.embedding.engine.plugins.FlutterPlugin` resolves

## 🔧 **Why This Happens**

### **Android Studio vs VSCode**

- **Android Studio**: Built-in Flutter plugin support, automatic dependency resolution
- **VSCode**: Requires manual configuration to understand Flutter plugin structure

### **Flutter Plugin Structure**

```
ultrasonic_sensor/
├── android/                    # Android platform code (needs Flutter dependencies)
├── example/                    # Example app (downloads Flutter dependencies)
├── lib/                        # Main plugin code (Dart)
└── pubspec.yaml                # Plugin definition
```

### **Dependency Resolution**

- **Flutter dependencies** are downloaded when building the example app
- **VSCode** needs to be told where to find these dependencies
- **Android Studio** handles this automatically

## 🎯 **Expected Behavior After Fix**

### **✅ Imports Should Resolve**

```kotlin
import io.flutter.embedding.engine.plugins.FlutterPlugin  // ✅ Resolved
import io.flutter.plugin.common.MethodCall               // ✅ Resolved
import io.flutter.plugin.common.MethodChannel            // ✅ Resolved
import androidx.annotation.NonNull                        // ✅ Resolved
```

### **✅ Code Intelligence Works**

- Auto-completion for Flutter APIs
- Go to definition for Flutter classes
- Error detection and syntax highlighting
- Hover documentation for Flutter methods

## 🚀 **Development Workflow**

### **1. Make Changes to Android Code**

```kotlin
// Edit: android/src/main/kotlin/.../UltrasonicSensorPlugin.kt
```

### **2. Test Changes**

```bash
cd example
flutter run
```

### **3. Hot Reload**

- Make changes to Dart code in `lib/`
- Save files for hot reload
- Android changes require app restart

## 🐛 **Troubleshooting**

### **If Imports Still Don't Resolve**

1. **Check Flutter SDK Path**:

   ```bash
   which flutter
   # Update .vscode/settings.json with correct path
   ```

2. **Verify Dependencies Downloaded**:

   ```bash
   ls -la example/build/host/outputs/repo/
   # Should contain Flutter dependencies
   ```

3. **Check Java Configuration**:

   ```bash
   java --version
   # Should show JDK 17 or higher
   ```

4. **Restart VSCode Completely**:
   - Close VSCode
   - Reopen with workspace file
   - Wait for Java Language Server to start

### **If Still Issues**

1. **Try Android Studio**:

   - Open `android/` directory in Android Studio
   - Verify imports work there
   - This confirms the setup is correct

2. **Check VSCode Extensions**:
   - Ensure Extension Pack for Java is installed
   - Check if Flutter extensions are active

## 💡 **Pro Tips**

### **1. Use Workspace File**

Always open the `.code-workspace` file instead of the folder for better project recognition.

### **2. Build First, Code Second**

Always build the example app first to download dependencies before coding.

### **3. Restart When Stuck**

Java Language Server can get confused - restart it when in doubt.

### **4. Use Flutter Commands**

Prefer Flutter commands over direct Gradle for plugin development.

## 🎉 **Summary**

The "unresolved reference: flutter" issue is resolved by:

1. ✅ **Building the example app** to download Flutter dependencies
2. ✅ **Configuring VSCode** to find these dependencies
3. ✅ **Using multi-root workspace** for proper project structure
4. ✅ **Restarting Java Language Server** when needed

Your Flutter plugin development environment is now properly configured! 🚀
