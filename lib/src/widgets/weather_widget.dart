import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irrigation1/main.dart';
import 'package:irrigation1/src/bloc/weather_bloc.dart';
import 'package:irrigation1/src/bloc/weather_state.dart';
import 'package:irrigation1/src/bloc/weather_event.dart';
import 'package:irrigation1/src/model/weather.dart';
import 'package:irrigation1/src/widgets/forecast_horizontal_widget.dart';
import 'package:irrigation1/src/widgets/value_tile.dart';
import 'package:irrigation1/src/widgets/weather_swipe_pager.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherMap weather;
  final List<WeatherMap>? weatherList;
  bool? buttonState;

  WeatherWidget({required this.weather, this.weatherList, this.buttonState});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    print('This is the WeatherList of the weather Page ${weatherList!.length}');

    return Center(
      child: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is ButtonState) {
            if (state.buttonstate == true) {
              BlocProvider.of<WeatherBloc>(context).add(const FetchWeather());
            }
            ;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                top: 25,
                left: 10,
                child: TextButton(
                    onPressed: () {
                      print(
                          'This is the state of the button ${weather.button}');
                      weather.button == 'ON'
                          ? BlocProvider.of<WeatherBloc>(context)
                              .add(const ToggleButton(switchState: 'OFF'))
                          : BlocProvider.of<WeatherBloc>(context)
                              .add(const ToggleButton(switchState: 'ON'));
                    },
                    style: TextButton.styleFrom(
                        primary: appTheme.colorScheme.secondary, elevation: 1),
                    child: Text(weather.button!,
                        style: TextStyle(
                            color: AppStateContainer.of(context)
                                .theme
                                .colorScheme
                                .secondary
                                .withAlpha(80)))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    weather.name!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 5,
                      color: appTheme.colorScheme.secondary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    //this.weather.description!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 5,
                      fontWeight: FontWeight.w100,
                      color: appTheme.colorScheme.secondary,
                    ),
                  ),
                  WeatherSwipePager(weather: weather, weatherList: weatherList),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Divider(
                      color: appTheme.colorScheme.secondary.withAlpha(50),
                    ),
                  ),

                  ForecastHorizontal(weathers: weatherList!),
                  //weatherList.weatherList!
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(
                      color: appTheme.colorScheme.secondary.withAlpha(50),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ValueTile(
                            "Soil Moisture", '${weather.soilMoisture} unit'),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                              child: Container(
                            width: 1,
                            height: 30,
                            color: AppStateContainer.of(context)
                                .theme
                                .colorScheme
                                .secondary
                                .withAlpha(50),
                          )),
                        ),
                        ValueTile(
                            "Temperature", '${weather.temperature!.kelvin}°'),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                              child: Container(
                            width: 1,
                            height: 30,
                            color: AppStateContainer.of(context)
                                .theme
                                .colorScheme
                                .secondary
                                .withAlpha(50),
                          )),
                        ),
                        ValueTile("humidity", '${weather.humidity}%'),
                      ]),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
