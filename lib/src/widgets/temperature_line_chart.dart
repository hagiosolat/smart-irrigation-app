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
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: SfCartesianChart(
          primaryXAxis:DateTimeAxis(

          ),
          primaryYAxis:NumericAxis(
            minimum: 0,
            maximum: 5000,
            interval: 500,
            labelFormat: r'$value',
            title: AxisTitle(text: 'Soil Moisture'),

          ),
          
          series: [  
            LineSeries<WeatherMap, DateTime>
            (dataSource: widget.weathers, 
            xValueMapper: (WeatherMap weather, _) => DateTime.fromMillisecondsSinceEpoch(weather.time! * 1000),
            yValueMapper: (WeatherMap weather,_) => weather.soilMoisture,
            color:  Color.fromRGBO(242, 117, 7, 1),
             )        
          ]        
          
          // new charts.Series<Weather, DateTime>(
          //   id: 'Temperature',
          //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          //   domainFn: (Weather weather, _) =>
          //       DateTime.fromMillisecondsSinceEpoch(weather.time * 1000),
          //   measureFn: (Weather weather, _) => weather.temperature
          //       .as(AppStateContainer.of(context).temperatureUnit),
          //   data: weathers,
          // )
        
      ),
    );
  }
}
