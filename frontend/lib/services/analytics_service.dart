import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/analytics.dart';
import '../providers/analytics_provider.dart';
import '../providers/user_providers.dart';
import '../utils/urls.dart';

String backendUrl = GlobalUrl.rootUrl;

// This function is responsible for fetching the analytics data from the backend server.
// It takes the BuildContext as a parameter, which is used to access the UserProvider and AnalyticsProvider.
Future<bool> fetchAnalyticsData(BuildContext context) async {
  final String? authToken = context.read<UserProvider>().authToken;

  if (authToken == null) {
    log('Auth token not found');
    throw Exception('Auth token not found');
  }

  final url = Uri.parse('$backendUrl/researcher-page');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final reports = jsonResponse['Total disease Report'];
      log(reports.toString());

      final List<Disease> countByDisease = (reports['count_by_disease'] as List)
          .map((i) => Disease.fromJson(i))
          .toList();

      final List<Region> countByRegion = (reports['count_by_region'] as List)
          .map((i) => Region.fromJson(i))
          .toList();

      final Map<String, List<DiseasePrevalency>> prevalencyMap = {};
      final prevalencyJson =
          reports['prevalence_per_region'] as Map<String, dynamic>;

      prevalencyJson.forEach((key, value) {
        final List<DiseasePrevalency> diseasePrevalency = [];

        (value as List<dynamic>).forEach((element) {
          diseasePrevalency.add(DiseasePrevalency(
            disease: key,
            count: element['count'].toString(),
            region: element['region'],
          ));
        });

        prevalencyMap[key] = diseasePrevalency;
      });

      final analytics = Analytics(
        averageConfidence: jsonResponse['Average Confidence'],
        totalDiseaseReport: reports['total_reports'],
        countByDisease: countByDisease,
        countByRegion: countByRegion,
        prevalency: prevalencyMap,
      );

      context.read<AnalyticsProvider>().setResult(analytics);
      return true;
    } else {
      log('Failed to load analytics data: ${response.body}');
      throw Exception('Failed to load analytics data');
    }
  } catch (e) {
    // Handle network error
    log('Network error: $e');
    throw Exception('Network error occurred');
  }
}
