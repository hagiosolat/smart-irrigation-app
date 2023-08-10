import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irrigation1/firebase_options.dart';
import 'package:irrigation1/src/api/message_api.dart';
import 'package:irrigation1/src/api/realdb_api.dart';
import 'package:irrigation1/src/bloc/weather_bloc_observre.dart';
import 'package:irrigation1/src/screens/routes.dart';
import 'package:irrigation1/src/screens/weather_screen.dart';
//import 'package:bloc/bloc.dart';
import 'package:irrigation1/src/themes.dart';
import 'package:irrigation1/src/utils/constants.dart';
import 'package:irrigation1/src/utils/converters.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'src/api/weather_api_client.dart';
import 'src/bloc/weather_bloc.dart';
import 'src/repository/weather_repository.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final DatabaseApi databaseApi = DatabaseApi();
  await FirebaseApi().initNotifications();
  final WeatherRepository weatherRepository = WeatherRepository(
    databaseApi: databaseApi,
  );

  runApp(AppStateContainer(
    child: WeatherApp(weatherRepository: weatherRepository),
  ));
}

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherApp({Key? key, required this.weatherRepository})
      : //assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather App',
      theme: AppStateContainer.of(context).theme,
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
      routes: Routes.mainRoute,
    );
  }
}

/// top level widget to hold application state
/// state is passed down with an inherited widget
/// inherited widget state is mainly used to hold app theme and temerature unit
class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    var widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>();
    return widget!.data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.getTheme(Themes.DARK_THEME_CODE);
  int themeCode = Themes.DARK_THEME_CODE;
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode = sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_THEME) ??
            Themes.DARK_THEME_CODE;
        temperatureUnit = TemperatureUnit.values[
            sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT) ??
                TemperatureUnit.celsius.index];
        _theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(theme.colorScheme.secondary);
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_THEME, themeCode);
    });
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}
