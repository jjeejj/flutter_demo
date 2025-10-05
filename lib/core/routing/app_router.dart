import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/features/app/pages/home_page.dart';
import 'package:flutter_demo/features/app/pages/config_page.dart';
import 'package:flutter_demo/features/app/pages/write_page.dart';
import 'package:flutter_demo/features/camera/camer_page.dart';

/// 应用路由配置
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // 主页
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      
      // 配置页面
      GoRoute(
        path: '/config',
        builder: (context, state) => const ConfigPage(),
      ),
      
      // 写新内容页面
      GoRoute(
        path: '/write',
        builder: (context, state) => const WritePage(),
      ),
      
      // 相机页面
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraPage(),
      ),
    ],
  );
}