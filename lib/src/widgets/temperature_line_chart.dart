import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/weather.dart';

/// Renders a line chart from forecast data
/// x axis - date
/// y axis - temperature
class TemperatureLineChart extends StatefulWidget {
  final List<WeatherMap> weathers;
  final bool? animate;

  TemperatureLineChart(this.weathers, {this.animate});

  @override
  State<TemperatureLineChart> createState() => _TemperatureLineChartState();
}

class _TemperatureLineChartState extends State<TemperatureLineChart> {
  @override
  Widget build(BuildContext context) {
    print('The graph weatherList is ${widget.weathers.length}');

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 5000,
            interval: 1000,
            //labelFormat: r'$value',
            title: AxisTitle(text: 'Soil Moisture'),
          ),
          series: [
            LineSeries<WeatherMap, DateTime>(
              dataSource: widget.weathers,
              xValueMapper: (WeatherMap weather, _) =>
                  DateTime.fromMillisecondsSinceEpoch(weather.time! * 1000),
              yValueMapper: (WeatherMap weather, _) => weather.soilMoisture,
              color: const Color.fromRGBO(242, 117, 7, 1),
            )
          ]),
    );
  }
}
