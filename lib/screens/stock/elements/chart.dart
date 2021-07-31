import 'package:covid_19/utils/styles/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget chartStock(BuildContext context) {
  List<PieChartSectionData> pieChartSectionData = [
    PieChartSectionData(
      color: kPrimaryColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Color(0xFF26E5FF),
      value: 20,
      showTitle: false,
      radius: 22,
    ),
    PieChartSectionData(
      color: Color(0xFFFFCF26),
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: Color(0xFFEE2727),
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: kPrimaryColor.withOpacity(0.1),
      value: 25,
      showTitle: false,
      radius: 13,
    ),
  ];

  return SizedBox(
    height: 200,
    child: Stack(
      children: [
        PieChart(
          PieChartData(
            startDegreeOffset: -90,
            sectionsSpace: 0,
            centerSpaceRadius: 50,
            sections: pieChartSectionData,
          ),
        ),
        Positioned.fill(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '29%',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w600),
            ),
          ],
        ))
      ],
    ),
  );
}
