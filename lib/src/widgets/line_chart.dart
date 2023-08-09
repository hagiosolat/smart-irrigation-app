// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:irrigation1/src/model/weather.dart';
// import 'package:irrigation1/src/utils/constants.dart';

// // class _LineChart extends StatelessWidget {
// //   _LineChart({required this.series});

// //   var dividend = 0;
// //   var dividend2 = 150;

// //   @override
// //   Widget build(BuildContext context) {
// //     series.forEach(
// //       (weather) {
// //         dividend = dividend + 1215785790;

// //         print(weather.time);
// //         print(weather.soilMoisture);
// //         var x = ((weather.time!) / dividend) as double;
// //         final y = (weather.soilMoisture!) / dividend2 as double;
// //         x++;

// //         dividend2 += 25;
// //         print("x coordinates $x");
// //         print(y);
// //         if (!spots.contains(FlSpot(x, y))) {
// //           spots.add(FlSpot(x, y));
// //         }
// //       },
// //     );
// //     print("spot List is ${spots}");
// //     return LineChart(
// //       sampleData1,
// //       swapAnimationDuration: const Duration(milliseconds: 250),
// //     );
// //   }

// //   LineChartData get sampleData1 => LineChartData(
// //         lineTouchData: lineTouchData1,
// //         gridData: gridData,
// //         titlesData: titlesData1,
// //         borderData: borderData,
// //         lineBarsData: lineBarsData1,
// //         minX: 0,
// //         maxX: 14,
// //         maxY: 4096,
// //         minY: 0,
// //       );

// //   LineTouchData get lineTouchData1 => LineTouchData(
// //         handleBuiltInTouches: true,
// //         touchTooltipData: LineTouchTooltipData(
// //           tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
// //         ),
// //       );

// //   FlGridData get gridData => FlGridData(show: false);

// //   FlTitlesData get titlesData1 => FlTitlesData(
// //         bottomTitles: AxisTitles(
// //           sideTitles: bottomTitles,
// //         ),
// //         rightTitles: AxisTitles(
// //           sideTitles: SideTitles(showTitles: false),
// //         ),
// //         topTitles: AxisTitles(
// //           sideTitles: SideTitles(showTitles: false),
// //         ),
// //         leftTitles: AxisTitles(
// //           sideTitles: leftTitles(),
// //         ),
// //       );

// //   FlBorderData get borderData => FlBorderData(
// //         show: true,
// //         border: Border(
// //           bottom:
// //               BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
// //           left: const BorderSide(color: Colors.transparent),
// //           right: const BorderSide(color: Colors.transparent),
// //           top: const BorderSide(color: Colors.transparent),
// //         ),
// //       );

// //   List<LineChartBarData> get lineBarsData1 => [
// //         lineChartBarData1_4,
// //       ];

// //   LineChartBarData get lineChartBarData1_4 => LineChartBarData(
// //       isCurved: true,
// //       color: AppColors.contentColorOrange,
// //       barWidth: 8,
// //       isStrokeCapRound: true,
// //       dotData: FlDotData(show: false),
// //       belowBarData: BarAreaData(show: false),
// //       spots: spots);

// //   Widget leftTitleWidgets(double value, TitleMeta meta) {
// //     const style = TextStyle(
// //       fontWeight: FontWeight.bold,
// //       fontSize: 14,
// //     );
// //     String text;
// //     switch (value.toInt()) {
// //       case 1:
// //         text = '1m';
// //         break;
// //       case 2:
// //         text = '2m';
// //         break;
// //       case 3:
// //         text = '3m';
// //         break;
// //       case 4:
// //         text = '5m';
// //         break;
// //       case 5:
// //         text = '6m';
// //         break;
// //       default:
// //         return Container();
// //     }

// //     return Text(text, style: style, textAlign: TextAlign.center);
// //   }

// //   SideTitles leftTitles() => SideTitles(
// //         getTitlesWidget: leftTitleWidgets,
// //         showTitles: true,
// //         interval: 1,
// //         reservedSize: 40,
// //       );

// //   Widget bottomTitleWidgets(double value, TitleMeta meta) {
// //     const style = TextStyle(
// //       fontWeight: FontWeight.bold,
// //       fontSize: 16,
// //     );
// //     Widget text;
// //     switch (value.toInt()) {
// //       case 2:
// //         text = const Text('SEPT', style: style);
// //         break;
// //       case 7:
// //         text = const Text('OCT', style: style);
// //         break;
// //       case 12:
// //         text = const Text('DEC', style: style);
// //         break;
// //       default:
// //         text = const Text('');
// //         break;
// //     }

// //     return SideTitleWidget(
// //       axisSide: meta.axisSide,
// //       space: 10,
// //       child: text,
// //     );
// //   }

// //   SideTitles get bottomTitles => SideTitles(
// //         showTitles: true,
// //         reservedSize: 32,
// //         interval: 1,
// //         getTitlesWidget: bottomTitleWidgets,
// //       );
// // }

// // class LineChartSample1 extends StatefulWidget {
// //   const LineChartSample1({required this.weatherList, super.key});
// //   final List<WeatherMap> weatherList;

// //   @override
// //   State<StatefulWidget> createState() => LineChartSample1State();
// // }

// // class LineChartSample1State extends State<LineChartSample1> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AspectRatio(
// //       aspectRatio: 1.23,
// //       child: Stack(
// //         children: <Widget>[
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: <Widget>[
// //               const SizedBox(
// //                 height: 37,
// //               ),
// //               const Text(
// //                 'Soil_Moisture Data',
// //                 style: TextStyle(
// //                   color: AppColors.primary,
// //                   fontSize: 32,
// //                   fontWeight: FontWeight.bold,
// //                   letterSpacing: 2,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(
// //                 height: 37,
// //               ),
// //               Expanded(
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(right: 16, left: 6),
// //                   child: _LineChart(series: widget.weatherList),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //             ],
// //           ),
// //           IconButton(
// //             icon: Icon(
// //               Icons.refresh,
// //               color: Colors.white.withOpacity(1.0),
// //             ),
// //             onPressed: () {
// //               setState(() {
// //                 //isShowingMainData = !isShowingMainData;
// //               });
// //             },
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// class LineChartSample9 extends StatelessWidget {
//   LineChartSample9({required this.series, super.key});
//   final List<FlSpot> spots = [];
//   final List<WeatherMap> series;

//   Widget bottomTitleWidgets(
//     double value,
//     TitleMeta meta,
//     double chartwidth,
//     // List<WeatherMap> series
//   ) {
//     //bring the value back to extra_time
//     //Note that valuue is in minutes...
//     var extratime = value % (24 * 60 * 60); //extratime % 3600
//     var minutes = (extratime % 3600) / 60; //minutes
    
//     //var hour = extratime ~/ 3600;

//     if (minutes % 15 != 0) {
//       return Container();
//     }
//     final style = TextStyle(
//       color: AppColors.contentColorBlue,
//       fontWeight: FontWeight.bold,
//       fontSize: min(18, 18 * chartwidth / 300),
//     );
//     // return
//     return SideTitleWidget(
//         axisSide: meta.axisSide,
//         space: 16,
//         child: Text(
//           DateFormat('h:m a').format(
//               DateTime.fromMillisecondsSinceEpoch((value.toInt() * 1000))),
//           //Text(meta.formattedValue, style: style)
//         ));
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
//     const style = TextStyle(
//         color: AppColors.contentColorBlack,
//         fontWeight: FontWeight.bold,
//         fontSize: 12
//         //min(18, 18 * chartWidth / 300),
//         );
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16,
//       child: Text(meta.formattedValue, style: style),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     series.forEach(
//       (weather) {
//         print(weather.time);
//         print(weather.soilMoisture);
//         //var extratime = weather.time! % (24 * 60 * 60);
//         //var hour = extratime ~/ 3600;
//         //var x = (extratime % 3600) / 60; // minutes
//         var x = weather.time! / 1.0;
//         final y = weather.soilMoisture! / 1.0;

//         print("x coordinates $x");
//         print(y);
//         if (!spots.contains(FlSpot(x, y))) {
//           spots.add(FlSpot(x, y));
//         }
//       },
//     );
//     print("spot List is ${spots}");

//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 12,
//         bottom: 12,
//         right: 20,
//         top: 20,
//       ),
//       child: AspectRatio(
//         aspectRatio: 2,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return LineChart(
//               LineChartData(
//                 lineTouchData: LineTouchData(
//                   touchTooltipData: LineTouchTooltipData(
//                     maxContentWidth: 100,
//                     tooltipBgColor: Colors.black,
//                     getTooltipItems: (touchedSpots) {
//                       return touchedSpots.map((LineBarSpot touchedSpot) {
//                         final textStyle = TextStyle(
//                           color: touchedSpot.bar.gradient?.colors[0] ??
//                               touchedSpot.bar.color,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         );
//                         return LineTooltipItem(
//                           '${touchedSpot.x}, ${touchedSpot.y.toStringAsFixed(2)}',
//                           textStyle,
//                         );
//                       }).toList();
//                     },
//                   ),
//                   handleBuiltInTouches: true,
//                   getTouchLineStart: (data, index) => 0,
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                     color: AppColors.contentColorPink,
//                     spots: spots,
//                     isCurved: true,
//                     isStrokeCapRound: true,
//                     barWidth: 2,
//                     belowBarData: BarAreaData(
//                       show: false,
//                     ),
//                     dotData: FlDotData(show: false),
//                   ),
//                 ],
//                 minX: ,
//                 minY: 0,
//                 maxY: 5000,
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) =>
//                           leftTitleWidgets(value, meta, constraints.maxWidth),
//                       reservedSize: 30,
//                       interval: 1000,
//                     ),
//                     drawBehindEverything: true,
//                   ),
//                   rightTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) => bottomTitleWidgets(
//                             value, meta, constraints.maxWidth),
//                         reservedSize: 60,
//                         interval: 900000),
//                     drawBehindEverything: true,
//                   ),
//                   topTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                 ),
//                 // gridData: FlGridData(
//                 //   show: true,
//                 //   drawHorizontalLine: true,
//                 //   drawVerticalLine: true,
//                 //   horizontalInterval: 1.5,
//                 //   verticalInterval: 5,
//                 //   checkToShowHorizontalLine: (value) {
//                 //     return value.toInt() == 0;
//                 //   },
//                 //   getDrawingHorizontalLine: (_) => FlLine(
//                 //     color: AppColors.contentColorBlue.withOpacity(1),
//                 //     dashArray: [8, 2],
//                 //     strokeWidth: 0.8,
//                 //   ),
//                 //   getDrawingVerticalLine: (_) => FlLine(
//                 //     color: AppColors.contentColorYellow.withOpacity(1),
//                 //     dashArray: [8, 2],
//                 //     strokeWidth: 0.8,
//                 //   ),
//                 //   checkToShowVerticalLine: (value) {
//                 //     return value.toInt() == 0;
//                 //   },
//                 // ),
//                 borderData: FlBorderData(show: false),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
