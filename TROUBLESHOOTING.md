# 故障排除指南

## 问题：adb命令无法识别

### 错误信息
```
adb : 无法将"adb"项识别为 cmdlet、函数、脚本文件或可运行程序的名称
```

### 排查步骤

#### 步骤1：检查ANDROID_HOME是否设置

在PowerShell中运行：
```powershell
echo $env:ANDROID_HOME
```

**如果显示为空**：
- 说明ANDROID_HOME环境变量没有设置或没有生效
- 请重新配置环境变量（参考ANDROID_ENV_SETUP.md）
- **重要**：配置后必须关闭所有PowerShell窗口并重新打开

**如果显示了路径**：
- 继续下一步检查

#### 步骤2：验证SDK路径是否正确

在PowerShell中运行：
```powershell
# 检查platform-tools文件夹是否存在
Test-Path "$env:ANDROID_HOME\platform-tools\adb.exe"
```

**如果返回 False**：
- 说明路径不正确或adb.exe不存在
- 需要找到正确的SDK路径

**如果返回 True**：
- 说明文件存在，但Path环境变量可能有问题
- 继续步骤3

#### 步骤3：手动测试adb.exe

在PowerShell中运行：
```powershell
# 使用完整路径直接运行
& "$env:ANDROID_HOME\platform-tools\adb.exe" version
```

**如果这个命令可以运行**：
- 说明adb.exe存在且可用
- 问题是Path环境变量配置不正确
- 解决方法见下方

**如果这个命令也无法运行**：
- 说明SDK路径不正确或adb.exe不存在
- 需要重新查找SDK路径

#### 步骤4：检查Path环境变量

在PowerShell中运行：
```powershell
# 查看当前Path环境变量
$env:Path -split ';' | Select-String -Pattern "Android|platform-tools"
```

**如果没有显示任何Android相关路径**：
- Path环境变量中没有添加Android路径
- 需要重新配置Path变量

### 解决方案

#### 方案1：重新配置环境变量（推荐）

1. **找到正确的SDK路径**：
   - 打开Android Studio
   - `File` > `Settings` > `Appearance & Behavior` > `System Settings` > `Android SDK`
   - 复制 **Android SDK Location** 显示的完整路径

2. **重新设置环境变量**：
   - 右键"此电脑" > "属性" > "高级系统设置" > "环境变量"
   - 检查 `ANDROID_HOME` 变量值是否与Android Studio中显示的路径完全一致
   - 如果不一致，修改为正确路径

3. **检查Path变量**：
   - 在系统变量中找到 `Path`
   - 确保包含：`%ANDROID_HOME%\platform-tools`
   - 如果没有，添加它

4. **完全重启**：
   - **关闭所有PowerShell和命令提示符窗口**
   - 如果可能，重启电脑（最保险）
   - 重新打开PowerShell测试

#### 方案2：使用完整路径（临时解决）

如果急需使用adb，可以直接使用完整路径：

```powershell
# 替换为你的实际SDK路径
$sdkPath = "C:\Users\你的用户名\AppData\Local\Android\Sdk"
& "$sdkPath\platform-tools\adb.exe" version
```

或者创建别名：
```powershell
# 在PowerShell配置文件中添加（临时）
$env:Path += ";$env:ANDROID_HOME\platform-tools"
```

#### 方案3：验证SDK安装

如果platform-tools文件夹不存在：

1. 打开Android Studio
2. `Tools` > `SDK Manager`
3. 切换到 `SDK Tools` 标签
4. 确保勾选了 **Android SDK Platform-Tools**
5. 点击 `Apply` 安装

### 快速诊断脚本

将以下脚本保存为 `check-android-env.ps1` 并运行：

```powershell
Write-Host "=== Android环境诊断 ===" -ForegroundColor Cyan

# 检查ANDROID_HOME
Write-Host "`n1. 检查ANDROID_HOME:" -ForegroundColor Yellow
if ($env:ANDROID_HOME) {
    Write-Host "   ✓ ANDROID_HOME = $env:ANDROID_HOME" -ForegroundColor Green
} else {
    Write-Host "   ✗ ANDROID_HOME 未设置" -ForegroundColor Red
    exit
}

# 检查platform-tools
Write-Host "`n2. 检查platform-tools文件夹:" -ForegroundColor Yellow
$platformTools = "$env:ANDROID_HOME\platform-tools"
if (Test-Path $platformTools) {
    Write-Host "   ✓ platform-tools 存在: $platformTools" -ForegroundColor Green
} else {
    Write-Host "   ✗ platform-tools 不存在: $platformTools" -ForegroundColor Red
    Write-Host "   请检查SDK路径是否正确" -ForegroundColor Red
    exit
}

# 检查adb.exe
Write-Host "`n3. 检查adb.exe:" -ForegroundColor Yellow
$adbPath = "$platformTools\adb.exe"
if (Test-Path $adbPath) {
    Write-Host "   ✓ adb.exe 存在" -ForegroundColor Green
} else {
    Write-Host "   ✗ adb.exe 不存在" -ForegroundColor Red
    Write-Host "   请安装Android SDK Platform-Tools" -ForegroundColor Red
    exit
}

# 检查Path环境变量
Write-Host "`n4. 检查Path环境变量:" -ForegroundColor Yellow
$pathContains = $env:Path -like "*platform-tools*"
if ($pathContains) {
    Write-Host "   ✓ Path包含platform-tools" -ForegroundColor Green
} else {
    Write-Host "   ✗ Path不包含platform-tools" -ForegroundColor Red
    Write-Host "   需要添加: %ANDROID_HOME%\platform-tools 到Path变量" -ForegroundColor Red
}

# 测试adb命令
Write-Host "`n5. 测试adb命令:" -ForegroundColor Yellow
try {
    $adbVersion = & "$adbPath" version 2>&1
    Write-Host "   ✓ adb可以运行" -ForegroundColor Green
    Write-Host "   版本信息: $($adbVersion[0])" -ForegroundColor Gray
} catch {
    Write-Host "   ✗ adb无法运行: $_" -ForegroundColor Red
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan
```

### 常见问题

**Q: 为什么配置了环境变量还是不生效？**
A: 环境变量只在新的进程启动时加载。必须：
1. 关闭所有已打开的命令行窗口
2. 重新打开PowerShell/CMD
3. 如果还不行，重启电脑

**Q: 如何确认SDK路径是否正确？**
A: 在文件资源管理器中打开该路径，应该能看到：
- `platform-tools` 文件夹
- `build-tools` 文件夹
- `platforms` 文件夹

**Q: Path变量中应该使用绝对路径还是%ANDROID_HOME%？**
A: 推荐使用 `%ANDROID_HOME%\platform-tools`，这样更灵活。如果SDK路径改变，只需修改ANDROID_HOME即可。

**Q: 用户变量和系统变量有什么区别？**
A: 
- **系统变量**：对所有用户生效（推荐）
- **用户变量**：只对当前用户生效

建议使用系统变量，这样所有用户都可以使用。

