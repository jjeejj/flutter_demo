import 'package:flutter/material.dart';

/// 基础原型页面模板
/// 提供快速创建测试页面的基础结构
abstract class BasePrototypePage extends StatefulWidget {
  const BasePrototypePage({super.key});
}

abstract class BasePrototypePageState<T extends BasePrototypePage>
    extends State<T> {
  /// 页面标题
  String get title;

  /// 页面描述
  String get description => '';

  /// 是否显示重置按钮
  bool get showResetButton => true;

  /// 是否显示调试信息
  bool get showDebugInfo => true;

  /// 重置状态
  void resetState() {
    setState(() {
      // 子类重写此方法来重置状态
    });
  }

  /// 构建主要内容
  Widget buildContent(BuildContext context);

  /// 构建调试面板（可选）
  Widget? buildDebugPanel(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 显式设置返回按钮
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: '返回',
              )
            : null,
        actions: [
          if (showResetButton)
            IconButton(
              onPressed: resetState,
              icon: const Icon(Icons.refresh),
              tooltip: '重置',
            ),
          if (showDebugInfo)
            IconButton(
              onPressed: () => _showDebugInfo(context),
              icon: const Icon(Icons.bug_report),
              tooltip: '调试信息',
            ),
        ],
      ),
      body: Column(
        children: [
          if (description.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
          Expanded(
            child: buildContent(context),
          ),
          if (buildDebugPanel(context) != null) ...[
            const Divider(height: 1),
            buildDebugPanel(context)!,
          ],
        ],
      ),
    );
  }

  void _showDebugInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('调试信息'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('页面: $title'),
            Text('Widget: ${widget.runtimeType}'),
            Text('State: ${runtimeType}'),
            const SizedBox(height: 8),
            const Text('提示:'),
            const Text('• 使用重置按钮恢复初始状态'),
            const Text('• 修改代码后热重载查看效果'),
            const Text('• 在buildDebugPanel中添加调试控件'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}

/// 简单的原型页面模板
/// 用于快速创建单一功能测试页面
class SimplePrototypePage extends StatefulWidget {
  final String title;
  final String? description;
  final Widget Function(BuildContext context) builder;
  final VoidCallback? onReset;

  const SimplePrototypePage({
    super.key,
    required this.title,
    required this.builder,
    this.description,
    this.onReset,
  });

  @override
  State<SimplePrototypePage> createState() => _SimplePrototypePageState();
}

class _SimplePrototypePageState extends State<SimplePrototypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (widget.onReset != null)
            IconButton(
              onPressed: () {
                widget.onReset!();
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
              tooltip: '重置',
            ),
        ],
      ),
      body: Column(
        children: [
          if (widget.description != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Text(
                widget.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
          Expanded(
            child: widget.builder(context),
          ),
        ],
      ),
    );
  }
}