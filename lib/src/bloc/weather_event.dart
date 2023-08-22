import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  // final String? cityName;
  //final double? longitude;
  //final double? latitude;

  const FetchWeather();

  @override
  List<Object> get props => [];
}

class FetchListData extends WeatherEvent {
  const FetchListData();

  @override
  List<Object?> get props => [];
}

class ToggleButton extends WeatherEvent {
  const ToggleButton({this.switchState});
  final dynamic switchState;

  @override
  List<Object> get props => [switchState];
}


