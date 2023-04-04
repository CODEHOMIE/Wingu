import 'package:wingu/controller/notification_controller.dart';
import 'package:wingu/controller/place_controller.dart';
import 'package:wingu/data/model/response/weather_model.dart';
import 'package:wingu/data/repository/weather_repo.dart';
import 'package:wingu/error/no_city_found_screen.dart';

import '../util/export_files.dart';

class WeatherController extends GetxController {
  WeatherModel _weatherModel = WeatherModel(coord: Coord(lon: 0.0, lat: 0.0), weather: [], base: '', main: Main(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0, humidity: 0), visibility: 0, wind: Wind(speed: 0.0, deg: 0), clouds: Clouds(all: 0), dt: 0,  timezone: 0, id: 0, name: '', cod: 0);
  var dataLoading = false.obs;
  WeatherModel get weatherModel => _weatherModel;
  final WeatherRepo weatherRepo;

  WeatherController({required this.weatherRepo});

  Future getWeatherInfo() async {
    dataLoading(true);
    var place = Get.put(PlaceController(placeRepo: Get.find())).cityName.value;
    Response response = await weatherRepo.getWeather(place);
    if(response.statusCode == 404) {
      Get.to(const NoCityFoundScreen());
      return;
    }
    if (response.statusCode == 200) {
      _weatherModel = WeatherModel.fromJson(response.body);
      Get.put(NotificationController(sharedPreferences: Get.find())).showNotification(place, _weatherModel.weather[0].main,_weatherModel.weather[0].description);
      dataLoading(false);
    } else {
      dataLoading(false);
      ApiChecker.checkApi(response);
    }

    update();
  }

  RxString getWeatherIcon(String type) {
    if(type == 'rain') {
      return Images.rainyDay.obs;
    }
    if(type == 'clouds') {
      return Images.cloudy.obs;
    }
    if(type == 'wind') {
      return Images.windy.obs;
    }
    if(type == 'sun') {
      return Images.sun.obs;
    }
    if(type == 'thunderstorm') {
      return Images.thunderstorm.obs;
    }
    if(type == 'clear') {
      return Images.partlyCloudy.obs;
    }
    return Images.clouds.obs;
  }
}
