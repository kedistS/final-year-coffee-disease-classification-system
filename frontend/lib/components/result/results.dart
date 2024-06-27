import 'dart:developer';

import 'package:bunnaapp/providers/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analysis_summary.dart';
import 'disease_information.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  ResultProvider? _resultProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize _resultProvider here to ensure the context is active
    _resultProvider = Provider.of<ResultProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // Call the clearResult function from the ResultProvider
    log("disposed");
    _resultProvider?.clearResult();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: ListView(
        children: const [
          AnalysisSummary(),
          DiseaseInformation(),
        ],
      ),
    );
  }
}
