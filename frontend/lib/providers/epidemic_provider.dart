import 'package:flutter/material.dart';
import '../models/models.dart';

class EpidemicProvider with ChangeNotifier {
  EpidemicProvider() {
    // _initializeDummyData();
  }

  List<Disease>? _diseases;

  List<Disease>? get diseases => _diseases;

  void setEpidemic(List<Disease> diseases) {
    _diseases = diseases;
    notifyListeners();
  }

  void clearEpidemic() {
    _diseases = null;
    notifyListeners();
  }

  void _initializeDummyData() {
    _diseases = [
      Disease(diseaseName: "Pandemic disease A", epidemic: true, reported: 23),
      Disease(diseaseName: "Pandemic disease B", epidemic: true, reported: 37),
      Disease(diseaseName: "Pandemic disease C", epidemic: true, reported: 54),
    ];
  }
}
