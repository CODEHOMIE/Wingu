import '../util/export_files.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  RxInt currentSlider = 0.obs;

  //FUNCTIONS
  onPageChanged(int index) {
    currentSlider.value = index;
  }

  Future configOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showOnboarding', false);
    update();
  }
  Future<bool?> getOnboardingConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var showOnboard = prefs.getBool('showOnboarding');

    return showOnboard;
  }
}
