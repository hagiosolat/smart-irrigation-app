// import 'package:irrigation1/src/api/weather_api_client.dart';
// import 'package:irrigation1/src/model/weather.dart';
// import 'package:meta/meta.dart';

// class WeatherRepository {
//   final WeatherApiClient weatherApiClient;
//   WeatherRepository({required this.weatherApiClient})
//       : assert(weatherApiClient != null);

//   Future<Weather> getWeather(String cityName,
//       {double? latitude, double? longitude}) async {
//     if (cityName == null) {
//       cityName = await weatherApiClient.getCityNameFromLocation(
//           latitude: latitude, longitude: longitude);
//     }
//     var weather = await weatherApiClient.getWeatherData(cityName);
//     var weathers = await weatherApiClient.getForecast(cityName);
//     weather.forecast = weathers;
//     return weather;
//   }
// }

import 'package:irrigation1/src/api/realdb_api.dart';

import '../model/weather.dart';

class WeatherRepository {
  final DatabaseApi databaseApi;
  WeatherRepository({required this.databaseApi});

  Stream<WeatherMap> getWeather() {
    var weather = databaseApi.retrieveWeather();
    print(
        '...............CHECKING IF THE WEATHER IS BEING RETURNED HERE...........');
    print(weather);
    return weather;
  }

  Stream<List<WeatherMap>> getWeatherList() {
    var weathers;
    weathers = databaseApi.retrieveWeatherData();
    print('FROM DB ${weathers.toString()}');
    return weathers;
  }

  Future<bool> pressButton(String buttonState) async {
    print('Checking from the repository functions');
    var isClicked = databaseApi.pressButton(buttonState);
    return isClicked;
  }

  // Future<String> getButtonState() async {
  //   var buttonState = databaseApi.getButtonState();
  //   return buttonState;
  // }
}
