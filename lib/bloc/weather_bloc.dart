import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:weather_app/model/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {  //async* berperan membuat method ini menjadi sebuah async-generator  yg akan meng-output Stream
    if(event is GetWeather){
      //outputting sebuah state dari asynchronous generator
      yield WeatherLoading();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName){
    //eceknya network delay
    return Future.delayed(Duration(seconds: 1), (){
      return Weather(
        cityName: cityName,
        temperature: 20 + Random().nextInt(15) + Random().nextDouble(),   //hasil temperatur antara 20 sampai 35.99
      );
    });
  }
}
