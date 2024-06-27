import 'dart:developer';

import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/components/researcher/bar_graph.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  List<String> shortenRegionNames(List<String> regions) {
    return regions.map((region) {
      if (region.length > 6) {
        if (region.contains(' ')) {
          List<String> words = region.split(' ');
          return '${words.map((word) => word[0]).join('.')}.';
        } else {
          return region.substring(0, 6);
        }
      } else {
        return region;
      }
    }).toList();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  final Map<String, Color> diseaseColorMap = {
    'Miner': Colors.red,
    'Cerscospora': Colors.yellow,
    'Leaf rust': Colors.green,
    'Phoma': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    final Map<String, List<List>> barData =
        context.read<AnalyticsProvider>().analytics?.getBarData();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      endDrawer: UserDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text("Disease distribution per region ",
                        style: TextStyle(fontSize: 24)),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 231, 230, 230),
                  indent: 16,
                  endIndent: 16,
                ),
                if (barData != null)
                  Column(
                    children: barData.entries.map((entry) {
                      String disease = entry.key;
                      List<int> frequencies = entry.value[0].cast<int>();
                      List<String> regions = entry.value[1].cast<String>();
                      Color? barColor = diseaseColorMap.containsKey(disease)
                          ? diseaseColorMap[disease]
                          : getRandomColor();
                      return _buildBarChartSample(
                        frequencies: frequencies,
                        regions: shortenRegionNames(regions),
                        barColor: barColor!,
                        title: disease,
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarChartSample({
    required List<int> frequencies,
    required List<String> regions,
    required Color barColor,
    required String title,
  }) {
    // Determine the width of each bar and the total width required
    const double barWidth = 50.0;
    double totalWidth = regions.length * barWidth;

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 223, 222, 222)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: max(
            totalWidth,
            MediaQuery.of(context).size.width -
                32), // Ensure the chart has enough width
        child: DiseaseChart(
          frequencies: frequencies,
          regions: regions,
          barColor: barColor,
          diseaseName: title,
        ),
      ),
    );
  }
}
