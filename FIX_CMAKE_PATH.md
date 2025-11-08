# 解决CMake命令无法识别的问题

## 问题说明

CMake可能已经通过Android Studio安装了，但它的路径没有被添加到系统的Path环境变量中，所以无法在命令行直接使用。

**重要提示**：对于Android开发，CMake主要在Android Studio内部使用，不一定需要在命令行中直接使用。但如果你想在命令行使用，可以按以下方法配置。

## 解决方案

### 方案1：找到CMake路径并添加到Path（推荐，如果想在命令行使用）

#### 步骤1：找到CMake安装路径

CMake通常安装在Android SDK目录下：

```
C:\Users\你的用户名\AppData\Local\Android\Sdk\cmake\版本号\bin
```

**查找方法A：通过文件资源管理器**
1. 打开文件资源管理器
2. 导航到：`C:\Users\你的用户名\AppData\Local\Android\Sdk\cmake`
3. 你会看到一个或多个版本号文件夹（如 `3.22.1`）
4. 进入版本号文件夹，再进入 `bin` 文件夹
5. 确认里面有 `cmake.exe` 文件
6. 复制这个bin文件夹的完整路径

**查找方法B：通过PowerShell**
```powershell
# 查找cmake.exe
Get-ChildItem -Path "$env:ANDROID_HOME\cmake" -Recurse -Filter "cmake.exe" | Select-Object FullName
```

**查找方法C：通过Android Studio**
1. 打开Android Studio
2. `File` > `Settings` > `Appearance & Behavior` > `System Settings` > `Android SDK`
3. 切换到 `SDK Tools` 标签
4. 找到 `CMake`，查看右侧显示的路径

#### 步骤2：添加到Path环境变量

1. **打开环境变量设置**
   - 右键"此电脑" > "属性" > "高级系统设置" > "环境变量"

2. **编辑Path变量**
   - 在系统变量中找到 `Path`
   - 点击"编辑"

3. **添加CMake路径**
   - 点击"新建"
   - 输入CMake的bin目录路径，例如：
     ```
     C:\Users\你的用户名\AppData\Local\Android\Sdk\cmake\3.22.1\bin
     ```
   - 点击"确定"

4. **重启PowerShell**
   - 关闭所有PowerShell窗口
   - 重新打开PowerShell
   - 运行 `cmake --version` 验证

### 方案2：使用完整路径验证（临时方案）

如果不想修改环境变量，可以直接使用完整路径：

```powershell
# 替换为你的实际路径
$cmakePath = "C:\Users\你的用户名\AppData\Local\Android\Sdk\cmake\3.22.1\bin\cmake.exe"
& $cmakePath --version
```

### 方案3：不需要命令行CMake（推荐用于Android开发）

**重要**：对于Android C++开发，CMake主要在Android Studio内部使用。你不需要在命令行中直接使用cmake命令。

**验证CMake是否已安装（在Android Studio中）**：
1. 打开Android Studio
2. `File` > `Settings` > `Appearance & Behavior` > `System Settings` > `Android SDK`
3. 切换到 `SDK Tools` 标签
4. 查看 `CMake` 是否已勾选并显示版本号
5. 如果已勾选，说明CMake已安装，可以直接使用

## 快速诊断脚本

将以下脚本保存为 `check-cmake.ps1` 并运行：

```powershell
Write-Host "=== CMake诊断 ===" -ForegroundColor Cyan

# 检查ANDROID_HOME
if (-not $env:ANDROID_HOME) {
    Write-Host "✗ ANDROID_HOME 未设置" -ForegroundColor Red
    exit
}

Write-Host "`n查找CMake安装位置..." -ForegroundColor Yellow
$cmakeDirs = Get-ChildItem -Path "$env:ANDROID_HOME\cmake" -Directory -ErrorAction SilentlyContinue

if ($cmakeDirs) {
    Write-Host "✓ 找到CMake安装目录:" -ForegroundColor Green
    foreach ($dir in $cmakeDirs) {
        $cmakeExe = Join-Path $dir.FullName "bin\cmake.exe"
        if (Test-Path $cmakeExe) {
            Write-Host "  - $($dir.Name): $($dir.FullName)\bin" -ForegroundColor Gray
            Write-Host "    建议添加到Path: $($dir.FullName)\bin" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "✗ 未找到CMake安装目录" -ForegroundColor Red
    Write-Host "  请确保已在Android Studio中安装CMake" -ForegroundColor Yellow
    Write-Host "  方法: Tools > SDK Manager > SDK Tools > CMake" -ForegroundColor Yellow
}

# 检查Path中是否包含cmake
Write-Host "`n检查Path环境变量..." -ForegroundColor Yellow
$pathContains = $env:Path -like "*cmake*"
if ($pathContains) {
    Write-Host "✓ Path中包含cmake路径" -ForegroundColor Green
} else {
    Write-Host "✗ Path中不包含cmake路径" -ForegroundColor Red
    Write-Host "  需要将CMake的bin目录添加到Path" -ForegroundColor Yellow
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan
```

## 验证CMake是否已安装（Android Studio方式）

这是最可靠的方法：

1. **打开Android Studio**
2. **打开SDK Manager**
   - `Tools` > `SDK Manager`
3. **检查CMake**
   - 切换到 `SDK Tools` 标签
   - 查看 `CMake` 是否已勾选
   - 如果已勾选，说明已安装
4. **如果未安装**
   - 勾选 `CMake`
   - 点击 `Apply` 安装

## 重要提示

### 对于Android开发

**你不需要在命令行中使用cmake命令！**

Android Studio会自动使用CMake来编译C++代码。只要：
1. ✅ 在SDK Manager中安装了CMake
2. ✅ 在Android Studio中打开了项目
3. ✅ Gradle配置正确（项目已配置好）

就可以正常构建项目了。

### 什么时候需要命令行CMake？

只有在以下情况才需要：
- 想要在命令行中手动构建项目
- 使用CI/CD系统
- 需要调试CMake配置

对于日常开发，Android Studio会自动处理一切。

## 下一步

即使cmake命令在命令行中不可用，你也可以：

1. **继续在Android Studio中开发**
   - CMake会在Android Studio内部自动使用
   - 不需要命令行cmake命令

2. **打开项目**
   - `File` > `Open` > 选择 `android` 文件夹
   - Android Studio会自动检测并使用CMake

3. **构建项目**
   - `Build` > `Make Project`
   - Android Studio会使用已安装的CMake编译C++代码

## 总结

- ✅ **CMake已通过Android Studio安装** → 可以直接使用，无需命令行
- ⚠️ **想在命令行使用cmake** → 需要添加到Path环境变量
- 🎯 **继续开发** → 不需要命令行cmake，Android Studio会自动处理

