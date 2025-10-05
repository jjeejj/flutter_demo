import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 应用设置状态
class AppSettings {
  final bool notificationsEnabled;
  final bool analyticsEnabled;
  final bool autoUpdateEnabled;
  final String language;

  const AppSettings({
    this.notificationsEnabled = true,
    this.analyticsEnabled = false,
    this.autoUpdateEnabled = true,
    this.language = 'zh',
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? analyticsEnabled,
    bool? autoUpdateEnabled,
    String? language,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      autoUpdateEnabled: autoUpdateEnabled ?? this.autoUpdateEnabled,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'analyticsEnabled': analyticsEnabled,
      'autoUpdateEnabled': autoUpdateEnabled,
      'language': language,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      analyticsEnabled: json['analyticsEnabled'] ?? false,
      autoUpdateEnabled: json['autoUpdateEnabled'] ?? true,
      language: json['language'] ?? 'zh',
    );
  }
}

/// 应用设置状态提供者
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

/// 应用设置状态管理器
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  static const String _settingsKey = 'app_settings';
  
  AppSettingsNotifier() : super(const AppSettings()) {
    _loadSettings();
  }

  /// 加载保存的设置
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);
      
      if (settingsJson != null) {
        final Map<String, dynamic> json = {};
        // 简单的JSON解析，实际项目中应该使用dart:convert
        final parts = settingsJson.split(',');
        for (final part in parts) {
          final keyValue = part.split(':');
          if (keyValue.length == 2) {
            final key = keyValue[0].trim();
            final value = keyValue[1].trim();
            if (value == 'true' || value == 'false') {
              json[key] = value == 'true';
            } else {
              json[key] = value;
            }
          }
        }
        state = AppSettings.fromJson(json);
      }
    } catch (e) {
      // 如果加载失败，使用默认值
      state = const AppSettings();
    }
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = state.toJson();
      final settingsString = json.entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');
      await prefs.setString(_settingsKey, settingsString);
    } catch (e) {
      // 处理保存失败的情况
      print('Failed to save settings: $e');
    }
  }

  /// 设置通知开关
  Future<void> setNotificationsEnabled(bool enabled) async {
    state = state.copyWith(notificationsEnabled: enabled);
    await _saveSettings();
  }

  /// 设置分析开关
  Future<void> setAnalyticsEnabled(bool enabled) async {
    state = state.copyWith(analyticsEnabled: enabled);
    await _saveSettings();
  }

  /// 设置自动更新开关
  Future<void> setAutoUpdateEnabled(bool enabled) async {
    state = state.copyWith(autoUpdateEnabled: enabled);
    await _saveSettings();
  }

  /// 设置语言
  Future<void> setLanguage(String language) async {
    state = state.copyWith(language: language);
    await _saveSettings();
  }

  /// 重置所有设置
  Future<void> resetSettings() async {
    state = const AppSettings();
    await _saveSettings();
  }
}