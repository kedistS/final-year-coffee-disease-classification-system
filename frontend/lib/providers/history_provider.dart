import 'package:flutter/material.dart';
import '../models/models.dart';

class HistoryProvider with ChangeNotifier {
  HistoryProvider() {
    // Initialize with dummy data
    //_initializeDummyData();
  }

  List<Result> _history = [];

  List<Result> get history => _history;

  void setResult(List<Result> results) {
    _history = results;
    notifyListeners();
  }

  void addResult(Result result) {
    _history.add(result);
    notifyListeners();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }

  //dummy data for test
  void _initializeDummyData() {
    final dummyReports = [
      Report(
        status: 'Completed',
        timeStamp: '2024-05-01 10:00:00',
        diseases: 'Disease A, Disease B',
        location: 'Location X',
        severity: 'High',
        confidenceLevel: 0.95,
      ),
      Report(
        status: 'Pending',
        timeStamp: '2024-05-02 11:30:00',
        diseases: 'Disease C',
        location: 'Location Y',
        severity: 'Medium',
        confidenceLevel: 0.80,
      ),
      Report(
        status: 'Completed',
        timeStamp: '2024-05-03 14:00:00',
        diseases: 'Disease D, Disease E',
        location: 'Location Z',
        severity: 'Low',
        confidenceLevel: 0.60,
      ),
    ];

    final dummyDiseaseInfos = [
      DiseaseInfo(
        diagnosis: 'Diagnosis A',
        recommendations: 'Recommendation A1, Recommendation A2',
        additional: 'Additional Info A',
      ),
      DiseaseInfo(
        diagnosis: 'Diagnosis B',
        recommendations: 'Recommendation B1, Recommendation B2',
        additional: 'Additional Info B',
      ),
      DiseaseInfo(
        diagnosis: 'Diagnosis C',
        recommendations: 'Recommendation C1, Recommendation C2',
        additional: 'Additional Info C',
      ),
    ];

    for (int i = 0; i < dummyReports.length; i++) {
      _history.add(
          Result(report: dummyReports[i], diseaseInfo: dummyDiseaseInfos[i]));
    }

    notifyListeners();
  }
}
