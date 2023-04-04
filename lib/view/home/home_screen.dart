import 'package:wingu/controller/place_controller.dart';
import 'package:wingu/controller/weather_controller.dart';
import 'package:wingu/data/repository/place_repo.dart';
import 'package:wingu/data/repository/weather_repo.dart';
import 'package:wingu/util/export_files.dart';
import 'package:wingu/view/language/language_screen.dart';
import 'package:wingu/view/location/location_screen.dart';
import 'package:wingu/view/notification/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WeatherRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(WeatherController(weatherRepo: Get.find())).getWeatherInfo();

    Get.put(PlaceRepo(apiClient: Get.find()));
    var placesController = Get.put(PlaceController(placeRepo: Get.find()));
    return SafeArea(
      child: GetBuilder<WeatherController>(
        builder: (controller) {
          return controller.dataLoading.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: ColorResources.getPrimaryColor(),
                  child: Center(
                    child: Image.asset(
                      Images.logoWhite,
                      height: Get.height * .12,
                    ),
                  ),
                )
              : Scaffold(
                  key: _scaffoldKey,
                  appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(75.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          // Status bar color
                          statusBarColor: ColorResources.getPrimaryColor(),
                        ),
                        actions: <Widget>[
                          Container(),
                        ],
                        elevation: 0,
                        flexibleSpace: Container(
                          height: 75,
                          color: ColorResources.getPrimaryColor(),
                          padding: const EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Image(
                                image: AssetImage(Images.logoWhite),
                                height: 28,
                                width: 28,
                              ),
                              GestureDetector(
                                onTap: () => _displaySnackBar(context),
                                child: const Image(
                                  image: AssetImage(Images.menu),
                                  height: 23,
                                  width: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  endDrawer: Drawer(
                    elevation: 10,
                    width: Get.width,
                    backgroundColor: ColorResources.getPrimaryColor(),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 75,
                                    width: Get.width,
                                    color: ColorResources.getPrimaryColor(),
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Image(
                                          image: AssetImage(Images.logoWhite),
                                          height: 28,
                                          width: 28,
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.back(),
                                          child: const Image(
                                            image: AssetImage(
                                              Images.cancel,
                                            ),
                                            height: 18,
                                            width: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'settings'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Obx(
                                    () => drawerTile(
                                      Images.place,
                                      'location'.tr,
                                      placesController.formattedAddress.value,
                                      const LocationScreen(),
                                    ),
                                  ),
                                  drawerTile(
                                    Images.notification,
                                    'notification'.tr,
                                    'notiy_exp'.tr,
                                    const NotificationScreen(),
                                  ),
                                  // drawerTile(
                                  //     'Units', 'Customise Data', const LanguageScreen()),
                                  // drawerTile('Update Frequency', '1 Hour',
                                  //     const LanguageScreen()),
                                  drawerTile(
                                    Images.world,
                                    'language'.tr,
                                    'language_type'.tr,
                                    const LanguageScreen(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width,
                          height: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                Images.homeWave,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: Get.width,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  backgroundColor: ColorResources.getPrimaryColor(),
                  body: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Container(
                                    width: Get.width * .67,
                                    margin: const EdgeInsets.only(
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      placesController.formattedAddress.value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 0,
                                  ),
                                  child: Text(
                                    controller.weatherModel.weather[0].main.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.weatherModel.main.temp
                                            .toString()
                                            .split('.')[0],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '°',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => Image.asset(
                                controller
                                    .getWeatherIcon(controller
                                        .weatherModel.weather[0].main
                                        .toLowerCase())
                                    .value,
                                height: Get.height * .14,
                                width: Get.width * .7,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          right: 10,
                          left: 10,
                        ),
                        child: Row(
                          children: [
                            homeOption(
                              Images.humidity,
                              'humidity'.tr,
                              "${controller.weatherModel.main.humidity}%",
                            ),
                            homeOption(
                              Images.indicator,
                              'pressure'.tr,
                              "${controller.weatherModel.main.pressure} mBar",
                            ),
                            homeOption(
                              Images.wind,
                              'speed'.tr,
                              "${controller.weatherModel.wind.deg} km/h",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        height: 70,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              Images.homeWave,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const BottomPart()
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget homeOption(
    var iconss,
    String headingStr,
    String subStr,
  ) =>
      Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  iconss,
                ),
                height: 22,
                width: 22,
                color: Colors.white54,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                headingStr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                subStr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white54,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );

  _displaySnackBar(BuildContext context) {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Widget drawerTile(String iconss, String headingStr, subStr, openPage) =>
      GestureDetector(
        onTap: () {
          Get.to(openPage);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: Image(
                  image: AssetImage(
                    iconss,
                  ),
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headingStr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    subStr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white54,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              const Image(
                image: AssetImage(
                  Images.arrowRight,
                ),
                height: 13,
                width: 13,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      );
}
