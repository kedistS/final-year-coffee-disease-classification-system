import 'package:flutter/material.dart';
import '../models/models.dart';

class AnalyticsProvider with ChangeNotifier {
  Analytics? _analytics;

  Analytics? get analytics => _analytics;

  void setResult(Analytics analytics) {
    _analytics = analytics;
    notifyListeners();
  }

  void clearResult() {
    _analytics = null;
    notifyListeners();
  }
}
