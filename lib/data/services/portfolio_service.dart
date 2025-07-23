import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/portfolio_model.dart';

class PortfolioService {
  static Future<Portfolio> loadPortfolio() async {
    final data = await rootBundle.loadString('assets/jsons/portfolio.json');
    final jsonResult = json.decode(data);
    return Portfolio.fromJson(jsonResult);
  }
}
