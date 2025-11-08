# 快速开始指南

## 5分钟快速上手

### Android开发（Windows）

1. **安装Android Studio**
   - 下载: https://developer.android.com/studio
   - 安装时选择"Standard"安装

2. **打开项目**
   ```
   打开Android Studio
   File > Open > 选择 mobile-cpp-app/android 目录
   ```

3. **等待同步**
   - Gradle会自动下载依赖
   - 首次可能需要几分钟

4. **运行应用**
   - 连接Android设备或启动模拟器
   - 点击绿色运行按钮 ▶️

### iOS开发（macOS）

1. **打开项目**
   ```bash
   cd mobile-cpp-app/ios
   open MobileApp.xcodeproj
   ```

2. **配置项目**
   - 在Xcode中选择项目
   - 设置Signing & Capabilities中的Team

3. **运行应用**
   - 选择模拟器或真机
   - 按 Cmd+R 运行

## 项目结构说明

```
mobile-cpp-app/
├── include/          # C++头文件（共享代码）
├── src/              # C++源文件（共享代码）
├── android/          # Android项目
└── ios/              # iOS项目
```

## 添加新功能

### 1. 在C++中添加函数

**编辑 `include/MobileApp.h`:**
```cpp
EXPORT_FUNC int myNewFunction(int param);
```

**编辑 `src/MobileApp.cpp`:**
```cpp
int myNewFunction(int param) {
    return param * 2;
}
```

### 2. Android调用

**编辑 `android/app/src/main/java/com/mobileapp/MainActivity.java`:**
```java
private native int myNewFunction(int param);
```

### 3. iOS调用

**编辑 `ios/MobileApp/MobileAppBridge.h`:**
```objc
+ (int)myNewFunctionWithParam:(int)param;
```

**编辑 `ios/MobileApp/MobileAppBridge.mm`:**
```objc
+ (int)myNewFunctionWithParam:(int)param {
    return myNewFunction(param);
}
```

## 常见命令

### Android
```bash
# 构建Debug版本
cd android
./gradlew assembleDebug

# 安装到设备
./gradlew installDebug

# 清理构建
./gradlew clean
```

### iOS
```bash
# 使用xcodebuild构建
cd ios
xcodebuild -project MobileApp.xcodeproj -scheme MobileApp -sdk iphonesimulator
```

## 下一步

- 查看 `README.md` 了解详细文档
- 查看 `INSTALL.md` 了解完整安装步骤
- 开始编写你的C++代码！

