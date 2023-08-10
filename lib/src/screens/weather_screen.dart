import 'package:flutter/material.dart';
import 'package:irrigation1/main.dart';
import 'package:irrigation1/src/bloc/weather_event.dart';
import 'package:irrigation1/src/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irrigation1/src/model/weather.dart';
import 'package:irrigation1/src/utils/constants.dart';
import 'package:irrigation1/src/widgets/weather_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/weather_bloc.dart';

enum OptionsMenu { changeCity, settings }

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc? _weatherBloc;
  String? _cityName = 'bengaluru';
  Animation<double>? _fadeAnimation;
  AnimationController? _fadeController;
  List<WeatherMap>? weatherList;

  @override
  void initState() {
    super.initState();

    _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController!,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.primaryColor,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: Text(
                  'FINAL YEAR PROJECT',
                  style: TextStyle(color: AppColors.contentColorBlack),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color: appTheme.colorScheme.secondary.withAlpha(80),
                  //accentColor.withAlpha(80),
                  fontSize: 14,
                ),
              )
            ],
          ),
          // actions: <Widget>[
          //   PopupMenuButton<OptionsMenu>(
          //     onSelected: _onOptionMenuItemSelected,
          //     itemBuilder: (context) => <PopupMenuEntry<OptionsMenu>>[
          //       const PopupMenuItem<OptionsMenu>(
          //         value: OptionsMenu.changeCity,
          //         child: Text("change city"),
          //       ),
          //       const PopupMenuItem<OptionsMenu>(
          //         value: OptionsMenu.settings,
          //         child: Text("settings"),
          //       ),
          //     ],
          //     child: Icon(
          //       Icons.more_vert,
          //       color: appTheme.colorScheme.secondary,
          //       //accentColor,
          //     ),
          //   )
          // ],
        ),
        backgroundColor: Colors.white,
        body: Material(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: appTheme.primaryColor),
            child: FadeTransition(
              opacity: _fadeAnimation!,
              child: BlocConsumer<WeatherBloc, WeatherState>(
                  listener: (context, state) {
                if (state is WeatherEmpty) {
                  _weatherBloc!.add(const FetchListData());
                }

                if (state is WeatherPopulated) {
                  weatherList = state.weatherList;
                  _weatherBloc!.add(const FetchWeather());
                }
              }, builder: (_, WeatherState weatherState) {
                _fadeController!.reset();
                _fadeController!.forward();

                if (weatherState is WeatherLoaded) {
                  _cityName = weatherState.weather.name;
                  return WeatherWidget(
                    weather: weatherState.weather,
                    weatherList: weatherList,
                  );
                } else if (weatherState is WeatherEmpty) {
                  _weatherBloc!.add(const FetchListData());
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: appTheme.primaryColor,
                    ),
                  );
                } else if (weatherState is WeatherError) {
                  String errorText = 'There was an error fetching weather data';
                  if (weatherState is WeatherError) {
                    if (weatherState.errorCode == 404) {
                      errorText =
                          'We have trouble fetching weather for $_cityName';
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appTheme.colorScheme.secondary,
                          //primary: appTheme.accentColor,
                          elevation: 1,
                        ),
                        onPressed: _fetchWeatherWithCity,
                        child: const Text("Try Again"),
                      )
                    ],
                  );
                } else if (weatherState is WeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: appTheme.primaryColor,
                    ),
                  );
                }
                return Container(
                  child: const Text('No city set'),
                );
              }),
            ),
          ),
        ));
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          ThemeData appTheme = AppStateContainer.of(context).theme;

          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Change city',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: appTheme.colorScheme.secondary,
                  //primary: appTheme.accentColor,
                  elevation: 1,
                ),
                onPressed: () {
                  _fetchWeatherWithCity();
                  Navigator.of(context).pop();
                },
                child: const Text('ok'),
              ),
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                _cityName = text;
              },
              decoration: InputDecoration(
                  hintText: 'Name of your city',
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _fetchWeatherWithLocation().catchError((error) {
                        _fetchWeatherWithCity();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 16,
                    ),
                  )),
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }

  _onOptionMenuItemSelected(OptionsMenu item) {
    switch (item) {
      case OptionsMenu.changeCity:
        _showCityChangeDialog();
        break;
      case OptionsMenu.settings:
        Navigator.of(context).pushNamed("/settings");
        break;
    }
  }

  _fetchWeatherWithCity() {
    //_weatherBloc!.add(FetchWeather());
    _weatherBloc!.add(const FetchListData());
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        print('location permission denied');
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        print('getting location');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: const Duration(seconds: 2));

        print(position.toString());

        _weatherBloc!.add(const FetchWeather());
        break;
      default:
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          ThemeData appTheme = AppStateContainer.of(context).theme;

          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: appTheme.colorScheme.secondary,
                  //primary: appTheme.accentColor,
                  elevation: 1,
                ),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('Enable!'),
              ),
            ],
          );
        });
  }
}
