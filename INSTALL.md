# 安装指南

## Windows环境安装步骤

### 1. 安装Android Studio

1. 访问 [Android Studio官网](https://developer.android.com/studio)
2. 下载Windows版本安装包
3. 运行安装程序，按照向导完成安装
4. 首次启动时，选择"Standard"安装类型
5. 等待SDK、NDK和CMake自动下载安装

### 2. 配置Android环境变量

**📖 详细步骤请查看：[ANDROID_ENV_SETUP.md](ANDROID_ENV_SETUP.md)**

**快速步骤：**

1. 右键"此电脑" > "属性" > "高级系统设置"
2. 点击"环境变量"
3. 在"系统变量"中新建：
   - 变量名: `ANDROID_HOME`
   - 变量值: `C:\Users\你的用户名\AppData\Local\Android\Sdk`
4. 编辑Path变量，添加：
   - `%ANDROID_HOME%\platform-tools`
   - `%ANDROID_HOME%\tools`
   - `%ANDROID_HOME%\tools\bin`

**⚠️ 重要提示：**
- 配置完成后，**必须关闭所有命令行窗口并重新打开**才能生效
- 如果仍不生效，请重启电脑

### 3. 安装NDK和CMake

1. 打开Android Studio
2. 点击 `Tools` > `SDK Manager`
3. 切换到 `SDK Tools` 标签
4. 勾选以下项：
   - ✅ Android SDK Build-Tools
   - ✅ NDK (Side by side) - 最新版本
   - ✅ CMake
5. 点击 `Apply` 安装

### 4. 验证安装

打开PowerShell，运行：
```powershell
adb version
ndk-build --version
cmake --version
```

### 5. 打开项目

1. 启动Android Studio
2. 选择 `File` > `Open`
3. 选择 `mobile-cpp-app/android` 目录
4. 等待Gradle同步完成

### 6. 构建项目

在Android Studio中：
- 点击 `Build` > `Make Project`
- 或使用快捷键 `Ctrl+F9`

使用命令行：
```powershell
cd mobile-cpp-app\android
.\gradlew.bat assembleDebug
```

## macOS环境安装步骤（iOS开发）

### 1. 安装Xcode

1. 打开App Store
2. 搜索并安装Xcode
3. 安装完成后，打开Xcode接受许可协议
4. 运行 `xcode-select --install` 安装命令行工具

### 2. 打开iOS项目

```bash
cd mobile-cpp-app/ios
open MobileApp.xcodeproj
```

### 3. 配置签名

1. 在Xcode中选择项目
2. 选择 `Signing & Capabilities`
3. 选择你的Apple ID作为Team
4. 修改Bundle Identifier为唯一值（如：com.yourname.mobileapp）

### 4. 构建和运行

1. 选择目标设备（模拟器或真机）
2. 按 `Cmd+R` 运行

## 常见问题解决

### Android Studio无法找到NDK

**解决方法：**
1. 打开 `File` > `Project Structure` > `SDK Location`
2. 确认Android SDK Location路径正确
3. 在 `SDK Manager` 中重新安装NDK

### Gradle同步失败

**解决方法：**
1. 检查网络连接
2. 在 `gradle.properties` 中添加代理设置（如需要）
3. 清理项目：`File` > `Invalidate Caches / Restart`

### iOS代码签名错误

**解决方法：**
1. 确保已登录Apple ID
2. 在Xcode Preferences中添加Apple ID账户
3. 选择正确的开发团队

## 下一步

安装完成后，请参考 `README.md` 了解如何使用项目。

