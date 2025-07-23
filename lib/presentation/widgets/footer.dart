import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  void _launch(String url) async {
    if (!url.startsWith('http')) url = 'https://$url';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return SizedBox(
      width: double.infinity,
      height: isMobile ? 350 : 300,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // 1. Animated waves at the bottom
          const Positioned.fill(child: AnimatedFooterWave()),

          // 2. Content layered on top
          Positioned(
            bottom: 35,
            right: 35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Let’s Connect: ",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _socialIcon(
                      FontAwesomeIcons.linkedin,
                      'linkedin.com/in/kaushiki-kumari-immidiate-joiner-338019205',
                    ),
                    _socialIcon(
                      FontAwesomeIcons.whatsapp,
                      'https://wa.me/9289427429',
                    ),
                    _socialIcon(
                      FontAwesomeIcons.github,
                      'https://github.com/Kaushikidum29',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launch(url),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          color: Colors.white.withOpacity(0.05),
        ),
        child: FaIcon(icon, size: 26, color: Colors.white),
      ),
    );
  }

  Widget _githubLink() {
    return GestureDetector(
      onTap: () => _launch('https://github.com/Kaushikidum29'),
      child: Text.rich(
        TextSpan(
          children: [
            const WidgetSpan(
              child: FaIcon(FontAwesomeIcons.github, color: Colors.white),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            TextSpan(
              text: "@Kaushikidum29",
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: " on GitHub", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// -------------- Animated Wave Painter --------------

class AnimatedFooterWave extends StatefulWidget {
  const AnimatedFooterWave({Key? key}) : super(key: key);
  @override
  _AnimatedFooterWaveState createState() => _AnimatedFooterWaveState();
}

class _AnimatedFooterWaveState extends State<AnimatedFooterWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
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
      builder: (_, __) =>
          CustomPaint(painter: _FooterWavePainter(_controller.value)),
    );
  }
}

class _FooterWavePainter extends CustomPainter {
  final double value;
  _FooterWavePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final waveColors = [
      Color(0xFF2E3767),
      Color(0xFF374785).withOpacity(0.7),
      Color(0xFF465CA8).withOpacity(0.5),
      Color(0xFF5A6DD1).withOpacity(0.3),
    ];

    for (int i = 0; i < waveColors.length; i++) {
      paint.color = waveColors[i];
      final path = Path()..moveTo(0, size.height);
      for (double x = 0; x <= size.width; x++) {
        final omega = (i + 1) * 2 * pi / size.width;
        final y =
            sin(x * omega + value * 2 * pi * (i + 1)) * 15 +
            size.height * (0.4 + i * 0.05);
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FooterWavePainter old) => true;
}
