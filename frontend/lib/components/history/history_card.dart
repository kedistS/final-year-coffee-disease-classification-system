import 'package:bunnaapp/components/result/results.dart';
import 'package:bunnaapp/models/models.dart';
import 'package:bunnaapp/providers/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final Result result;
  const HistoryCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ResultProvider>().clearResult();
        context.read<ResultProvider>().setResult(result);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Results()));
      },
      child: Card(
        color: const Color.fromARGB(245, 133, 252, 100).withOpacity(0.5),
        child: Column(
          children: [
            ListTile(
              title: Text("Status: ${result.report.status}"),
              subtitle: Text("Timestamp: ${result.report.timeStamp}"),
            ),
          ],
        ),
      ),
    );
  }
}
