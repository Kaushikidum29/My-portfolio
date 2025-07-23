import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String? imageUrl;

  const ProfileImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCard({required double angle, required Color color, double offset = 0}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 280,
        height: 360,
        margin: EdgeInsets.only(top: offset),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.imageUrl ?? "";

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: _opacityAnim.value,
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Back card
                _buildCard(
                  angle: -0.15,
                  color: Colors.blueGrey.shade100,
                  offset: 40,
                ),

                // Middle card
                _buildCard(
                  angle: 0.10,
                  color: Colors.blue.shade100,
                  offset: 20,
                ),

                // Profile image (front)
                Container(
                  width: 280,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
