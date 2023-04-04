

import '../../util/export_files.dart';

class PlaceRepo {
  ApiClient apiClient;
  PlaceRepo({required this.apiClient});

  Future<Response> searchPlace(String place) async {
    return await apiClient.getData('${AppConstants.placeApi}$place', query: {}, );
  }
}