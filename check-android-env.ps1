# Android环境诊断脚本
# 使用方法：在PowerShell中运行 .\check-android-env.ps1

Write-Host "=== Android环境诊断 ===" -ForegroundColor Cyan

# 检查ANDROID_HOME
Write-Host "`n1. 检查ANDROID_HOME:" -ForegroundColor Yellow
if ($env:ANDROID_HOME) {
    Write-Host "   ✓ ANDROID_HOME = $env:ANDROID_HOME" -ForegroundColor Green
} else {
    Write-Host "   ✗ ANDROID_HOME 未设置" -ForegroundColor Red
    Write-Host "   请按照ANDROID_ENV_SETUP.md中的步骤配置环境变量" -ForegroundColor Red
    exit
}

# 检查platform-tools
Write-Host "`n2. 检查platform-tools文件夹:" -ForegroundColor Yellow
$platformTools = "$env:ANDROID_HOME\platform-tools"
if (Test-Path $platformTools) {
    Write-Host "   ✓ platform-tools 存在: $platformTools" -ForegroundColor Green
} else {
    Write-Host "   ✗ platform-tools 不存在: $platformTools" -ForegroundColor Red
    Write-Host "   请检查SDK路径是否正确，或在Android Studio中安装Platform-Tools" -ForegroundColor Red
    Write-Host "   路径查找方法：Android Studio > File > Settings > Android SDK" -ForegroundColor Yellow
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
    Write-Host "   方法：Android Studio > Tools > SDK Manager > SDK Tools > Android SDK Platform-Tools" -ForegroundColor Yellow
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
    Write-Host "   方法：系统属性 > 环境变量 > 系统变量 > Path > 编辑 > 新建" -ForegroundColor Yellow
}

# 测试adb命令
Write-Host "`n5. 测试adb命令:" -ForegroundColor Yellow
try {
    $adbVersion = & "$adbPath" version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ adb可以运行" -ForegroundColor Green
        Write-Host "   版本信息: $($adbVersion[0])" -ForegroundColor Gray
    } else {
        Write-Host "   ✗ adb执行失败" -ForegroundColor Red
        Write-Host "   错误: $adbVersion" -ForegroundColor Red
    }
} catch {
    Write-Host "   ✗ adb无法运行: $_" -ForegroundColor Red
}

# 提供解决方案
Write-Host "`n=== 诊断结果和建议 ===" -ForegroundColor Cyan
if (-not $pathContains) {
    Write-Host "`n⚠️  问题：Path环境变量未包含platform-tools" -ForegroundColor Yellow
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 右键'此电脑' > 属性 > 高级系统设置 > 环境变量" -ForegroundColor White
    Write-Host "2. 在系统变量中找到Path，点击编辑" -ForegroundColor White
    Write-Host "3. 点击新建，添加: %ANDROID_HOME%\platform-tools" -ForegroundColor White
    Write-Host "4. 确定保存，关闭所有命令行窗口，重新打开PowerShell测试" -ForegroundColor White
} else {
    Write-Host "`n✓ 环境变量配置看起来正确" -ForegroundColor Green
    Write-Host "如果adb命令仍无法识别，请：" -ForegroundColor Yellow
    Write-Host "1. 完全关闭所有PowerShell和命令提示符窗口" -ForegroundColor White
    Write-Host "2. 重新打开PowerShell测试" -ForegroundColor White
    Write-Host "3. 如果还不行，重启电脑" -ForegroundColor White
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan

