import 'package:irrigation1/src/model/weather.dart';
//import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherMap weather;

  const WeatherLoaded({required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherPopulated extends WeatherState {
  final List<WeatherMap> weatherList;

  const WeatherPopulated({required this.weatherList})
      : assert(weatherList != null);

  @override
  List<Object> get props => [weatherList];
}

class WeatherError extends WeatherState {
  final int errorCode;

  const WeatherError({required this.errorCode}) : assert(errorCode != null);

  @override
  List<Object> get props => [errorCode];
}

class ButtonState extends WeatherState {
  final bool buttonstate;

  const ButtonState({required this.buttonstate});
  @override
  List<Object> get props => [buttonstate];
}

