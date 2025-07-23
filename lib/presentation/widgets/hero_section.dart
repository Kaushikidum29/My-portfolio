import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/widgets/profile_image.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';

class HeroSectionWidget extends StatelessWidget {
  final String? description;
  final String? image;
  final String? designation;
  const HeroSectionWidget({
    Key? key,
    required this.description,
    required this.image,
    required this.designation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImage(imageUrl: image ?? ""),
        const SizedBox(height: 32),
        _buildHeroText(context),
        // const SizedBox(height: 24),
        // _buildHireButton(),
      ],
    );
  }

  Widget _buildDesktopLayout(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroText(context),
              // const SizedBox(height: 32),
              // _buildHireButton(),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: ProfileImage(imageUrl: image ?? "")),
      ],
    );
  }

  Widget _buildHeroText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 32),
            children: [
              TextSpan(
                text: 'Hi, ',
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: "I'm Kaushiki Kumari",
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 32),
            children: [
              TextSpan(
                text: "I'm ",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                ),
              ),
              TextSpan(
                text: designation ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description ?? "",
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.lightTextColor,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildHireButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          shadowColor: Colors.black26,
        ),
        onPressed: () {},
        child: Center(child: const Text('Hire Me')),
      ),
    );
  }
}
