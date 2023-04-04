

import '../../util/export_files.dart';

class WeatherRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  WeatherRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getWeather(String place) async {
    return await apiClient.getData('${AppConstants.weatherUrl}$place&units=metric&APPID=${AppConstants.appId}', query: {}, );
  }
}