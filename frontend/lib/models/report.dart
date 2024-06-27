class Report {
  String status;
  String timeStamp;
  String diseases;
  String location;
  String severity;
  double confidenceLevel;

  Report({
    required this.status,
    required this.timeStamp,
    required this.diseases,
    required this.location,
    required this.severity,
    required this.confidenceLevel,
  });

  static Report dummyReport = Report(
    confidenceLevel: 97.7,
    timeStamp: "Jan 13, 2024, 10:45 AM",
    diseases: "Coffee Rust",
    location: "Lat 10.1234, Lon -75.5678",
    severity: "moderate",
    status: "Completed",
  );

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      status: json['status'] ?? 'Completed',
      timeStamp: json['timestamp'] ?? '',
      diseases: json['disease_name'] ?? '',
      location: json['region'] ?? '',
      severity: json['severity'] ?? '',
      confidenceLevel: double.tryParse(json['confidence'] ?? '0.0') ??
          json['confidence']?.toDouble() ??
          0.0,
    );
  }
}
