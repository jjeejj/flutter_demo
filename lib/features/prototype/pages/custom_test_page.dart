import 'package:flutter/material.dart';
import '../templates/base_prototype_page.dart';

/// 自定义测试页面
/// 这是一个空白的测试页面，可以快速在这里验证任何想法
class CustomTestPage extends BasePrototypePage {
  const CustomTestPage({super.key});

  @override
  State<CustomTestPage> createState() => _CustomTestPageState();
}

class _CustomTestPageState extends BasePrototypePageState<CustomTestPage> {
  @override
  String get title => '自定义测试';

  @override
  String get description => '在这里快速验证任何想法和功能 - 这是你的实验场！';

  // 在这里添加你的测试状态变量
  int _counter = 0;
  bool _isLoading = false;
  String _message = '开始你的实验吧！';

  @override
  void resetState() {
    super.resetState();
    _counter = 0;
    _isLoading = false;
    _message = '开始你的实验吧！';
  }

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 在这里添加你的测试UI
          const Icon(
            Icons.science,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 24),
          
          Text(
            _message,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // 示例：计数器
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '计数器示例',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _counter--;
                            _message = '计数减少了！';
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _counter++;
                            _message = '计数增加了！';
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 示例：异步操作
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '异步操作示例',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _simulateAsyncOperation,
                      child: const Text('模拟异步操作'),
                    ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // 提示文本
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 使用提示：',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                const Text('1. 在 buildContent 方法中添加你的测试UI'),
                const Text('2. 在类的顶部添加状态变量'),
                const Text('3. 在 resetState 方法中重置状态'),
                const Text('4. 使用热重载快速查看效果'),
                const Text('5. 在 buildDebugPanel 中添加调试信息'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildDebugPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '调试信息',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Text('计数器值: $_counter'),
          Text('加载状态: $_isLoading'),
          Text('消息: $_message'),
          Text('构建时间: ${DateTime.now().toString().substring(11, 19)}'),
        ],
      ),
    );
  }

  // 示例异步方法
  Future<void> _simulateAsyncOperation() async {
    setState(() {
      _isLoading = true;
      _message = '正在处理...';
    });

    // 模拟网络请求或其他异步操作
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _message = '异步操作完成！';
    });
  }
}

// 你也可以在这里添加其他测试组件

/// 示例：自定义测试组件
class CustomTestWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomTestWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.widgets),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}