import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class PieChartScheduled extends StatefulWidget {
  PieChartScheduled({required this.vaccines});
  final List<StockVacineModel> vaccines;
  @override
  State<StatefulWidget> createState() => PieChart2State(vaccines: vaccines);
}

class PieChart2State extends State {
  PieChart2State({required this.vaccines});
  final List<StockVacineModel> vaccines;
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
                  // text: vaccines[0].name,
                  text: 'Agendamentos Concluídos',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  // text: vaccines[1].name,
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
    int totalqty = vaccines[0].quantidade +
        vaccines[1].quantidade +
        vaccines[2].quantidade +
        vaccines[3].quantidade;

    var total1 = ((vaccines[0].quantidade / totalqty) * 100).toStringAsFixed(2);
    var total2 = ((vaccines[1].quantidade / totalqty) * 100).toStringAsFixed(2);

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
