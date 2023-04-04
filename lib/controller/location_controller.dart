import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  late Position _position;

  Position get position => _position;

  List<Location> _locations = [];

  List<Location> get locations => _locations;

  Future<void> searchLocation(String query) async {
    _locations = await locationFromAddress(query);
  }

  Future<void> getLocality() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var locName =
        await getLocalityName(_position.latitude, _position.longitude);
    print('CURRENT LOCALITY :::::::::: $locName');
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
    print('CURRENT COUNTRY :::::::::: $locName');
  }

  Future<String?> getCountryName(double latitude, double longitude) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return '${placemarks[0].country}';
  }
}
