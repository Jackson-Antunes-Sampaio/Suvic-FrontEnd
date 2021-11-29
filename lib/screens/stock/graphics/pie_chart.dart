import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/utils/styles/style.dart';
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
  var colors = [kPrimaryColor, Colors.green, Colors.blue, Colors.orange];

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
            SizedBox(
              width: double.maxFinite,
              height: 130,
              child: ListView.builder(
                  itemCount: vaccines.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Indicator(
                          color: colors[index],
                          text: vaccines[index].name,
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 18,
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
    int totalqty = 0;
    //total
    for (var item in vaccines) {
      totalqty = totalqty + item.quantidade;
    }

    return List.generate(vaccines.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 165.0;
      var total =
          ((vaccines[i].quantidade / totalqty) * 100).toStringAsFixed(2);

      return PieChartSectionData(
        color: colors[i],
        value: double.parse(total),
        title: '$total%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}
