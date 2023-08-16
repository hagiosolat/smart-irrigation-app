import 'package:bloc/bloc.dart';
import 'package:irrigation1/src/bloc/weather_event.dart';
import 'package:irrigation1/src/bloc/weather_state.dart';
import 'package:irrigation1/src/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherEmpty()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchListData>(_onFetchListData);
    on<ToggleButton>(_onpressButton);
    // on<GetButtonState>(_ongetButtonState);
  }
  Future<void> _onFetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    await emit.forEach(weatherRepository.getWeather(), onData: (weather) {
      return WeatherLoaded(weather: weather);
    });
    addError(Exception('fetching error'), StackTrace.current);
  }

  Future<void> _onFetchListData(
      FetchListData event, Emitter<WeatherState> emit) async {
    await emit.forEach(weatherRepository.getWeatherList(),
        onData: (weatherList) {
      print("The weather List LENGTH is ${weatherList.length}");
      return WeatherPopulated(weatherList: weatherList);
    });
    addError(('Fetching List of Data'), StackTrace.current);
  }

  Future<void> _onpressButton(
      ToggleButton event, Emitter<WeatherState> emit) async {
    print('Checking the buttonState');
    final isSet = await weatherRepository.pressButton(event.switchState);
    print('.........!!!!!!!!!!!!!!!$isSet............!!!!!!!!!!!');
    return emit(ButtonState(buttonstate: isSet));
  }
}
