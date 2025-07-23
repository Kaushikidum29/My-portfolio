import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/presentation/bindings/portfolio_binding.dart';
import 'core/theme/theme_controller.dart';
import 'data/controllers/portfolio_controller.dart';
import 'presentation/pages/portfolio_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  Get.put(ThemeController());
  Get.put(PortfolioController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        initialBinding: PortfolioBinding(),
      title: 'Portfolio',
      theme: themeController.isDarkMode.value
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
      home: const PortfolioPage(),
      debugShowCheckedModeBanner: false,
    );
    });
  }
}
