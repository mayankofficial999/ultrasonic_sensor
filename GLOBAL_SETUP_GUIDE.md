# Global Java & Android Development Setup for VSCode

## 🌍 **Global vs Workspace Settings**

### **What Should Be Global**

- **JDK/Java Runtime Configuration** - Same across all projects
- **Android SDK Paths** - Same for all Android projects
- **Editor Preferences** - Code formatting, imports, etc.
- **Terminal Environment** - Java and Android paths
- **Extension Settings** - General Java/Android extension behavior

### **What Should Be Workspace-Specific**

- **Build Tasks** - Project-specific Gradle tasks
- **Launch Configurations** - Debug configurations for specific apps
- **Project Dependencies** - Project-specific libraries and dependencies

## 🛠️ **Setting Up Global Configuration**

### **Method 1: Via VSCode UI (Recommended)**

1. Open VSCode
2. Press `Cmd+,` (or `Ctrl+,` on Windows/Linux)
3. Click the "Open Settings (JSON)" icon in the top right
4. Add the global settings below

### **Method 2: Direct File Edit**

Edit: `~/Library/Application Support/Code/User/settings.json`

## 📋 **Global Settings Template**

Add these settings to your **User Settings (JSON)**:

```json
{
  // ============= JAVA CONFIGURATION =============
  "java.configuration.runtimes": [
    {
      "name": "JavaSE-1.8",
      "path": "/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
    },
    {
      "name": "JavaSE-15",
      "path": "/Library/Java/JavaVirtualMachines/jdk-15.0.1.jdk/Contents/Home"
    },
    {
      "name": "JavaSE-17",
      "path": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
      "default": true
    }
  ],

  // Java Language Server
  "java.jdt.ls.java.home": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
  "java.home": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",

  // ============= ANDROID CONFIGURATION =============
  "java.import.gradle.java.home": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
  "java.import.gradle.enabled": true,
  "java.import.gradle.wrapper.enabled": true,

  // Maven with Android support
  "maven.terminal.customEnv": [
    {
      "environmentVariable": "JAVA_HOME",
      "value": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
    },
    {
      "environmentVariable": "ANDROID_HOME",
      "value": "/Users/mayanksharma/Library/Android/sdk"
    },
    {
      "environmentVariable": "ANDROID_SDK_ROOT",
      "value": "/Users/mayanksharma/Library/Android/sdk"
    }
  ],

  // ============= TERMINAL CONFIGURATION =============
  "terminal.integrated.env.osx": {
    "JAVA_HOME": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
    "ANDROID_HOME": "/Users/mayanksharma/Library/Android/sdk",
    "ANDROID_SDK_ROOT": "/Users/mayanksharma/Library/Android/sdk",
    "PATH": "/Users/mayanksharma/Library/Android/sdk/platform-tools:/Users/mayanksharma/Library/Android/sdk/tools:/Users/mayanksharma/Library/Android/sdk/tools/bin:/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin:${env:PATH}"
  },

  // ============= ANDROID EXTENSION SETTINGS =============
  "android.gradle.home": "/Users/mayanksharma/Library/Android/sdk",
  "android.sdk.location": "/Users/mayanksharma/Library/Android/sdk",

  // ============= JAVA EDITOR SETTINGS =============
  "java.autobuild.enabled": true,
  "java.maxConcurrentBuilds": 4,
  "java.completion.enabled": true,
  "java.completion.guessMethodArguments": "insertBestGuessedArguments",
  "java.format.enabled": true,
  "java.format.onType.enabled": true,
  "java.maven.downloadSources": true,

  // ============= CODE QUALITY =============
  "java.compile.nullAnalysis.mode": "automatic",
  "java.saveActions.organizeImports": true,
  "java.sources.organizeImports.starThreshold": 99,
  "java.sources.organizeImports.staticStarThreshold": 99,

  // ============= EDITOR PREFERENCES =============
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": "explicit"
  },

  // ============= FILE ASSOCIATIONS =============
  "files.associations": {
    "*.gradle": "groovy",
    "*.gradle.kts": "kotlin"
  },

  // ============= GRADLE SETTINGS =============
  "gradle.nestedProjects": true,
  "gradle.autoDetect": "on",
  "gradle.focusTaskInExplorer": true,

  // ============= KOTLIN SUPPORT =============
  "kotlin.compiler.jvm.target": "17",

  // ============= PROJECT DISCOVERY =============
  "java.import.exclusions": [
    "**/node_modules/**",
    "**/.git/**",
    "**/build/**",
    "**/.gradle/**"
  ]
}
```

## 🚀 **Quick Setup Instructions**

### **1. Add Global Settings**

```bash
# Open VSCode User Settings
code ~/Library/Application\ Support/Code/User/settings.json

# Or use VSCode UI: Cmd+, then click "Open Settings (JSON)"
```

### **2. Verify Setup**

Open any Android project and check:

- Java version: `java --version`
- Android SDK: `echo $ANDROID_HOME`
- Gradle works: `./gradlew --version`

## 📁 **What You Still Need Per Project**

### **Minimal Workspace Files**

For each Android project, you might still want:

#### **`.vscode/tasks.json`** (Project-specific build tasks)

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Android: Build Debug APK",
      "type": "shell",
      "command": "./gradlew",
      "args": ["assembleDebug"],
      "group": "build",
      "options": {
        "cwd": "${workspaceFolder}/android"
      }
    }
  ]
}
```

#### **`.vscode/launch.json`** (Project-specific debug config)

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Launch Current File",
      "request": "launch",
      "mainClass": "${file}"
    }
  ]
}
```

## 🔄 **Migration Strategy**

### **From Current Setup**

1. **Copy global settings** from your current `.vscode/settings.json` to User Settings
2. **Keep project-specific** tasks and launch configurations
3. **Delete workspace settings** that are now global

### **For New Projects**

1. **No setup needed** - Extensions and Java/Android paths work automatically
2. **Add project-specific tasks** only if needed
3. **Add launch configurations** only for debugging

## ✅ **Benefits of Global Setup**

- **🚀 Zero setup** for new Android projects
- **🔧 Consistent environment** across all projects
- **⚡ Faster project opening** - no workspace configuration needed
- **🛠️ Easier maintenance** - update paths in one place

## 🎯 **Next Steps**

1. **Apply global settings** using the template above
2. **Test with a new Android project** - it should work immediately
3. **Remove redundant workspace settings** from existing projects
4. **Enjoy seamless Android development** across all projects! 🎉

## 🔍 **Troubleshooting**

### **If Java/Android paths don't work:**

1. Check JDK paths: `ls /Library/Java/JavaVirtualMachines/`
2. Verify Android SDK: `ls ~/Library/Android/sdk`
3. Update paths in global settings accordingly

### **If projects don't detect properly:**

1. Reload VSCode: `Cmd+Shift+P` → "Developer: Reload Window"
2. Clean Java workspace: `Cmd+Shift+P` → "Java: Clean Java Language Server Workspace"
3. Reload projects: `Cmd+Shift+P` → "Java: Reload Projects"
