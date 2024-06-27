import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  final List<String> diseaseNames;
  final List<double> percentages;

  const PieChartSample2({
    super.key,
    required this.diseaseNames,
    required this.percentages,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.diseaseNames.length, (index) {
              return Column(
                children: [
                  Indicator(
                    color: getColor(index),
                    text: widget.diseaseNames[index],
                    isSquare: true,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.diseaseNames.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.white, blurRadius: 3)];
      return PieChartSectionData(
        color: getColor(i),
        value: widget.percentages[i],
        title: '${widget.percentages[i]}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 36, 36, 36),
          shadows: shadows,
        ),
      );
    });
  }

  Color getColor(int index) {
    switch (index % 4) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
