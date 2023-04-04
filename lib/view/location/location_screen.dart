import 'package:wingu/controller/language_controller.dart';
import 'package:wingu/controller/localization_controller.dart';
import 'package:wingu/controller/location_controller.dart';
import 'package:wingu/controller/notification_controller.dart';
import 'package:wingu/controller/place_controller.dart';
import 'package:wingu/controller/weather_controller.dart';
import 'package:wingu/data/repository/place_repo.dart';
import 'package:wingu/util/export_files.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LanguageController());
    var controllerLoc = Get.find<LocalizationController>();
    var weatherController = Get.find<WeatherController>();
    Get.put(PlaceRepo(apiClient: Get.find()));
    Get.put(PlaceController(placeRepo: Get.find())).getPlaces('Nairobi');
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.getPrimaryColor(),
        appBar: AppBar(
          backgroundColor: ColorResources.getPrimaryColor(),
          elevation: 0,
          leading: Container(
            padding: const EdgeInsets.only(left: 16, top: 25),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Image(
                image: AssetImage(
                  Images.back,
                ),
                height: 25,
                width: 25,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: GetBuilder<PlaceController>(builder: (controller) {
              return RadioTheme(
                  data: RadioThemeData(
                    fillColor: MaterialStateProperty.all<Color>(
                      Colors.white54,
                    ), // set inactive color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'location'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: TextField(
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            hintText: 'Enter location',
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17.5,
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  left: 12.0, top: 12, bottom: 12),
                              child: Image(
                                image: AssetImage(
                                  Images.navigation,
                                ),
                                height: 15,
                                width: 15,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            final query = controller.searchController.text;
                            Get.find<PlaceController>().getPlaces(query);
                          },
                        ),
                      ),

                      // Obx(() {
                      //   final locations =
                      //       Get.find<LocationController>().locations;
                      //   if (locations.isEmpty) {
                      //     return Text('No results found');
                      //   } else {
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: controller.placeModel.results.length,
                          itemBuilder: (context, index) {
                            final placemark =
                                controller.placeModel.results[index];
                            return ListTile(
                              title: Text(
                                placemark.formattedAddress,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              //subtitle: Text(placemark.name),
                              onTap: () {
                                controller.cityName.value = placemark.name;
                                controller.formattedAddress.value = placemark.formattedAddress;
                                Get.put(PlaceController(placeRepo: Get.find())).getPlaces(controller.cityName.value);
                                Get.put(WeatherController(weatherRepo: Get.find())).getWeatherInfo();
                                weatherController.getWeatherIcon(weatherController.weatherModel.weather[0].main.toLowerCase());
                                
                                Get.back();
                              },
                            );
                          },
                        ),
                      )
                      //}
                      //}),
                    ],
                  ));
            }),
          ),
        ),
      ),
    );
  }
}
