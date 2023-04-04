import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wingu/controller/location_controller.dart';
import 'package:wingu/data/model/response/place_model.dart';
import 'package:wingu/data/model/response/weather_model.dart';
import 'package:wingu/data/repository/place_repo.dart';

import '../util/export_files.dart';

class PlaceController extends GetxController {
  var dataLoading = false.obs;
  PlaceModel _placeModel = PlaceModel(results: [], status: '');
  PlaceModel get placeModel => _placeModel;
  final PlaceRepo placeRepo;
  var searchController = TextEditingController();
  RxString cityName = 'Nairobi'.obs;
  RxString countryName = 'Kenya'.obs;
  RxString formattedAddress = 'Nairobi Kenya'.obs;

  late Position _position;

  Position get position => _position;

  PlaceController({required this.placeRepo});

  @override
  void onInit() {
    super.onInit();
    getLocality();
    getCountry();
  }


  Future getPlaces(String place) async {
    dataLoading(true);

    Response response = await placeRepo.searchPlace(place);
    if (response.statusCode == 200) {
      _placeModel = PlaceModel.fromJson(response.body);
      dataLoading(false);
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getLocality() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var locName =
        await getLocalityName(_position.latitude, _position.longitude);
        cityName.value = locName!;
    print('CURRENT LOCALITY :::::::::: $locName');
    formattedAddress.value = '${cityName.value} ${countryName.value}';
    update();
  }

  Future<String?> getLocalityName(double latitude, double longitude) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return '${placemarks[0].locality}';
  }

   Future<void> getCountry() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var locName =
        await getCountryName(_position.latitude, _position.longitude);
        countryName.value = locName!;
    print('CURRENT COUNTRY :::::::::: $locName');
    formattedAddress.value = '${cityName.value} ${countryName.value}';
    update();
  }

  Future<String?> getCountryName(double latitude, double longitude) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return '${placemarks[0].country}';
  }

}
