import 'package:flutter/material.dart';
import 'navigation/prototype_navigator.dart';

/// 快速原型页面
/// 用于快速验证新特性和功能的主入口页面
class PrototypePage extends StatelessWidget {
  const PrototypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrototypeNavigator();
  }
}