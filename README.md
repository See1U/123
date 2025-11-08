# C++移动应用开发环境

这是一个完整的C++移动应用开发环境，支持Android和iOS平台。

## 项目结构

```
mobile-cpp-app/
├── include/              # C++头文件
│   └── MobileApp.h
├── src/                  # C++源文件
│   └── MobileApp.cpp
├── android/              # Android项目
│   ├── app/
│   │   ├── build.gradle
│   │   └── src/main/
│   │       ├── java/com/mobileapp/
│   │       ├── cpp/CMakeLists.txt
│   │       └── res/
│   ├── build.gradle
│   └── settings.gradle
├── ios/                  # iOS项目
│   └── MobileApp.xcodeproj/
├── CMakeLists.txt        # 根CMake配置
└── README.md
```

## 环境要求

### Android开发
- Android Studio (最新版本)
- Android SDK (API 24+)
- Android NDK (通过Android Studio SDK Manager安装)
- CMake (通过Android Studio SDK Manager安装)
- Gradle 8.0+

### iOS开发
- macOS系统
- Xcode 14.0+
- iOS SDK 13.0+

## 快速开始

### Android开发

1. **安装Android Studio**
   - 下载并安装 [Android Studio](https://developer.android.com/studio)
   - 打开Android Studio，安装SDK、NDK和CMake

2. **配置环境变量** (Windows)
   ```batch
   set ANDROID_HOME=C:\Users\YourName\AppData\Local\Android\Sdk
   set PATH=%PATH%;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools
   ```

3. **打开项目**
   - 在Android Studio中选择 `File > Open`
   - 选择 `mobile-cpp-app/android` 目录

4. **构建项目**
   - 使用Android Studio的Build菜单
   - 或使用命令行：
     ```bash
     cd android
     ./gradlew assembleDebug
     ```

5. **运行应用**
   - 连接Android设备或启动模拟器
   - 点击Run按钮或使用 `./gradlew installDebug`

### iOS开发

1. **打开Xcode项目**
   ```bash
   cd ios
   open MobileApp.xcodeproj
   ```

2. **配置签名**
   - 在Xcode中选择项目
   - 在Signing & Capabilities中配置你的开发团队

3. **构建和运行**
   - 选择目标设备（模拟器或真机）
   - 按Cmd+R运行

## C++代码说明

### 核心函数

- `getAppVersion()`: 获取应用版本号
- `calculate(a, b, operation)`: 执行基本数学运算
- `initializeApp()`: 初始化应用
- `cleanupApp()`: 清理资源

### 添加新的C++功能

1. 在 `include/MobileApp.h` 中声明函数
2. 在 `src/MobileApp.cpp` 中实现函数
3. 在Android的 `MainActivity.java` 中添加JNI接口
4. 在iOS的 `ViewController.swift` 中添加函数声明

## 常见问题

### Android

**问题**: NDK未找到
- 解决: 在Android Studio中，Tools > SDK Manager > SDK Tools，勾选NDK和CMake

**问题**: Gradle同步失败
- 解决: 检查网络连接，确保可以访问Google Maven仓库

### iOS

**问题**: 代码签名错误
- 解决: 在Xcode中配置正确的开发团队和Bundle Identifier

**问题**: C++文件未编译
- 解决: 确保在Xcode项目中将.cpp文件添加到编译目标

## 开发建议

1. **代码共享**: 将核心业务逻辑放在 `src/` 目录，确保Android和iOS共享同一套C++代码

2. **平台特定代码**: 使用预处理器指令区分平台：
   ```cpp
   #ifdef PLATFORM_ANDROID
       // Android特定代码
   #elif defined(PLATFORM_IOS)
       // iOS特定代码
   #endif
   ```

3. **JNI接口**: Android使用JNI调用C++函数，确保函数签名正确

4. **内存管理**: 注意C++和Java/Swift之间的内存管理，避免内存泄漏

## 下一步

- 添加更多C++功能模块
- 实现UI界面
- 添加单元测试
- 配置CI/CD流程

## 许可证

MIT License

