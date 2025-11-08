# 修复路径非ASCII字符错误

## 问题说明

**错误信息**：
```
Your project path contains non-ASCII characters. 
This will most likely cause the build to fail
```

**原因**：项目路径 `D:\python作业\mobile-cpp-app\android` 包含中文字符"作业"，导致Gradle无法正常构建。

## 解决方案：移动项目到英文路径

### 方法1：移动整个项目（推荐）

#### 步骤1：关闭Android Studio

1. 完全关闭Android Studio
2. 确保没有文件被占用

#### 步骤2：移动项目文件夹

**从**：
```
D:\python作业\mobile-cpp-app
```

**移动到**（选择一个）：
```
D:\mobile-cpp-app
```
或
```
D:\projects\mobile-cpp-app
```
或
```
C:\Users\你的用户名\AndroidProjects\mobile-cpp-app
```

**操作步骤**：
1. 打开文件资源管理器
2. 导航到 `D:\python作业\`
3. 找到 `mobile-cpp-app` 文件夹
4. 右键点击 > `剪切`（或按 `Ctrl+X`）
5. 导航到目标位置（如 `D:\`）
6. 右键点击 > `粘贴`（或按 `Ctrl+V`）

#### 步骤3：重新打开项目

1. 启动Android Studio
2. 点击 `Open`
3. 选择新路径：`D:\mobile-cpp-app\android`
4. 点击 `OK`
5. 等待Gradle同步

### 方法2：只移动android项目（如果不想移动整个项目）

如果 `python作业` 文件夹中有其他重要文件，可以只移动android项目：

1. 在 `D:\` 创建新文件夹：`mobile-cpp-app`
2. 将 `mobile-cpp-app` 文件夹从 `D:\python作业\` 移动到 `D:\`
3. 在Android Studio中打开 `D:\mobile-cpp-app\android`

## 验证修复

移动项目后：

1. **打开项目**
   - 在Android Studio中打开新路径的项目
   - 路径应该是：`D:\mobile-cpp-app\android`（或你选择的其他英文路径）

2. **检查Gradle同步**
   - 应该不再有非ASCII字符错误
   - 底部Build窗口应该显示同步进度

3. **如果仍有问题**
   - 清理项目：`Build` > `Clean Project`
   - 重新同步：`File` > `Sync Project with Gradle Files`

## 推荐路径结构

```
D:\
└── mobile-cpp-app\
    ├── android\
    ├── ios\
    ├── include\
    ├── src\
    └── README.md
```

或

```
D:\projects\
└── mobile-cpp-app\
    ├── android\
    ├── ios\
    ├── include\
    ├── src\
    └── README.md
```

## 注意事项

1. **Git仓库**（如果有）：
   - 移动后，Git仓库仍然有效
   - 不需要重新初始化

2. **Android Studio设置**：
   - 可能需要重新打开项目
   - 之前的缓存会被清理

3. **其他工具**：
   - 如果有其他工具引用了旧路径，需要更新配置

## 如果无法移动项目

如果因为某些原因无法移动项目，可以尝试：

1. **使用符号链接**（高级，不推荐）：
   ```cmd
   mklink /D D:\mobile-cpp-app D:\python作业\mobile-cpp-app
   ```
   然后在Android Studio中打开 `D:\mobile-cpp-app\android`

2. **配置Gradle**（可能无效）：
   在 `gradle.properties` 中添加：
   ```properties
   org.gradle.jvmargs=-Dfile.encoding=UTF-8
   ```
   但这种方法可能无法完全解决问题。

## 快速操作步骤

1. ✅ 关闭Android Studio
2. ✅ 移动 `mobile-cpp-app` 文件夹到英文路径（如 `D:\mobile-cpp-app`）
3. ✅ 重新打开Android Studio
4. ✅ 打开新路径的项目：`D:\mobile-cpp-app\android`
5. ✅ 等待Gradle同步完成

## 总结

**必须操作**：将项目移动到不包含中文的路径。

**推荐路径**：
- `D:\mobile-cpp-app\android`
- `D:\projects\mobile-cpp-app\android`
- `C:\Users\你的用户名\AndroidProjects\mobile-cpp-app\android`

移动后，所有错误应该都会解决！

