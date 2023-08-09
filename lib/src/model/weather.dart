import 'package:flutter/material.dart';
import 'package:irrigation1/src/utils/WeatherIconMapper.dart';
import 'package:irrigation1/src/utils/converters.dart';

class Weather {
  int? id;
  int? time;
  int? sunrise;
  int? sunset;
  int? humidity;

  String? description;
  String? iconCode;
  String? main;
  String? cityName;

  double? windSpeed;

  Temperature? temperature;
  Temperature? maxTemperature;
  Temperature? minTemperature;

  List<Weather>? forecast;

  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      description: weather['description'],
      main: weather['main'],
      iconCode: weather['icon'],
      time: json['dt'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <Weather>[];
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['main']['temp'],
          )),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}

class WeatherMap {
  int? id;
  int? time;
  int? humidity;
  String? name;
  int? soilMoisture;
  String? button;
  Temperature? temperature;
  List<WeatherMap>? forcast;

  WeatherMap(
      {this.id,
      this.time,
      this.name,
      this.humidity,
      this.soilMoisture,
      this.temperature,
      this.button,
      this.forcast});

  factory WeatherMap.fromJson(dynamic json) {
    return WeatherMap(
      id: json['id'] ?? 0,
      time: json['timestamp'] ?? 0,
      name: json['name'] ?? '',
      button: json['buttonstate'] ?? '',
      humidity: json['humidity'],
      soilMoisture: json['soilMoisture'],
      temperature: Temperature.fromjson(json['temperature']),
    );
  }

  static List<WeatherMap> fromJsonList(Map<String, dynamic> data) {
    final weathers = <WeatherMap>[];
    data.forEach((key, value) {
      weathers.add(WeatherMap.fromJson(value));
    });
    return weathers;
  }
  // @override
  // String toString() {
  //   return ('{id: $id, time: $time, name: $name, humidity: $humidity, soilmoisture: $soilMoisture, temperature: $temperature}');
  // }
}
