import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class PieChartStock extends StatefulWidget {
  PieChartStock({required this.vaccines});
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
                  color: kPrimaryColor,
                  text: vaccines[0].name,
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.green,
                  text: vaccines[1].name,
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.blue,
                  text: vaccines[2].name,
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.orange,
                  text: vaccines[3].name,
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
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
    var total3 = ((vaccines[2].quantidade / totalqty) * 100).toStringAsFixed(2);
    var total4 = ((vaccines[3].quantidade / totalqty) * 100).toStringAsFixed(2);

    // print('tota:' + total1);
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 165.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kPrimaryColor,
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
            color: Colors.green,
            value: double.parse(total2),
            title: '$total2%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: double.parse(total3),
            title: '$total3%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: double.parse(total4),
            title: '$total4%',
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
