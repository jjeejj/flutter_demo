/// 应用程序常量配置
class AppConstants {
  // 应用信息
  static const String appName = 'Flutter Demo';
  static const String appVersion = '1.0.0';
  
  // API配置
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // 缓存配置
  static const String cacheBoxName = 'app_cache';
  static const int cacheMaxAge = 7 * 24 * 60 * 60; // 7天
  
  // 数据库配置
  static const String databaseName = 'app_database.db';
  static const int databaseVersion = 1;
  
  // 路由名称
  static const String homeRoute = '/';
  static const String settingsRoute = '/settings';
  static const String profileRoute = '/profile';
}