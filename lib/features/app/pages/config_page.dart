import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_demo/shared/widgets/app_scaffold.dart';
import 'package:flutter_demo/core/providers/theme_provider.dart';
import 'package:flutter_demo/core/providers/app_settings_provider.dart';

class ConfigPage extends ConsumerWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);
    final appSettings = ref.watch(appSettingsProvider);
    final appSettingsNotifier = ref.read(appSettingsProvider.notifier);

    return AppScaffold(
      title: '设置',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 主题设置
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '主题设置',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<ThemeMode>(
                    value: themeMode,
                    decoration: const InputDecoration(
                      labelText: '主题模式',
                      border: OutlineInputBorder(),
                    ),
                    items: ThemeMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(themeModeNotifier.getThemeModeDisplayName(mode)),
                      );
                    }).toList(),
                    onChanged: (ThemeMode? newMode) {
                      if (newMode != null) {
                        themeModeNotifier.setThemeMode(newMode);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 应用设置
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '应用设置',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('推送通知'),
                    subtitle: const Text('接收应用通知'),
                    value: appSettings.notificationsEnabled,
                    onChanged: appSettingsNotifier.setNotificationsEnabled,
                  ),
                  SwitchListTile(
                    title: const Text('数据分析'),
                    subtitle: const Text('帮助改善应用体验'),
                    value: appSettings.analyticsEnabled,
                    onChanged: appSettingsNotifier.setAnalyticsEnabled,
                  ),
                  SwitchListTile(
                    title: const Text('自动更新'),
                    subtitle: const Text('自动检查并下载更新'),
                    value: appSettings.autoUpdateEnabled,
                    onChanged: appSettingsNotifier.setAutoUpdateEnabled,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 存储设置
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '存储设置',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services),
                    title: const Text('清除缓存'),
                    subtitle: const Text('清除应用缓存数据'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showClearCacheDialog(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: const Text('备份数据'),
                    subtitle: const Text('备份应用数据到云端'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showBackupDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 关于应用
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '关于应用',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('版本信息'),
                    subtitle: const Text('v1.0.0'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showVersionDialog(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('隐私政策'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // 打开隐私政策页面
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('使用条款'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // 打开使用条款页面
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // 重置设置按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _showResetDialog(context, appSettingsNotifier);
              },
              icon: const Icon(Icons.restore),
              label: const Text('重置所有设置'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除所有缓存数据吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('缓存已清除')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('备份数据'),
        content: const Text('将数据备份到云端，确保数据安全。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('备份已开始')),
              );
            },
            child: const Text('开始备份'),
          ),
        ],
      ),
    );
  }

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('版本信息'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flutter Demo App'),
            Text('版本: 1.0.0'),
            Text('构建号: 1'),
            SizedBox(height: 16),
            Text('基于 Flutter 和 Riverpod 构建的示例应用'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, AppSettingsNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置设置'),
        content: const Text('确定要重置所有设置到默认值吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              notifier.resetSettings();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('设置已重置')),
              );
            },
            child: const Text('重置'),
          ),
        ],
      ),
    );
  }
}