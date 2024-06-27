import 'dart:convert';
import 'dart:developer';
import 'package:bunnaapp/providers/history_provider.dart';
import 'package:http/http.dart' as http;
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/urls.dart';
import '../models/models.dart';

String backendUrl = GlobalUrl.rootUrl;

//This function fetches the user history specified by the user id

Future<void> fetchHistoryData(BuildContext context) async {
  final String? authToken = context.read<UserProvider>().authToken;
  final int? userId = context.read<UserProvider>().userId;

  if (authToken == null) {
    log('Auth token not found');
    throw Exception('Auth token not found');
  }

  final url = Uri.parse('$backendUrl/users/$userId');
  log('Request URL: $url');
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    log('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<dynamic> reports = responseBody['report'];

      for (var reportData in reports) {
        final Report report = Report.fromJson(reportData);

        final DiseaseInfo diseaseInfo = DiseaseInfo.fromJson(reportData);

        context.read<HistoryProvider>().addResult(Result(
              report: report,
              diseaseInfo: diseaseInfo,
            ));
      }

      log('Added ${reports.length} reports to history');
    } else {
      final responseBody = response.body;
      log('Failed to get history: $responseBody');
      throw Exception('Failed to get history');
    }
  } catch (e) {
    // Handle network error
    log('Network error: $e');
    throw Exception('Network error occurred');
  }
}
