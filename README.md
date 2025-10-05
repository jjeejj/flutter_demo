# Flutter Demo Project

这是一个基于 Flutter 的演示项目，展示了现代 Flutter 应用开发的最佳实践，包含完整的状态管理、路由管理和数据库操作。

## 🚀 项目特性

### 架构特性
- **Clean Architecture**: 采用分层架构，代码结构清晰
- **Feature-First**: 按功能模块组织代码
- **Riverpod**: 使用 Riverpod 进行状态管理
- **Go Router**: 使用 Go Router 进行路由管理
- **Floor**: 使用 Floor 进行本地数据库操作

### UI/UX 特性
- **Material Design 3**: 支持最新的 Material Design 规范
- **主题切换**: 支持亮色/暗色/系统主题
- **响应式设计**: 适配不同屏幕尺寸
- **现代化界面**: 美观的用户界面设计

## 📁 项目结构

```
lib/
├── core/                    # 核心功能模块
│   ├── database/           # 数据库相关 (Floor)
│   ├── providers/          # 全局状态管理 (Riverpod)
│   └── routing/            # 路由配置 (Go Router)
├── features/               # 功能模块
│   ├── app/               # 主应用功能
│   │   ├── pages/         # 应用页面 (首页、配置、编写)
│   │   └── providers/     # 应用状态管理
│   ├── camera/            # 相机功能
│   ├── animation/         # 动画示例
│   └── demo_examples/     # 其他演示示例
├── shared/                # 共享模块
│   ├── models/           # 数据模型
│   ├── theme/            # 主题配置
│   ├── utils/            # 工具类
│   └── widgets/          # 通用组件
└── main.dart            # 应用入口
```

## 📱 主要功能

- 🏠 **首页**: 应用主页面，展示功能入口
- ⚙️ **配置页面**: 应用设置和主题配置
- ✍️ **内容编写**: 支持创建和编辑内容
- 📷 **相机功能**: 相机拍摄和视频播放
- 🎨 **动画效果**: 各种动画演示
- 🗄️ **数据库操作**: Floor 数据库示例
- 🎯 **状态管理**: Riverpod 状态管理示例

## 🛠 技术栈

### 核心依赖
- **Flutter**: 3.x
- **Dart**: 3.x
- **flutter_riverpod**: ^2.4.9 - 状态管理
- **go_router**: ^12.1.3 - 路由管理
- **floor**: ^1.5.0 - 本地数据库

### UI 组件
- **cupertino_icons**: ^1.0.2 - iOS 风格图标
- **flutter_svg**: ^2.0.9 - SVG 图片支持

### 工具库
- **shared_preferences**: ^2.2.2 - 本地存储
- **path_provider**: ^2.1.2 - 路径获取
- **camera**: ^0.10.5+9 - 相机功能
- **video_player**: ^2.8.2 - 视频播放

### 开发工具
- **flutter_lints**: ^3.0.0 - 代码规范
- **build_runner**: ^2.4.7 - 代码生成
- **floor_generator**: ^1.5.0 - Floor 代码生成

## 🚀 快速开始

### 环境要求
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- iOS 开发需要 Xcode (macOS)

### 安装步骤

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd flutter_demo
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **生成代码**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **运行应用**
   ```bash
   flutter run
   ```

### 网络问题解决方案

如果遇到网络连接问题（如 Material fonts 下载失败），可以尝试以下解决方案：

1. **使用代理或 VPN**
2. **配置 Flutter 镜像**:
   ```bash
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
   ```
3. **离线运行**: 项目已配置为可以在离线环境下编译运行

## 📖 主要功能说明

### 状态管理 (Riverpod)
项目使用 Riverpod 进行状态管理，主要 Provider 包括：
- `themeModeProvider`: 主题模式管理
- `appSettingsProvider`: 应用设置管理
- `contentProvider`: 内容管理

### 路由管理 (Go Router)
使用 Go Router 进行声明式路由管理：
- `/`: 首页
- `/config`: 配置页面
- `/write`: 内容编写页面
- `/camera`: 相机页面

### 数据库 (Floor)
使用 Floor 进行本地数据存储：
- Person 实体和 DAO
- 支持增删改查操作

### 主题系统
支持三种主题模式：
- 亮色主题
- 暗色主题
- 跟随系统

## 🔧 开发指南

### 添加新功能
1. 在 `lib/features/` 下创建新的功能模块
2. 按照现有结构组织代码（pages, providers, widgets）
3. 在 `app_router.dart` 中添加路由配置
4. 更新相关的 Provider 和状态管理

### 代码规范
- 遵循 Dart 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 组件和类使用英文命名，注释使用中文
- 保持代码简洁和可读性

### 测试
```bash
# 运行单元测试
flutter test

# 运行集成测试
flutter drive --target=test_driver/app.dart
```

## 📦 构建发布

### Android
```bash
# Debug 版本
flutter build apk --debug

# Release 版本
flutter build apk --release
```

### iOS
```bash
# Debug 版本
flutter build ios --debug

# Release 版本
flutter build ios --release
```

## ❓ 常见问题

### Q: 应用无法启动？
A: 确保已安装所有依赖并运行了代码生成命令：
```bash
flutter pub get
flutter packages pub run build_runner build
```

### Q: 网络连接问题？
A: 配置 Flutter 镜像或使用代理网络：
```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

### Q: 数据库相关错误？
A: 运行以下命令重新生成数据库代码：
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Q: 路由导航问题？
A: 检查 `app_router.dart` 中的路由配置，确保路径正确。

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

如有问题或建议，请通过以下方式联系：
- 创建 [Issue](https://github.com/your-repo/flutter_demo/issues)
- 发送邮件至: your-email@example.com

## 🎯 学习目标

通过这个项目，你可以学习到：

- ✅ Flutter 应用的标准项目结构
- ✅ 模块化开发的最佳实践
- ✅ Riverpod 状态管理的使用
- ✅ Go Router 路由管理
- ✅ Floor 数据库操作
- ✅ 主题切换的实现
- ✅ 现代化 UI 设计
- ✅ 代码组织和架构设计

---

**注意**: 本项目仅用于学习和演示目的，展示了 Flutter 开发的最佳实践。

欢迎提交 Issue 和 Pull Request 来改进这个项目！
