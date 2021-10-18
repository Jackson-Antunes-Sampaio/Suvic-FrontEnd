
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:suvic_app/models/scheduledModel.dart';
import 'indicator.dart';

class PieChartScheduled extends StatefulWidget {
  PieChartScheduled({required this.scheduleds});
  final List<ScheduledModel> scheduleds;
  @override
  State<StatefulWidget> createState() => PieChart2State(scheduleds: scheduleds);
}

class PieChart2State extends State {
  PieChart2State({required this.scheduleds});
  final List<ScheduledModel> scheduleds;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            final desiredTouch = pieTouchResponse.touchInput
                                    is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                            if (desiredTouch &&
                                pieTouchResponse.touchedSection != null) {
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            } else {
                              touchedIndex = -1;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections()),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Indicator(
                  color: Colors.green,
                  // text: scheduleds[0].name,
                  text: 'Agendamentos Concluídos',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  // text: scheduleds[1].name,
                  text: 'Agendamentos Pendentes',
                  isSquare: true,
                ),
              ],
            ),
            const SizedBox(
              width: 0,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var complete =
        (scheduleds.where((element) => element.status == 'complete')).length;
    var incomplet =
        (scheduleds.where((element) => element.status != 'complete')).length;

    int totalqty = complete + incomplet;

    var total1 = ((complete / totalqty) * 100).toStringAsFixed(2);
    var total2 = ((incomplet / totalqty) * 100).toStringAsFixed(2);

    // print('tota:' + total1);
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 165.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: double.parse(total1),
            title: '$total1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: double.parse(total2),
            title: '$total2%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
