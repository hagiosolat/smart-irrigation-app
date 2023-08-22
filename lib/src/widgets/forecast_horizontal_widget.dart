import 'package:flutter/material.dart';
import 'package:irrigation1/src/model/weather.dart';
import 'package:irrigation1/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';

/// Renders a horizontal scrolling list of weather conditions
/// Used to show forecast
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  final List<WeatherMap> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weathers.length,
        separatorBuilder: (context, index) => const Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(item.time! * 1000)),
              '${(item.soilMoisture! * 100) ~/ 4095}%',
              // iconData: item.getIconData(),
            )),
          );
        },
      ),
    );
  }
}
