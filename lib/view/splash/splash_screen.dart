import 'dart:async';

import 'package:wingu/controller/location_controller.dart';
import 'package:wingu/controller/place_controller.dart';
import 'package:wingu/controller/weather_controller.dart';
import 'package:wingu/util/export_files.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    print('splash screen call');
    _route();
    // _onConnectivityChanged = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
    //   if(await ApiChecker.isVpnActive()) {
    //   //  showCustomSnackBar('you are using vpn', isVpn: true, duration: Duration(minutes: 10));
    //   }
    //   if(!_firstTime) {
    //     // print('connection state : $result');
    //     // bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;

    //     // showCustomSnackBar(
    //     //   isNotConnected ? 'no_connection'.tr : 'connected'.tr,
    //     //   duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //     //   isError: isNotConnected,
    //     // );

    //     // if(!isNotConnected) {
    //     //   _route();
    //     // }
    //   }else{
    //     print('splash screen call 2');

    //     _route();
    //   }

    // });

  }


  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route()async {
    await Get.put(PlaceController(placeRepo: Get.find())).getLocality();
    var showOnBoard = await Get.put(OnboardingController()).getOnboardingConfig();
    if(showOnBoard == null) {
      await Get.offNamed(RouteHelper.getOnBoardingRoute());
      return;
    }
    if(showOnBoard) {
      await Get.offNamed(RouteHelper.getOnBoardingRoute());
      return;
    }
    await Get.offNamed(RouteHelper.getHomeRoute());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getPrimaryColor(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.logoWhite, height: Get.height * .12),
          ],
        ),
      ),
    );
  }
}
