import 'dart:convert';
import 'dart:developer';
import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:bunnaapp/models/models.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:bunnaapp/providers/epidemic_provider.dart';
import 'package:bunnaapp/providers/history_provider.dart';
import 'package:bunnaapp/providers/result_provider.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/urls.dart';

String backendUrl = GlobalUrl.rootUrl;

//function to register the user from the sign up page
Future<bool> register(User user) async {
  log(user.toJsonString());
  final url = Uri.parse('$backendUrl/register');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: user.toJsonString(),
  );

  log(response.statusCode.toString());
  if (response.statusCode == 201) {
    log("user registered successfully");
    return true;
  } else {
    log('Failed to register user: ${response.body}');
    return false;
  }
}

Future<bool> login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  final url = Uri.parse('$backendUrl/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (responseBody != null) {
      final userName = responseBody['firstName'];
      final authToken = responseBody['access_token'];
      final role = responseBody['occupation'];
      final userId = responseBody['user_id'];

      //for test
      final epidemics = responseBody["Epidemic Disease"];

      final List<Disease> diseases =
          (epidemics as List).map((i) => Disease.fromJson(i)).toList();

      Provider.of<EpidemicProvider>(context, listen: false)
          .setEpidemic(diseases);

      Provider.of<UserProvider>(context, listen: false).setUser(
        username: userName,
        role: role,
        authToken: authToken,
        userId: userId,
      );

      return true;
    } else {
      log('Auth token or user info not found in the response');
      return false;
    }
  } else {
    log('Failed to login: ${response.body}');
    return false;
  }
}

Future<bool> logout(BuildContext context) async {
  context.read<UserProvider>().clearUser();
  context.read<ResultProvider>().clearResult();
  context.read<HistoryProvider>().clearHistory();
  context.read<AnalyticsProvider>().clearResult();
  context.read<EpidemicProvider>().clearEpidemic();

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SignIn()),
    (route) => false,
  );

  return true;
}

Future<bool> forgotPassword(String email) async {
  final url = Uri.parse('$backendUrl/forgot-password');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 201) {
    log("code sent successful");
    return true;
  } else {
    log('Failed to request password reset: ${response.body}');
    return false;
  }
}

Future<bool> updateUser(User user, BuildContext context) async {
  final userProvider = context.read<UserProvider>();
  final userId = userProvider.userId;

  final url = Uri.parse('$backendUrl/users/$userId');
  final authToken = userProvider.authToken;

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    },
    body: user.toJsonString(),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    log('Failed to update user: ${response.body}');
    return false;
  }
}

Future<User?> getUser(BuildContext context) async {
  final userProvider = context.read<UserProvider>();
  final authToken = userProvider.authToken;
  final userId = userProvider.userId;

  if (userId == null) {
    log('User ID is null');
    return null;
  }

  final url = Uri.parse('$backendUrl/users/$userId');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    },
  );

  if (response.statusCode == 200) {
    try {
      final responseBody = json.decode(response.body);
      log("responseBody: $responseBody");

      final user = User.fromJson(responseBody);
      log("User: $user");
      return user;
    } catch (e) {
      log('Error decoding JSON: $e');
      return null;
    }
  } else {
    log('Failed to get user: ${response.body}');
    return null;
  }
}

Future<bool> changePassword(
    BuildContext context, String oldPassword, String newPassword) async {
  final userProvider = context.read<UserProvider>();
  final authToken = userProvider.authToken;
  if (authToken == null) {
    log('no auth token');
    return false;
  }

  final url = Uri.parse('$backendUrl/change-password');
  final response = await http.post(url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      },
      body:
          jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}));

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<bool> resetPassword(String code, String newPassword) async {
  final url = Uri.parse('$backendUrl/reset-password');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code, 'password': newPassword}));
  log('${response.statusCode}');
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
