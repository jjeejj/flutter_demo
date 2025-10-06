import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/ui_components_test.dart';
import '../pages/custom_test_page.dart';

/// 原型页面导航器
/// 提供快速访问所有原型页面的导航系统
class PrototypeNavigator extends StatelessWidget {
  const PrototypeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('快速原型导航'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        // 显式设置返回按钮 - 强制显示用于调试
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('返回按钮被点击');
            if (context.canPop()) {
              context.pop();
            } else {
              // 如果canPop返回false，使用go方法返回主页
              context.go('/');
            }
          },
          tooltip: '返回',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 介绍卡片
          Card(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.rocket_launch,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '快速原型系统',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('选择一个页面开始验证你的新特性和想法'),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 页面列表
          _buildPageSection(
            context,
            title: '测试页面',
            icon: Icons.science,
            pages: [
              PrototypePageInfo(
                title: 'UI 组件测试',
                description: '测试各种 UI 组件和交互效果',
                icon: Icons.widgets,
                page: const UIComponentsTestPage(),
                color: Colors.blue,
              ),
              PrototypePageInfo(
                title: '自定义测试页面',
                description: '空白页面，可以快速验证任何想法',
                icon: Icons.edit,
                page: const CustomTestPage(),
                color: Colors.green,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildPageSection(
            context,
            title: '功能验证',
            icon: Icons.check_circle,
            pages: [
              // 这里可以添加更多功能验证页面
              PrototypePageInfo(
                title: '网络请求测试',
                description: '验证 API 调用和数据处理',
                icon: Icons.cloud,
                page: const _ComingSoonPage(title: '网络请求测试'),
                color: Colors.orange,
              ),
              PrototypePageInfo(
                title: '状态管理测试',
                description: '验证状态管理方案',
                icon: Icons.storage,
                page: const _ComingSoonPage(title: '状态管理测试'),
                color: Colors.purple,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildPageSection(
            context,
            title: '性能测试',
            icon: Icons.speed,
            pages: [
              PrototypePageInfo(
                title: '渲染性能测试',
                description: '测试复杂 UI 的渲染性能',
                icon: Icons.timeline,
                page: const _ComingSoonPage(title: '渲染性能测试'),
                color: Colors.red,
              ),
              PrototypePageInfo(
                title: '内存使用测试',
                description: '监控内存使用情况',
                icon: Icons.memory,
                page: const _ComingSoonPage(title: '内存使用测试'),
                color: Colors.teal,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // 快速添加提示
          Card(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '快速添加新页面',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. 复制 CustomTestPage 创建新页面\n'
                    '2. 在这里添加导航项\n'
                    '3. 使用热重载立即查看效果',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<PrototypePageInfo> pages,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...pages.map((pageInfo) => _buildPageTile(context, pageInfo)),
      ],
    );
  }

  Widget _buildPageTile(BuildContext context, PrototypePageInfo pageInfo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => pageInfo.page,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: pageInfo.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    pageInfo.icon,
                    color: pageInfo.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pageInfo.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pageInfo.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 原型页面信息
class PrototypePageInfo {
  final String title;
  final String description;
  final IconData icon;
  final Widget page;
  final Color color;

  const PrototypePageInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
    required this.color,
  });
}

/// 占位页面 - 用于尚未实现的功能
class _ComingSoonPage extends StatelessWidget {
  final String title;

  const _ComingSoonPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              '即将推出',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '这个功能正在开发中...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}