import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bunnaapp/models/models.dart';
import 'package:bunnaapp/providers/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/user_providers.dart';
import '../utils/urls.dart';

String backendUrl = GlobalUrl.rootUrl;

//the function send the image to be processed by the AI model on the backend and accepts the result

Future<String?> processImage(File imageFile, BuildContext context) async {
  final url = Uri.parse('$backendUrl/coffee-disease-detection');

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String? authToken = userProvider.authToken;

  if (authToken == null) {
    log('Auth token not found');
    return 'Auth token not found';
  }

  var request = http.MultipartRequest('POST', url);
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  request.headers['Authorization'] = 'Bearer $authToken';

  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);

      // class is returned when the image is not coffee leaf
      if (jsonResponse['class'] != null) {
        return "Image contains anomaly try to take another picture";
      } else {
        var report = Report.fromJson(jsonResponse);
        var diseaseInfo = DiseaseInfo.fromJson(jsonResponse);

        Provider.of<ResultProvider>(context, listen: false)
            .setResult(Result(diseaseInfo: diseaseInfo, report: report));

        return null; // No error
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      log('Failed to process image: $responseBody');
      return 'Failed to process image: ${jsonDecode(responseBody)['error'] ?? 'Unknown error'}';
    }
  } catch (e) {
    log('Exception while processing image: $e');
    return 'Network or server error, try again!';
  }
}
