

import 'package:wingu/data/model/body/language_model.dart';

import 'export_files.dart';

class AppConstants {
  static const String appName = 'Wingu';
  static const String baseUrl = 'https://api.openweathermap.org/';

  static const String weatherUrl = "${baseUrl}data/2.5/weather?q=";
  static const String forecastUrl = "${baseUrl}data/2.5/forecast?q=";
  static const String appId = '43ea6baaad7663dc17637e22ee6f78f2';

  //ADD GOOGLE MAP API KEY HERE
  static const String mapKey = '********* YOUR GOOGLE MAP API KEY****************';
  static const String placeApi = 'https://maps.googleapis.com/maps/api/place/textsearch/json?key=$mapKey&query=';

   static const String languageCode = 'language_code';
   static const String countryCode = 'country_code';
 
 static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        languageName: 'Swahili',
        countryCode: 'SW',
        languageCode: 'sw'),
  ];
}
