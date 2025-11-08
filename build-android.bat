@echo off
REM Android构建脚本 (Windows)

echo 开始构建Android应用...

cd android

REM 检查是否安装了Android SDK
if "%ANDROID_HOME%"=="" (
    echo 错误: 请设置ANDROID_HOME环境变量
    exit /b 1
)

REM 清理并构建
call gradlew.bat clean
call gradlew.bat assembleDebug

echo 构建完成！APK文件位置: app\build\outputs\apk\debug\app-debug.apk

