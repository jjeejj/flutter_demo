import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 内容项模型
class ContentItem {
  final String id;
  final String title;
  final String content;
  final String category;
  final bool isPrivate;
  final DateTime createdAt;
  final DateTime? scheduledAt;
  final List<String> tags;

  const ContentItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isPrivate = false,
    required this.createdAt,
    this.scheduledAt,
    this.tags = const [],
  });

  ContentItem copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    bool? isPrivate,
    DateTime? createdAt,
    DateTime? scheduledAt,
    List<String>? tags,
  }) {
    return ContentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isPrivate: isPrivate ?? this.isPrivate,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      tags: tags ?? this.tags,
    );
  }
}

/// 内容列表状态提供者
final contentListProvider = StateNotifierProvider<ContentListNotifier, List<ContentItem>>((ref) {
  return ContentListNotifier();
});

/// 内容列表状态管理器
class ContentListNotifier extends StateNotifier<List<ContentItem>> {
  ContentListNotifier() : super([]) {
    _loadSampleData();
  }

  /// 加载示例数据
  void _loadSampleData() {
    state = [
      ContentItem(
        id: '1',
        title: '欢迎使用Flutter Demo',
        content: '这是一个使用Flutter和Riverpod构建的示例应用。',
        category: '公告',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['flutter', 'riverpod'],
      ),
      ContentItem(
        id: '2',
        title: '学习笔记',
        content: '今天学习了状态管理的相关知识...',
        category: '学习',
        isPrivate: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        tags: ['学习', '笔记'],
      ),
    ];
  }

  /// 添加新内容
  void addContent(ContentItem item) {
    state = [...state, item];
  }

  /// 更新内容
  void updateContent(String id, ContentItem updatedItem) {
    state = state.map((item) {
      return item.id == id ? updatedItem : item;
    }).toList();
  }

  /// 删除内容
  void deleteContent(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  /// 根据分类筛选内容
  List<ContentItem> getContentByCategory(String category) {
    return state.where((item) => item.category == category).toList();
  }

  /// 获取公开内容
  List<ContentItem> getPublicContent() {
    return state.where((item) => !item.isPrivate).toList();
  }

  /// 获取私有内容
  List<ContentItem> getPrivateContent() {
    return state.where((item) => item.isPrivate).toList();
  }

  /// 搜索内容
  List<ContentItem> searchContent(String query) {
    final lowerQuery = query.toLowerCase();
    return state.where((item) {
      return item.title.toLowerCase().contains(lowerQuery) ||
             item.content.toLowerCase().contains(lowerQuery) ||
             item.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}

/// 当前编辑内容状态提供者
final currentEditingContentProvider = StateProvider<ContentItem?>((ref) => null);

/// 内容分类列表提供者
final contentCategoriesProvider = Provider<List<String>>((ref) {
  return ['公告', '学习', '工作', '生活', '想法', '其他'];
});

/// 内容统计信息提供者
final contentStatsProvider = Provider<Map<String, int>>((ref) {
  final contents = ref.watch(contentListProvider);
  
  final stats = <String, int>{
    'total': contents.length,
    'public': contents.where((item) => !item.isPrivate).length,
    'private': contents.where((item) => item.isPrivate).length,
  };

  // 按分类统计
  for (final item in contents) {
    final categoryKey = 'category_${item.category}';
    stats[categoryKey] = (stats[categoryKey] ?? 0) + 1;
  }

  return stats;
});