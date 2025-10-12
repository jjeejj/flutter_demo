import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Flutter UI 技巧演示页面
class UITricksPage extends StatelessWidget {
  const UITricksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI 技巧演示'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '5个不为人知的Flutter UI技巧',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // 1. CustomClipper 波浪形状
          _buildTrickCard(
            title: '1. CustomClipper - 波浪形状',
            description: '使用CustomClipper创建自定义形状',
            child: const WaveExample(),
          ),
          
          // 2. ColorFiltered 灰度效果
          _buildTrickCard(
            title: '2. ColorFiltered - 灰度滤镜',
            description: '对组件应用色彩滤镜效果',
            child: const GrayscaleExample(),
          ),
          
          // 3. BackdropFilter 毛玻璃效果
          _buildTrickCard(
            title: '3. BackdropFilter - 毛玻璃效果',
            description: '模糊背景内容实现毛玻璃效果',
            child: const FrostedGlassExample(),
          ),
          
          // 4. ShaderMask 渐变边框
          _buildTrickCard(
            title: '4. ShaderMask - 渐变边框',
            description: '创建渐变或图案效果',
            child: const GradientBorderExample(),
          ),
          
          // 5. RepaintBoundary 性能优化
          _buildTrickCard(
            title: '5. RepaintBoundary - 性能优化',
            description: '隔离组件避免不必要的重绘',
            child: const RepaintBoundaryExample(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrickCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

/// 1. CustomClipper 波浪形状示例
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2, 
      size.height, 
      size.width, 
      size.height - 50
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveExample extends StatelessWidget {
  const WaveExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: const LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(const Rect.fromLTWH(0, 0, 200, 200)) != null
                ? BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  )
                : const BoxDecoration(color: Colors.blue),
          ),
        ),
        const Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Custom Clipper!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 2. ColorFiltered 灰度效果示例
class GrayscaleExample extends StatefulWidget {
  const GrayscaleExample({super.key});

  @override
  State<GrayscaleExample> createState() => _GrayscaleExampleState();
}

class _GrayscaleExampleState extends State<GrayscaleExample> {
  bool _isGrayscale = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorFiltered(
          colorFilter: _isGrayscale
              ? const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                )
              : const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.multiply,
                ),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                '彩色图片',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isGrayscale = !_isGrayscale;
            });
          },
          child: Text(_isGrayscale ? '显示彩色' : '显示灰度'),
        ),
      ],
    );
  }
}

/// 3. BackdropFilter 毛玻璃效果示例
class FrostedGlassExample extends StatelessWidget {
  const FrostedGlassExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景图片
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.cyan,
                Colors.green,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // 毛玻璃效果
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.white.withOpacity(0.3),
                alignment: Alignment.center,
                child: const Text(
                  'Frosted Glass Effect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 4. ShaderMask 渐变边框示例
class GradientBorderExample extends StatelessWidget {
  const GradientBorderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [Colors.purple, Colors.blue, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.1),
          ),
          child: const Center(
            child: Text(
              'Gradient Border',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

/// 5. RepaintBoundary 性能优化示例
class RepaintBoundaryExample extends StatefulWidget {
  const RepaintBoundaryExample({super.key});

  @override
  State<RepaintBoundaryExample> createState() => _RepaintBoundaryExampleState();
}

class _RepaintBoundaryExampleState extends State<RepaintBoundaryExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 没有 RepaintBoundary 的组件
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('无优化', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159,
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        '$_counter',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        
        // 有 RepaintBoundary 的组件
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('已优化', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * 3.14159,
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Opt',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        
        // 计数器按钮
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('计数器', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('+1'),
            ),
          ],
        ),
      ],
    );
  }
}