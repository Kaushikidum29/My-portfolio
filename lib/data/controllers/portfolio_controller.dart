import 'package:get/get.dart';
import 'package:my_portfolio/data/models/portfolio_model.dart';

import '../services/portfolio_service.dart';

class PortfolioController extends GetxController {
  var portfolio = Rxn<Portfolio>();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    print("Loading portfolio JSON...");
    try {
      portfolio.value = await PortfolioService.loadPortfolio();
      print("Portfolio loaded: ${portfolio.value?.name}");
    } catch (e) {
      print("Error loading portfolio: $e");
    }
  }
}
