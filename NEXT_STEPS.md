# 下一步操作指南

## ✅ 已完成
- [x] 安装Android Studio
- [x] 配置环境变量（ANDROID_HOME和Path）
- [x] 验证SDK（adb命令可用）

## 📋 接下来的步骤

### 步骤3：安装NDK和CMake（必需）

NDK（Native Development Kit）和CMake是编译C++代码所必需的工具。

#### 详细操作：

1. **打开Android Studio**
   - 如果还没打开，启动Android Studio

2. **打开SDK Manager**
   - 点击顶部菜单：`Tools` > `SDK Manager`
   - 或者点击欢迎界面右下角的 `More Actions` > `SDK Manager`

3. **切换到SDK Tools标签**
   - 在SDK Manager窗口中，点击顶部的 `SDK Tools` 标签

4. **勾选以下工具**：
   - ✅ **Android SDK Build-Tools**（如果未安装）
   - ✅ **NDK (Side by side)** - 选择最新版本（推荐r25c或更高）
   - ✅ **CMake** - 选择最新版本（推荐3.22.1或更高）
   - ✅ **LLDB** - 用于调试（可选但推荐）

5. **安装**
   - 点击窗口右下角的 `Apply` 按钮
   - 在弹出的确认窗口中点击 `OK`
   - 等待下载和安装完成（可能需要几分钟，取决于网速）

6. **验证安装**
   - 安装完成后，在Android Studio中验证：
     - `File` > `Settings` > `Appearance & Behavior` > `System Settings` > `Android SDK`
     - 切换到 `SDK Tools` 标签
     - 确认 `CMake` 和 `NDK` 都已勾选并显示版本号
   
   **注意**：cmake命令在命令行中可能不可用，这是正常的。Android Studio会自动使用已安装的CMake来编译C++代码。
   
   **如果想在命令行使用cmake**：参考 `FIX_CMAKE_PATH.md` 中的说明

### 步骤4：打开项目

1. **在Android Studio中打开项目**
   - 点击 `File` > `Open`
   - 或者点击欢迎界面的 `Open`
   - 浏览到项目目录：`D:\python作业\mobile-cpp-app\android`
   - 选择 `android` 文件夹，点击 `OK`

2. **等待Gradle同步**
   - Android Studio会自动检测项目并开始同步
   - 首次同步可能需要下载Gradle和依赖，需要几分钟
   - 底部状态栏会显示同步进度
   - 如果提示需要安装Gradle，点击 `Install` 或 `Accept`

3. **检查同步结果**
   - 同步完成后，查看底部的 `Build` 窗口
   - 如果显示 "BUILD SUCCESSFUL"，说明项目配置正确
   - 如果有错误，请查看错误信息

### 步骤5：配置项目（如果需要）

1. **检查SDK Location**
   - 点击 `File` > `Project Structure` > `SDK Location`
   - 确认 `Android SDK location` 路径正确
   - 确认 `Android NDK location` 已自动检测到（或手动选择）

2. **检查Gradle配置**
   - 项目会自动使用 `android/app/build.gradle` 中的配置
   - 确保CMake路径配置正确（通常会自动检测）

### 步骤6：构建项目

#### 方法1：使用Android Studio（推荐）

1. **构建项目**
   - 点击顶部菜单：`Build` > `Make Project`
   - 或使用快捷键：`Ctrl + F9`
   - 等待构建完成

2. **查看构建结果**
   - 底部 `Build` 窗口会显示构建进度
   - 如果成功，会显示 "BUILD SUCCESSFUL"
   - 如果有错误，会显示具体错误信息

#### 方法2：使用命令行

在PowerShell中运行：

```powershell
cd D:\python作业\mobile-cpp-app\android
.\gradlew.bat assembleDebug
```

### 步骤7：运行应用

#### 准备设备或模拟器

**选项A：使用真实设备**
1. 在手机上启用"开发者选项"和"USB调试"
2. 用USB线连接手机到电脑
3. 在手机上允许USB调试
4. 在Android Studio中，设备列表会显示你的手机

**选项B：使用模拟器**
1. 在Android Studio中，点击 `Tools` > `Device Manager`
2. 点击 `Create Device`
3. 选择一个设备型号（如Pixel 5）
4. 选择一个系统镜像（推荐API 33或34）
5. 点击 `Finish` 创建
6. 启动模拟器

#### 运行应用

1. **选择运行目标**
   - 在Android Studio顶部工具栏，点击设备下拉菜单
   - 选择你的设备或模拟器

2. **运行应用**
   - 点击绿色的运行按钮 ▶️
   - 或使用快捷键：`Shift + F10`
   - 或点击 `Run` > `Run 'app'`

3. **查看结果**
   - 应用会自动安装到设备上并启动
   - 你应该看到应用界面显示：
     - 版本号：1.0.0
     - 计算结果：15（10 + 5）

## 🎉 成功标志

如果看到以下情况，说明一切正常：

1. ✅ Gradle同步成功（BUILD SUCCESSFUL）
2. ✅ 项目构建成功（无错误）
3. ✅ 应用成功安装到设备
4. ✅ 应用界面显示版本号和计算结果

## ⚠️ 常见问题

### Gradle同步失败

**问题**：网络连接问题或依赖下载失败

**解决方法**：
1. 检查网络连接
2. 如果在中国大陆，可能需要配置代理或使用镜像源
3. 在 `gradle.properties` 中添加：
   ```properties
   systemProp.http.proxyHost=127.0.0.1
   systemProp.http.proxyPort=10809
   systemProp.https.proxyHost=127.0.0.1
   systemProp.https.proxyPort=10809
   ```

### NDK未找到

**问题**：CMake找不到NDK

**解决方法**：
1. 确认NDK已安装（SDK Manager中检查）
2. 在 `File` > `Project Structure` > `SDK Location` 中手动指定NDK路径
3. 或在 `local.properties` 文件中添加：
   ```properties
   ndk.dir=C\:\\Users\\你的用户名\\AppData\\Local\\Android\\Sdk\\ndk\\版本号
   ```

### 构建错误：找不到C++文件

**问题**：CMakeLists.txt路径不正确

**解决方法**：
1. 检查 `android/app/src/main/cpp/CMakeLists.txt` 文件是否存在
2. 检查 `android/app/build.gradle` 中的CMake路径配置

## 📚 相关文档

- 详细安装指南：`INSTALL.md`
- 环境变量配置：`ANDROID_ENV_SETUP.md`
- 故障排除：`TROUBLESHOOTING.md`
- 快速开始：`QUICKSTART.md`

## 🚀 开始开发

环境搭建完成后，你可以：

1. 修改C++代码：`src/MobileApp.cpp`
2. 修改Android界面：`android/app/src/main/res/layout/activity_main.xml`
3. 添加新功能：参考 `README.md` 中的说明

祝你开发顺利！🎉

