# Android环境变量配置详细指南（Windows）

## 第一步：找到Android SDK安装路径

### 方法1：通过Android Studio查找

1. 打开Android Studio
2. 点击 `File` > `Settings`（或按 `Ctrl+Alt+S`）
3. 在左侧选择 `Appearance & Behavior` > `System Settings` > `Android SDK`
4. 查看 **Android SDK Location** 显示的路径
   - 通常是：`C:\Users\你的用户名\AppData\Local\Android\Sdk`

### 方法2：手动查找

Android SDK默认安装在以下位置之一：
- `C:\Users\你的用户名\AppData\Local\Android\Sdk`
- `C:\Android\Sdk`
- `D:\Android\Sdk`

**提示**：如果找不到，可以在文件资源管理器中搜索 "Sdk" 文件夹。

## 第二步：配置环境变量

### 详细步骤

#### 1. 打开环境变量设置

**方法A：通过系统属性**
1. 右键点击 **"此电脑"** 或 **"我的电脑"**
2. 选择 **"属性"**
3. 点击左侧的 **"高级系统设置"**
4. 在弹出的窗口中，点击 **"环境变量"** 按钮

**方法B：通过运行命令**
1. 按 `Win + R` 打开运行对话框
2. 输入：`sysdm.cpl`
3. 按回车
4. 切换到 **"高级"** 标签
5. 点击 **"环境变量"** 按钮

**方法C：直接搜索**
1. 按 `Win` 键
2. 搜索 "环境变量"
3. 选择 **"编辑系统环境变量"**

#### 2. 添加 ANDROID_HOME 变量

在 **"系统变量"** 区域（下半部分）：

1. 点击 **"新建"** 按钮
2. 变量名输入：`ANDROID_HOME`
3. 变量值输入：你的Android SDK路径
   - 例如：`C:\Users\张三\AppData\Local\Android\Sdk`
4. 点击 **"确定"**

#### 3. 编辑 Path 变量

在 **"系统变量"** 区域找到 `Path` 变量：

1. 选中 `Path` 变量
2. 点击 **"编辑"** 按钮
3. 点击 **"新建"** 添加以下路径（每行一个）：
   ```
   %ANDROID_HOME%\platform-tools
   %ANDROID_HOME%\tools
   %ANDROID_HOME%\tools\bin
   %ANDROID_HOME%\emulator
   ```
4. 点击 **"确定"** 保存每个路径
5. 最后点击 **"确定"** 关闭所有窗口

**重要提示**：
- 使用 `%ANDROID_HOME%` 而不是直接写完整路径，这样更灵活
- 如果某些路径不存在（如emulator），可以暂时不添加

## 第三步：验证配置

### 方法1：使用PowerShell验证

1. **关闭所有已打开的PowerShell或命令提示符窗口**（重要！）
2. 重新打开PowerShell：
   - 按 `Win + X`
   - 选择 **"Windows PowerShell"** 或 **"终端"**
3. 依次运行以下命令：

```powershell
# 检查ANDROID_HOME
echo $env:ANDROID_HOME

# 检查adb（Android调试桥）
adb version

# 检查Android SDK路径
echo $env:ANDROID_HOME
```

**预期结果**：
- `adb version` 应该显示版本号，例如：`Android Debug Bridge version 1.0.41`

### 方法2：使用命令提示符验证

1. 按 `Win + R`
2. 输入 `cmd` 并按回车
3. 运行：

```batch
echo %ANDROID_HOME%
adb version
```

### 方法3：在Android Studio中验证

1. 打开Android Studio
2. 点击 `File` > `Settings`
3. 选择 `Appearance & Behavior` > `System Settings` > `Android SDK`
4. 查看SDK路径是否正确显示

## 常见问题解决

### 问题1：提示"adb不是内部或外部命令"

**原因**：环境变量未生效或路径错误

**解决方法**：
1. 确保已关闭所有命令行窗口并重新打开
2. 检查 `%ANDROID_HOME%\platform-tools` 路径是否存在
3. 如果不存在，检查Android SDK是否正确安装

### 问题2：找不到ANDROID_HOME路径

**解决方法**：
1. 打开Android Studio
2. `File` > `Settings` > `Appearance & Behavior` > `System Settings` > `Android SDK`
3. 查看 **Android SDK Location**，复制该路径

### 问题3：环境变量设置后仍不生效

**解决方法**：
1. **完全关闭**所有命令行窗口
2. **注销或重启**Windows系统
3. 重新打开命令行测试

### 问题4：权限不足无法修改系统变量

**解决方法**：
1. 右键点击"此电脑" > "属性" > "高级系统设置"
2. 确保以管理员身份运行
3. 或者只设置用户变量（在"用户变量"区域设置，只对当前用户有效）

## 完整的环境变量列表

### 系统变量（推荐）

| 变量名 | 变量值 | 说明 |
|--------|-------|------|
| `ANDROID_HOME` | `C:\Users\你的用户名\AppData\Local\Android\Sdk` | Android SDK根目录 |

### Path变量中添加的路径

| 路径 | 说明 |
|------|------|
| `%ANDROID_HOME%\platform-tools` | adb等工具（必需） |
| `%ANDROID_HOME%\tools` | SDK工具（可选） |
| `%ANDROID_HOME%\tools\bin` | SDK工具bin目录（可选） |
| `%ANDROID_HOME%\emulator` | 模拟器工具（如果使用模拟器） |

## 快速配置脚本（可选）

如果你熟悉PowerShell，可以使用以下脚本快速配置：

```powershell
# 以管理员身份运行PowerShell
$sdkPath = "$env:LOCALAPPDATA\Android\Sdk"

# 设置ANDROID_HOME
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "Machine")

# 添加到Path
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$newPaths = @(
    "$sdkPath\platform-tools",
    "$sdkPath\tools",
    "$sdkPath\tools\bin"
)

foreach ($newPath in $newPaths) {
    if ($currentPath -notlike "*$newPath*") {
        $currentPath += ";$newPath"
    }
}

[System.Environment]::SetEnvironmentVariable("Path", $currentPath, "Machine")
Write-Host "环境变量配置完成！请重新打开命令行窗口。"
```

## 下一步

环境变量配置完成后，继续：

1. ✅ 验证环境变量（已完成）
2. 在Android Studio中打开项目
3. 安装NDK和CMake
4. 构建和运行应用

详细步骤请参考 `INSTALL.md` 文件。

