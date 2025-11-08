# 在Android Studio中打开项目

## 当前问题

你打开的是"My Application"项目，这是Android Studio的默认示例项目，不是我们的C++移动应用项目。

## 正确打开项目的方法

### 方法1：关闭当前项目并打开新项目（推荐）

1. **关闭当前项目**
   - 点击 `File` > `Close Project`
   - 或者直接关闭Android Studio窗口

2. **打开我们的项目**
   - 在欢迎界面，点击 `Open`
   - 或者点击 `File` > `Open`
   - 浏览到项目目录：`D:\python作业\mobile-cpp-app\android`
   - **重要**：选择 `android` 文件夹（不是 `mobile-cpp-app` 文件夹）
   - 点击 `OK`

3. **等待Gradle同步**
   - Android Studio会自动检测项目并开始同步
   - 底部状态栏会显示同步进度
   - 首次同步可能需要几分钟

### 方法2：在当前窗口中打开

1. **打开项目**
   - 点击 `File` > `Open`
   - 浏览到：`D:\python作业\mobile-cpp-app\android`
   - 选择 `android` 文件夹
   - 点击 `OK`

2. **如果提示**
   - 选择 "Open in New Window" 或 "Open in Current Window"
   - 建议选择 "Open in New Window" 以避免混淆

## 验证项目是否正确打开

打开项目后，检查以下内容：

### 1. 项目结构

在左侧项目面板中，应该看到：

```
android
├── app
│   ├── src
│   │   └── main
│   │       ├── java
│   │       │   └── com
│   │       │       └── mobileapp
│   │       │           └── MainActivity.java  ← 应该看到这个
│   │       ├── cpp
│   │       │   └── CMakeLists.txt  ← 应该看到这个（C++相关）
│   │       ├── res
│   │       └── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
└── settings.gradle
```

**关键检查点**：
- ✅ 应该看到 `cpp` 文件夹（包含CMakeLists.txt）
- ✅ 应该看到 `com.mobileapp.MainActivity`（不是默认的MainActivity）
- ✅ 项目名称应该是 "MobileCppApp" 或类似名称

### 2. Gradle同步状态

查看底部状态栏：
- 如果显示 "Gradle sync in progress..." → 等待完成
- 如果显示 "Gradle sync finished" → 同步成功
- 如果有错误 → 查看错误信息

### 3. 检查CMake配置

1. 打开 `app/build.gradle` 文件
2. 应该看到 `externalNativeBuild` 配置：
   ```gradle
   externalNativeBuild {
       cmake {
           path file('src/main/cpp/CMakeLists.txt')
           version '3.22.1'
       }
   }
   ```

## 如果打开后显示错误

### 错误1：Gradle同步失败

**可能原因**：
- 网络问题
- Gradle版本不匹配
- 依赖下载失败

**解决方法**：
1. 检查网络连接
2. 点击 `File` > `Invalidate Caches / Restart` > `Invalidate and Restart`
3. 等待重新同步

### 错误2：找不到CMakeLists.txt

**解决方法**：
1. 确认打开了正确的 `android` 文件夹
2. 检查 `app/src/main/cpp/CMakeLists.txt` 文件是否存在
3. 如果不存在，检查项目文件是否完整

### 错误3：NDK未找到

**解决方法**：
1. `File` > `Project Structure` > `SDK Location`
2. 确认 `Android NDK location` 已设置
3. 如果未设置，在 `SDK Manager` 中安装NDK

## 正确的项目路径

确保打开的是这个路径：
```
D:\python作业\mobile-cpp-app\android
```

**不是**：
- ❌ `D:\python作业\mobile-cpp-app` （这是父目录）
- ❌ `D:\python作业` （这是工作目录）
- ❌ Android Studio的默认示例项目

## 快速检查清单

打开项目后，确认：

- [ ] 项目名称不是"My Application"
- [ ] 能看到 `app/src/main/cpp` 文件夹
- [ ] 能看到 `com.mobileapp.MainActivity.java`
- [ ] Gradle同步成功（无错误）
- [ ] `app/build.gradle` 中有 `externalNativeBuild` 配置

## 下一步

项目正确打开后：

1. **等待Gradle同步完成**
2. **构建项目**：`Build` > `Make Project`
3. **运行应用**：连接设备或启动模拟器，点击运行按钮

## 需要帮助？

如果打开项目后仍有问题，请告诉我：
1. 项目结构显示了什么？
2. Gradle同步是否成功？
3. 是否有任何错误信息？

