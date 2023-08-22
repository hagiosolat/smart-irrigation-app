import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../model/weather.dart';

class DatabaseApi {
  final database = FirebaseDatabase.instance.ref();
  dynamic result;
  StreamController<WeatherMap> weatherMapStreamController =
      StreamController<WeatherMap>.broadcast();
  StreamController<List<WeatherMap>> weatherListController =
      StreamController.broadcast();

  //to get the temperature value...
  Stream<List<WeatherMap>> retrieveWeatherData() {
    
    database.child('weather').onValue.listen((event) {
      List<WeatherMap> weatherlist = [];
      final datasnapshot =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      datasnapshot.forEach(
        (key, value) {
          if (!weatherlist.contains(WeatherMap.fromJson(value))) {
            weatherlist.add(WeatherMap.fromJson(value));
             print(
        'data coming from the stream is ${weatherlist.length}');
          }
        },
      );
      weatherListController.sink.add(weatherlist);
    });
   
    return weatherListController.stream;
  }

  Stream<WeatherMap> retrieveWeather() {
    database.child('currentcondition').onValue.listen((event) {
      final datasnapshot =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      print(
          '............!!!!!!!!!!!!!!!!!!!!!!!$datasnapshot!!!!!!!!!!!!!!!!!..............');
      result = WeatherMap.fromJson(datasnapshot);
      weatherMapStreamController.add(result);
    });
    return weatherMapStreamController.stream;
  }

  Future<bool> pressButton(dynamic buttonstate) async {
    database
        .child('currentcondition')
        .update({'buttonstate': buttonstate}).then((value) {
      print('successfully write into the realtime Database');
    });
    return true;
  }

  void error(StackTrace stackTrace) {
    print('THERE IS AN ERROR IN THE BUTTON BEING PRESSE $stackTrace');
  }

  void dispose() {
    weatherListController.close();
  }
}
