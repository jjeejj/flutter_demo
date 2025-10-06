import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/shared/widgets/app_scaffold.dart';

/// 应用主页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Flutter Demo',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 欢迎卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.flutter_dash,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '欢迎使用 Flutter Demo',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '这是一个重构后的 Flutter 项目，采用了清晰的架构和模块化设计',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 功能列表
            Text(
              '功能模块',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.camera_alt,
                    title: '相机功能',
                    subtitle: '拍照和录像',
                    onTap: () => context.go('/camera'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.settings,
                    title: '应用配置',
                    subtitle: '设置和配置',
                    onTap: () => context.go('/config'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.edit,
                    title: '写新内容',
                    subtitle: '创建新内容',
                    onTap: () => context.go('/write'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.science,
                    title: '快速原型',
                    subtitle: '验证新特性',
                    onTap: () => context.go('/prototype'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.info,
                    title: '关于',
                    subtitle: '应用信息',
                    onTap: () => _showAboutDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Demo',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.flutter_dash),
      children: [
        const Text('这是一个重构后的 Flutter 演示项目。'),
        const SizedBox(height: 8),
        const Text('采用了现代化的架构设计：'),
        const Text('• 模块化的目录结构'),
        const Text('• Go Router 路由管理'),
        const Text('• Riverpod 状态管理'),
        const Text('• 统一的主题系统'),
        const Text('• 可复用的组件库'),
      ],
    );
  }
}