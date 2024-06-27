import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:bunnaapp/providers/epidemic_provider.dart';
import 'package:bunnaapp/providers/history_provider.dart';
import 'package:bunnaapp/providers/result_provider.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ResultProvider()),
      ChangeNotifierProvider(create: (context) => HistoryProvider()),
      ChangeNotifierProvider(create: (context) => AnalyticsProvider()),
      ChangeNotifierProvider(create: (context) => EpidemicProvider()),
    ],
    child: const Bunna(),
  ));
}

class Bunna extends StatelessWidget {
  const Bunna({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.light();
    return MaterialApp(
      // Coffee disease classifier application
      debugShowCheckedModeBanner: false,
      title: "CODICAP",
      home: const SignIn(),

      theme: theme,
    );
  }
}
