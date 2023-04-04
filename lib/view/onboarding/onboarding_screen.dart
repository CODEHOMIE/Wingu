import 'package:wingu/controller/weather_controller.dart';
import 'package:wingu/data/repository/weather_repo.dart';

import '../../util/export_files.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OnboardingController>();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    final slideList = [
      Slide(
        imageUrl: Images.cloudy,
        headingStr: 'on_boarding_title_1'.tr,
      ),
      Slide(
        imageUrl: Images.thunderstorm,
        headingStr: "on_boarding_title_2".tr,
      ),
      Slide(
        imageUrl: Images.weatherLocation,
        headingStr: 'on_boarding_title_3'.tr,
      )
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: ColorResources.getPrimaryColor(),
            elevation: 0,
          ),
        ),
        backgroundColor: ColorResources.getPrimaryColor(),
        body: Column(
          children: [
            Image.asset(
              Images.logoWhite,
              height: 50,
              width: 50,
            ),
            Expanded(
              child: Container(
                //height: Get.height,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: const BoxDecoration(),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: slideList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: Get.width * .7,
                          height: Get.height * .22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  slideList[index].imageUrl,
                                ),
                                fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Text(
                            slideList[index].headingStr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => Stack(
                children: [
                  (2 == controller.currentSlider.value)
                      ? Container()
                      : Container(
                          alignment: AlignmentDirectional.bottomCenter,
                          margin: const EdgeInsets.only(bottom: 70.0, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == controller.currentSlider.value)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        ),
                  (2 == controller.currentSlider.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await Get.put(OnboardingController())
                                    .configOnboarding();
                                // ignore: use_build_context_synchronously
                                await Get.offNamed(RouteHelper.getHomeRoute());
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(bottom: 40),
                                child: Card(
                                  color: ColorResources.getPrimaryColor(),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80),
                                    //set border radius more than 50% of height and width to make circle
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(22.0),
                                      child: Image.asset(
                                        Images.arrowRight,
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
