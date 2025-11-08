# 项目结构说明

## 完整目录树

```
mobile-cpp-app/
│
├── include/                          # C++头文件目录（共享代码）
│   └── MobileApp.h                  # 核心C++函数声明
│
├── src/                              # C++源文件目录（共享代码）
│   └── MobileApp.cpp                # 核心C++函数实现
│
├── android/                          # Android项目目录
│   ├── app/
│   │   ├── build.gradle             # App模块Gradle配置
│   │   ├── proguard-rules.pro       # ProGuard混淆规则
│   │   └── src/main/
│   │       ├── java/com/mobileapp/
│   │       │   └── MainActivity.java # Android主Activity
│   │       ├── cpp/
│   │       │   └── CMakeLists.txt   # Android CMake配置
│   │       ├── res/
│   │       │   ├── layout/
│   │       │   │   └── activity_main.xml # 主界面布局
│   │       │   └── values/
│   │       │       └── strings.xml   # 字符串资源
│   │       └── AndroidManifest.xml  # Android清单文件
│   ├── build.gradle                 # 项目级Gradle配置
│   ├── settings.gradle              # Gradle设置
│   ├── gradle.properties            # Gradle属性
│   └── gradle/wrapper/              # Gradle包装器
│
├── ios/                              # iOS项目目录
│   ├── MobileApp.xcodeproj/         # Xcode项目文件
│   │   └── project.pbxproj          # 项目配置
│   └── MobileApp/                   # iOS应用目录
│       ├── AppDelegate.swift        # 应用委托
│       ├── SceneDelegate.swift      # 场景委托
│       ├── ViewController.swift     # 视图控制器
│       ├── MobileAppBridge.h        # Objective-C++桥接头文件
│       ├── MobileAppBridge.mm       # Objective-C++桥接实现
│       ├── Info.plist               # iOS信息配置
│       └── Assets.xcassets/         # 资源文件（需创建）
│
├── CMakeLists.txt                   # 根CMake配置
├── .gitignore                       # Git忽略文件
├── README.md                        # 项目说明文档
├── INSTALL.md                       # 安装指南
├── QUICKSTART.md                    # 快速开始指南
├── PROJECT_STRUCTURE.md             # 本文件
├── build-android.sh                 # Android构建脚本（Linux/Mac）
└── build-android.bat                # Android构建脚本（Windows）
```

## 核心文件说明

### C++共享代码

- **`include/MobileApp.h`**: 定义所有C++函数的接口
- **`src/MobileApp.cpp`**: 实现所有C++函数的核心逻辑

### Android特定文件

- **`android/app/src/main/java/com/mobileapp/MainActivity.java`**: 
  - Android主Activity，通过JNI调用C++函数
  - 加载native库: `System.loadLibrary("mobile_cpp_lib")`
  
- **`android/app/src/main/cpp/CMakeLists.txt`**: 
  - 配置Android NDK构建
  - 链接C++源文件

- **`android/app/build.gradle`**: 
  - 配置Android应用构建
  - 设置NDK和CMake参数

### iOS特定文件

- **`ios/MobileApp/ViewController.swift`**: 
  - iOS主视图控制器
  - 通过Objective-C++桥接调用C++函数

- **`ios/MobileApp/MobileAppBridge.h/mm`**: 
  - Objective-C++桥接层
  - 将C++函数封装为Objective-C方法
  - Swift通过此桥接调用C++

## 代码调用流程

### Android流程
```
Java (MainActivity)
    ↓ JNI
C++ (MobileApp.cpp)
```

### iOS流程
```
Swift (ViewController)
    ↓
Objective-C++ (MobileAppBridge)
    ↓
C++ (MobileApp.cpp)
```

## 添加新功能的步骤

1. **在C++中定义函数** (`include/MobileApp.h` + `src/MobileApp.cpp`)
2. **Android**: 在`MainActivity.java`中添加JNI方法
3. **iOS**: 在`MobileAppBridge.h/mm`中添加Objective-C方法
4. **在UI中调用**: 分别在Android和iOS的UI代码中调用

## 构建输出

### Android
- APK文件: `android/app/build/outputs/apk/debug/app-debug.apk`
- 共享库: `android/app/build/intermediates/cmake/.../libmobile_cpp_lib.so`

### iOS
- App包: `ios/build/MobileApp.app`
- Framework: 编译到App包中

## 注意事项

1. **代码共享**: 核心业务逻辑放在`src/`目录，确保Android和iOS使用相同代码
2. **平台差异**: 使用预处理器指令处理平台特定代码
3. **内存管理**: 注意C++和Java/Swift之间的内存管理
4. **线程安全**: 如果涉及多线程，注意线程安全

