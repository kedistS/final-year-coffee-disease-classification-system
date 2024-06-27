import 'package:bunnaapp/providers/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../result/results.dart';

class ProcessingCard extends StatelessWidget {
  const ProcessingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(context, listen: true);
    final disable = resultProvider.result == null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 360, // Adjust this width as needed
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 5000,
              percent: 0.9,
              center:
                  Text(disable ? "Processing image..." : "finished processing"),
              barRadius: const Radius.circular(12),
              progressColor: Colors.green.shade800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 72, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: ${disable ? "processing" : "completed"}"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: disable
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Results()),
                        );
                      },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(120, 50),
                  backgroundColor: disable ? Colors.grey : null,
                ),
                child: const Center(child: Text("Result")),
              ),
              TextButton(
                onPressed: () {
                  //TODO: add functionality to stop the processing
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(120, 50),
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                ),
                child: const Center(
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
