import 'package:flutter/material.dart';
import '../templates/base_prototype_page.dart';

/// UI组件测试页面
class UIComponentsTestPage extends BasePrototypePage {
  const UIComponentsTestPage({super.key});

  @override
  State<UIComponentsTestPage> createState() => _UIComponentsTestPageState();
}

class _UIComponentsTestPageState
    extends BasePrototypePageState<UIComponentsTestPage> {
  @override
  String get title => 'UI 组件测试';

  @override
  String get description => '在这里快速测试各种UI组件的样式和行为';

  // 测试状态
  bool _switchValue = false;
  double _sliderValue = 50.0;
  String _selectedChip = 'Flutter';
  int _selectedSegment = 0;

  @override
  void resetState() {
    super.resetState();
    _switchValue = false;
    _sliderValue = 50.0;
    _selectedChip = 'Flutter';
    _selectedSegment = 0;
  }

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('按钮组件', _buildButtons()),
          _buildSection('输入组件', _buildInputs()),
          _buildSection('选择组件', _buildSelectors()),
          _buildSection('显示组件', _buildDisplays()),
          _buildSection('自定义组件', _buildCustomComponents()),
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
        children: [
          Text(
            '当前状态',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Switch: $_switchValue'),
              Text('Slider: ${_sliderValue.round()}'),
              Text('Chip: $_selectedChip'),
              Text('Segment: $_selectedSegment'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton(
          onPressed: () => _showSnackBar('ElevatedButton 点击'),
          child: const Text('Elevated'),
        ),
        FilledButton(
          onPressed: () => _showSnackBar('FilledButton 点击'),
          child: const Text('Filled'),
        ),
        OutlinedButton(
          onPressed: () => _showSnackBar('OutlinedButton 点击'),
          child: const Text('Outlined'),
        ),
        TextButton(
          onPressed: () => _showSnackBar('TextButton 点击'),
          child: const Text('Text'),
        ),
        IconButton(
          onPressed: () => _showSnackBar('IconButton 点击'),
          icon: const Icon(Icons.favorite),
        ),
        FloatingActionButton.small(
          onPressed: () => _showSnackBar('FAB 点击'),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildInputs() {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: '标准输入框',
            hintText: '请输入内容',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: '带图标的输入框',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.clear),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: '表单输入框',
            helperText: '这是帮助文本',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return '请输入内容';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSelectors() {
    return Column(
      children: [
        Row(
          children: [
            const Text('Switch: '),
            Switch(
              value: _switchValue,
              onChanged: (value) => setState(() => _switchValue = value),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Slider: '),
            Expanded(
              child: Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: _sliderValue.round().toString(),
                onChanged: (value) => setState(() => _sliderValue = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: ['Flutter', 'Dart', 'Mobile', 'Web'].map((label) {
            return ChoiceChip(
              label: Text(label),
              selected: _selectedChip == label,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedChip = label);
                }
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('选项1')),
            ButtonSegment(value: 1, label: Text('选项2')),
            ButtonSegment(value: 2, label: Text('选项3')),
          ],
          selected: {_selectedSegment},
          onSelectionChanged: (selection) {
            setState(() => _selectedSegment = selection.first);
          },
        ),
      ],
    );
  }

  Widget _buildDisplays() {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.info),
            title: const Text('信息卡片'),
            subtitle: const Text('这是一个示例卡片'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showSnackBar('卡片点击'),
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: _sliderValue / 100,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        CircularProgressIndicator(
          value: _sliderValue / 100,
        ),
        const SizedBox(height: 16),
        Chip(
          avatar: const Icon(Icons.star),
          label: const Text('标签芯片'),
          onDeleted: () => _showSnackBar('芯片删除'),
        ),
      ],
    );
  }

  Widget _buildCustomComponents() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            '渐变容器',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('阴影容器'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('边框容器'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}