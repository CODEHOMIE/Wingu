import 'dart:convert';

import 'package:wingu/controller/location_controller.dart';
import 'package:wingu/controller/place_controller.dart';
import 'package:wingu/controller/weather_controller.dart';
import 'package:wingu/data/repository/place_repo.dart';
import 'package:wingu/data/repository/weather_repo.dart';

import '../util/export_files.dart';


Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: Get.find(),
  ));

  // Repository
   Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
   Get.lazyPut(() => WeatherRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.lazyPut(() => PlaceRepo(apiClient: Get.find(),));

  // Controller
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => OnboardingController());
  Get.lazyPut(() => LocationController());
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => WeatherController(weatherRepo: Get.find()));
  Get.lazyPut(() => PlaceController(placeRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;

}
