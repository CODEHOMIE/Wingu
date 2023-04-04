
import '../util/export_files.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
 

  static String getSplashRoute() => splash;
  static String getOnBoardingRoute() => onboarding;
  static String getHomeRoute() => home;


  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}