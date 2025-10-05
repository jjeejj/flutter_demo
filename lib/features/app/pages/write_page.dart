import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_demo/shared/widgets/app_scaffold.dart';
import 'package:flutter_demo/features/app/providers/content_provider.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String _selectedCategory = '想法';
  bool _isPrivate = false;
  DateTime? _scheduledDate;
  final List<String> _selectedTags = [];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(contentCategoriesProvider);
    
    return AppScaffold(
      title: '写新内容',
      actions: [
        TextButton(
          onPressed: _saveContent,
          child: const Text('发布'),
        ),
      ],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 标题输入
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '标题',
                hintText: '请输入内容标题',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入标题';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // 内容输入
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '内容',
                hintText: '分享你的想法...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入内容';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // 分类选择
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: '分类',
                border: OutlineInputBorder(),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newCategory) {
                if (newCategory != null) {
                  setState(() {
                    _selectedCategory = newCategory;
                  });
                }
              },
            ),
            
            const SizedBox(height: 16),
            
            // 隐私设置
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '隐私设置',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('私密内容'),
                      subtitle: const Text('只有自己可以查看'),
                      value: _isPrivate,
                      onChanged: (bool value) {
                        setState(() {
                          _isPrivate = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 定时发布
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '定时发布',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text(_scheduledDate == null 
                          ? '立即发布' 
                          : '定时发布: ${_formatDateTime(_scheduledDate!)}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _selectScheduledDate,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 工具栏
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '工具',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.image, size: 18),
                          label: const Text('添加图片'),
                          onPressed: _addImage,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.location_on, size: 18),
                          label: const Text('添加位置'),
                          onPressed: _addLocation,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.mood, size: 18),
                          label: const Text('心情'),
                          onPressed: _addMood,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.tag, size: 18),
                          label: const Text('标签'),
                          onPressed: _addTags,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 发布按钮
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _saveContent,
                icon: const Icon(Icons.publish),
                label: Text(_scheduledDate == null ? '立即发布' : '定时发布'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContent() {
    if (_formKey.currentState!.validate()) {
      final newContent = ContentItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        isPrivate: _isPrivate,
        createdAt: DateTime.now(),
        scheduledAt: _scheduledDate,
        tags: _selectedTags,
      );

      ref.read(contentListProvider.notifier).addContent(newContent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_scheduledDate == null ? '内容已发布' : '内容已安排定时发布'),
          action: SnackBarAction(
            label: '查看',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );

      // 清空表单
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _selectedCategory = '想法';
        _isPrivate = false;
        _scheduledDate = null;
        _selectedTags.clear();
      });
    }
  }

  void _selectScheduledDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _scheduledDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _addImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('图片功能开发中')),
    );
  }

  void _addLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('位置功能开发中')),
    );
  }

  void _addMood() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择心情'),
        content: Wrap(
          spacing: 8,
          children: ['😊', '😢', '😡', '😍', '🤔', '😴'].map((emoji) {
            return ActionChip(
              label: Text(emoji, style: const TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.of(context).pop();
                _contentController.text += ' $emoji';
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  void _addTags() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加标签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: '输入标签名称',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty && !_selectedTags.contains(value.trim())) {
                  setState(() {
                    _selectedTags.add(value.trim());
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
            if (_selectedTags.isNotEmpty) ...[
              const Text('已选标签:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _selectedTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedTags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('完成'),
          ),
        ],
      ),
    );
  }
}