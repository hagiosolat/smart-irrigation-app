import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:irrigation1/main.dart';
import 'package:irrigation1/src/model/weather.dart';
import 'package:irrigation1/src/widgets/current_conditions.dart';
import 'package:irrigation1/src/widgets/empty_widget.dart';
import 'package:irrigation1/src/widgets/temperature_line_chart.dart';

class WeatherSwipePager extends StatelessWidget {
  const WeatherSwipePager({
    Key? key,
    required this.weather,
    this.weatherList,
  }) : super(key: key);

  final WeatherMap weather;
  final List<WeatherMap>? weatherList;

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CurrentConditions(
              weather: weather,
            );
          } 
          else if (index == 1) {
            return TemperatureLineChart(
              weatherList!,
            );
          }
          return EmptyWidget();
        },
        pagination:  SwiperPagination(
          margin: EdgeInsets.all(5.0),
          builder:  DotSwiperPaginationBuilder(
              size: 5,
              activeSize: 5,
              color: AppStateContainer.of(context)
                  .theme
                  .colorScheme.secondary
                  .withOpacity(0.4),
              activeColor: appTheme.colorScheme.secondary),
        ),
      ),
    );
  }
}
