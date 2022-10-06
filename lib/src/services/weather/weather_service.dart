import '../../api/api.dart';
import '../../utils/languages.dart';
import '../http_owm_repository.dart';
import 'all_weather_model.dart';

/// Plugin for fetching weather data in JSON.
class WeatherService {
  WeatherService(String api, {WeatherLanguage? language})
      : _owmApi = OWMApi(api, language: language ?? WeatherLanguage.english);

  final OWMApi _owmApi;

  final HttpOWMRepository _httpRepo = HttpOWMRepository();

  /// Fetch [WeatherOneCall] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherOnecall](https://openweathermap.org/api/one-call-api)
  Future<WeatherOneCall> oneCallWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      _httpRepo.getData(
          uri: _owmApi.uriOnecallWeather(latitude, longitude),
          builder: (dynamic data) {
            return WeatherOneCall.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });

  /// Fetch [WeatherCurrent] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherCurrent](https://openweathermap.org/current)
  Future<WeatherCurrent> currentWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      _httpRepo.getData(
          uri: _owmApi.uriCurrentWeather(latitude, longitude),
          builder: (dynamic data) {
            return WeatherCurrent.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });
}