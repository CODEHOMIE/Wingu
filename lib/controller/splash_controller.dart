

import '../util/export_files.dart';

class SplashController extends GetxController implements GetxService{
   final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  bool _isVpn = false;

  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get isVpn => _isVpn;

  Future<Response> getConfigData() async {
    Response _response = await splashRepo.getConfigData();
    if(_response.statusCode == 200){
     // _configModel =  ConfigModel.fromJson(_response.body);
    }
   else {
     print(_response);
     ApiChecker.checkApi(_response);
   }
    update();
    return _response;

  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

 Future<bool> checkVpn() async {
    _isVpn = await ApiChecker.isVpnActive();
    // if(_isVpn) {
    //   showCustomSnackBar('you are using vpn', isVpn: true, duration: Duration(minutes: 10));
    // }
    return _isVpn;
  }
}
