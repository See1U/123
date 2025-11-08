#!/bin/bash
# Android构建脚本

echo "开始构建Android应用..."

cd android

# 检查是否安装了Android SDK
if [ -z "$ANDROID_HOME" ]; then
    echo "错误: 请设置ANDROID_HOME环境变量"
    exit 1
fi

# 清理并构建
./gradlew clean
./gradlew assembleDebug

echo "构建完成！APK文件位置: app/build/outputs/apk/debug/app-debug.apk"

