import 'package:get/get.dart';

import '../../data/controllers/portfolio_controller.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioController());
  }
}