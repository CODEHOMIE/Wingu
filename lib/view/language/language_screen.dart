import 'package:wingu/controller/language_controller.dart';
import 'package:wingu/controller/localization_controller.dart';
import 'package:wingu/util/export_files.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LanguageController());
    var controllerLoc = Get.find<LocalizationController>();
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
            child: GetBuilder<LocalizationController>(
                builder: (localizationController) {
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
                      'language'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        children: [
                          Radio(
                            value: '0',
                            groupValue: controllerLoc.selectedIndex.toString(),
                            onChanged: (value) {
                              //controller.selectedLanguage.value = value!;
                              controllerLoc.setLanguage(Locale(
                                AppConstants.languages[0].languageCode!,
                                AppConstants.languages[0].countryCode,
                              ));
                              controllerLoc.setSelectIndex(0);
                            },
                            activeColor: Colors.white,
                            hoverColor: Colors.white54,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'English',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: '1',
                            groupValue: controllerLoc.selectedIndex.toString(),
                            onChanged: (value) {
                              controller.selectedLanguage.value = value!;
                              controllerLoc.setLanguage(Locale(
                                AppConstants.languages[1].languageCode!,
                                AppConstants.languages[1].countryCode,
                              ));
                              controllerLoc.setSelectIndex(1);
                            },
                            activeColor: Colors.white,
                            hoverColor: Colors.white54,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Kiswahili',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
