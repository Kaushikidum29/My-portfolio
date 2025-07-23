import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/theme_controller.dart';
import '../../core/utils/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.onSectionSelected,
    required this.homeKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.contactKey,
    this.activeSection = 'home',
    required this.name,
  }) : super(key: key);

  final void Function(GlobalKey) onSectionSelected;
  final GlobalKey homeKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final String activeSection;
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = Get.find<ThemeController>();

    Color getNavItemColor(String section) {
      return activeSection == section
          ? const Color(0xffec4c4c)
          : theme.textTheme.bodyLarge?.color ?? Colors.black54;
    }

    Widget navButton(String label, GlobalKey key, String section) {
      return TextButton(
        onPressed: () => onSectionSelected(key),
        child: Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold,color: getNavItemColor(section)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: theme.scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Title
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.code, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Immediate Joiner',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(), // Navigation buttons or hamburger menu
          if (!Responsive.isMobile(context))
            Row(
              children: [
                navButton('Home', homeKey, 'home'),
                navButton('Skills', skillsKey, 'skills'),
                navButton('Projects', projectsKey, 'projects'),
                navButton('Contact me', contactKey, 'contact'),
              ],
            )
          else
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu, color: theme.iconTheme.color),
                  onPressed: () async {
                    final RenderBox button = context.findRenderObject() as RenderBox;
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

                    await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        position.dx,
                        position.dy + button.size.height,
                        position.dx + button.size.width,
                        0,
                      ),
                      items: [
                        _popupMenuItem('Home', homeKey, 'home'),
                        _popupMenuItem('Skills', skillsKey, 'skills'),
                        _popupMenuItem('Projects', projectsKey, 'projects'),
                        _popupMenuItem('Contact me', contactKey, 'contact'),
                      ],
                    );
                  },
                );
              },
            ),

          // Theme toggle button
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => themeController.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem _popupMenuItem(String label, GlobalKey key, String section) {
    return PopupMenuItem(
      child: Text(label),
      onTap: () {
        Future.delayed(
          Duration(milliseconds: 10),
              () => onSectionSelected(key),
        );
      },
    );
  }

}
