import 'package:bunnaapp/models/report.dart';
import 'package:bunnaapp/models/disease_info.dart';

class Result {
  Report report;
  DiseaseInfo diseaseInfo;

  Result({
    required this.report,
    required this.diseaseInfo,
  });
}
