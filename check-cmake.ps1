# CMake诊断脚本
# 使用方法：在PowerShell中运行 .\check-cmake.ps1

Write-Host "=== CMake诊断 ===" -ForegroundColor Cyan

# 检查ANDROID_HOME
if (-not $env:ANDROID_HOME) {
    Write-Host "`n✗ ANDROID_HOME 未设置" -ForegroundColor Red
    Write-Host "请先配置ANDROID_HOME环境变量" -ForegroundColor Yellow
    exit
}

Write-Host "`nANDROID_HOME = $env:ANDROID_HOME" -ForegroundColor Gray

# 查找CMake安装位置
Write-Host "`n1. 查找CMake安装位置..." -ForegroundColor Yellow
$cmakeBasePath = "$env:ANDROID_HOME\cmake"

if (Test-Path $cmakeBasePath) {
    $cmakeDirs = Get-ChildItem -Path $cmakeBasePath -Directory -ErrorAction SilentlyContinue
    
    if ($cmakeDirs) {
        Write-Host "   ✓ 找到CMake安装目录" -ForegroundColor Green
        $foundVersions = @()
        
        foreach ($dir in $cmakeDirs) {
            $cmakeExe = Join-Path $dir.FullName "bin\cmake.exe"
            if (Test-Path $cmakeExe) {
                $version = $dir.Name
                $binPath = "$($dir.FullName)\bin"
                $foundVersions += @{
                    Version = $version
                    Path = $binPath
                }
                Write-Host "   - 版本 $version" -ForegroundColor Gray
                Write-Host "     路径: $binPath" -ForegroundColor DarkGray
            }
        }
        
        if ($foundVersions.Count -gt 0) {
            Write-Host "`n   建议添加到Path的路径:" -ForegroundColor Yellow
            $latest = $foundVersions | Sort-Object {[Version]$_.Version} -Descending | Select-Object -First 1
            Write-Host "   $($latest.Path)" -ForegroundColor Cyan
        }
    } else {
        Write-Host "   ✗ CMake目录为空" -ForegroundColor Red
    }
} else {
    Write-Host "   ✗ 未找到CMake安装目录: $cmakeBasePath" -ForegroundColor Red
    Write-Host "   请确保已在Android Studio中安装CMake" -ForegroundColor Yellow
    Write-Host "   方法: Android Studio > Tools > SDK Manager > SDK Tools > CMake" -ForegroundColor Yellow
}

# 检查Path中是否包含cmake
Write-Host "`n2. 检查Path环境变量..." -ForegroundColor Yellow
$pathContains = $env:Path -like "*cmake*"
if ($pathContains) {
    Write-Host "   ✓ Path中包含cmake路径" -ForegroundColor Green
    $cmakePaths = $env:Path -split ';' | Where-Object { $_ -like "*cmake*" }
    foreach ($path in $cmakePaths) {
        Write-Host "     - $path" -ForegroundColor Gray
    }
} else {
    Write-Host "   ✗ Path中不包含cmake路径" -ForegroundColor Red
    Write-Host "   需要将CMake的bin目录添加到Path环境变量" -ForegroundColor Yellow
}

# 测试cmake命令
Write-Host "`n3. 测试cmake命令..." -ForegroundColor Yellow
try {
    $cmakeVersion = cmake --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ cmake命令可用" -ForegroundColor Green
        Write-Host "   版本信息: $($cmakeVersion[0])" -ForegroundColor Gray
    } else {
        Write-Host "   ✗ cmake命令执行失败" -ForegroundColor Red
    }
} catch {
    Write-Host "   ✗ cmake命令不可用" -ForegroundColor Red
    Write-Host "   错误: $_" -ForegroundColor DarkGray
}

# 提供解决方案
Write-Host "`n=== 诊断结果和建议 ===" -ForegroundColor Cyan

if (-not (Test-Path $cmakeBasePath)) {
    Write-Host "`n⚠️  问题：CMake未安装" -ForegroundColor Yellow
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 打开Android Studio" -ForegroundColor White
    Write-Host "2. Tools > SDK Manager > SDK Tools" -ForegroundColor White
    Write-Host "3. 勾选 CMake，点击 Apply 安装" -ForegroundColor White
} elseif (-not $pathContains) {
    Write-Host "`n⚠️  问题：CMake已安装但未添加到Path" -ForegroundColor Yellow
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 右键'此电脑' > 属性 > 高级系统设置 > 环境变量" -ForegroundColor White
    Write-Host "2. 在系统变量中找到Path，点击编辑" -ForegroundColor White
    Write-Host "3. 点击新建，添加CMake的bin目录路径" -ForegroundColor White
    Write-Host "4. 关闭所有命令行窗口，重新打开PowerShell测试" -ForegroundColor White
    Write-Host "`n注意：对于Android开发，不一定需要命令行cmake命令" -ForegroundColor Cyan
    Write-Host "Android Studio会自动使用已安装的CMake来编译C++代码" -ForegroundColor Cyan
} else {
    Write-Host "`n✓ CMake配置正常" -ForegroundColor Green
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan

