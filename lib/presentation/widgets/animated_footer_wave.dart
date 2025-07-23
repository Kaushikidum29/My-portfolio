import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedFooterWave extends StatefulWidget {
  const AnimatedFooterWave({super.key});

  @override
  State<AnimatedFooterWave> createState() => _AnimatedFooterWaveState();
}

class _AnimatedFooterWaveState extends State<AnimatedFooterWave> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: FooterWavePainter(animationValue: _controller.value),
          child: Container(
            height: 300,
          ),
        );
      },
    );
  }
}

class FooterWavePainter extends CustomPainter {
  final double animationValue;

  FooterWavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final List<Color> waveColors = [
      const Color(0xFF2E3767),
      const Color(0xFF374785).withOpacity(0.7),
      const Color(0xFF465CA8).withOpacity(0.5),
      const Color(0xFF5A6DD1).withOpacity(0.3),
    ];

    for (int i = 0; i < waveColors.length; i++) {
      paint.color = waveColors[i];
      final path = Path();

      path.moveTo(0, size.height);
      for (double x = 0.0; x <= size.width; x++) {
        double y = sin((x / size.width * 2 * pi) + (animationValue * 2 * pi * (i + 1))) * 15 + size.height * (0.6 + i * 0.05);
        path.lineTo(x, y);
      }

      path.lineTo(size.width, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
