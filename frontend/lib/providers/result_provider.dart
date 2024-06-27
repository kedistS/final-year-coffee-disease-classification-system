import 'package:flutter/material.dart';
import '../models/models.dart';

class ResultProvider with ChangeNotifier {
  Result? _result;

  ResultProvider() {
    // Initialize with dummy data
    // _initializeDummyData();
  }

  Result? get result => _result;

  void setResult(Result result) {
    _result = result;
    notifyListeners();
  }

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  void _initializeDummyData() {
    final dummyReport = Report(
      status: 'Completed',
      timeStamp: '2024-05-01 10:00:00',
      diseases: 'Miner',
      location: 'Amhara',
      severity: 'moderate',
      confidenceLevel: 0.95,
    );

    final dummyDiseaseInfo = DiseaseInfo(
      diagnosis:
          'The coffee leaf miner larvae tunnel through the leaf tissues, creating serpentine mines. These mines appear as whitish or silverish trails on the leaves. Infested leaves may curl, turn yellow, and drop prematurely. Severe infestations can lead to reduced photosynthesis and decreased yields.',
      recommendations:
          'Integrated pest management (IPM) practices are commonly used to control coffee leaf miners. This involves a combination of cultural, biological, and chemical control methods. Cultural practices include maintaining good plant nutrition and hygiene, pruning affected branches, and destroying infested leaves. Biological control involves promoting natural enemies of the leaf miner, such as parasitic wasps. Insecticides can be used if necessary, but their application should follow sustainable practices and be based on expert advice.',
      additional:
          'The coffee leaf miner is a small insect pest that affects coffee plants. It is the larval stage of the moth Leucoptera coffeella.',
    );

    _result = Result(report: dummyReport, diseaseInfo: dummyDiseaseInfo);

    notifyListeners();
  }
}
