class DiseaseInfo {
  String diagnosis;
  String recommendations;
  String additional;

  DiseaseInfo({
    required this.diagnosis,
    required this.recommendations,
    required this.additional,
  });

  static DiseaseInfo dummyInfo = DiseaseInfo(
    diagnosis:
        "The analysis of the provided image indicates the presence of coffee rust disease. The severity is assessed as moderate with a confidence level of 97%. Coffee rust is a fungal disease caused by Hemileia vastatrix and can negatively impact coffee plant health.",
    recommendations:
        """Immediate Treatment: Apply recommended fungicides to control the spread
      Monitorin Regularly inspect neighboring plants for signs of infection
      Weather Considerations: Take note of weather conditions favoring rust development.""",
    additional:
        """Previous Reports: Check if there are previous reports of coffee rust in the vicinity.
      Preventive Measures: Consider implementing preventive measures to protect nearby coffee plants.""",
  );

  factory DiseaseInfo.fromJson(Map<String, dynamic> json) {
    return DiseaseInfo(
        diagnosis: json['description'] ?? '',
        recommendations: (json['treatment']),
        additional: (json['symptoms']));
  }
}
