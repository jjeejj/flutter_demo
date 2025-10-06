import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 应用通用脚手架组件
class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final Widget? drawer;
  final bool showAppBar;
  final Color? backgroundColor;
  final bool showBackButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.drawer,
    this.showAppBar = true,
    this.backgroundColor,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              actions: actions,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      tooltip: '返回',
                    )
                  : null,
            )
          : null,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      drawer: drawer,
    );
  }
}