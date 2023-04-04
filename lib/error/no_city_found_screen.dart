
import 'package:wingu/util/export_files.dart';
import 'package:wingu/view/location/location_screen.dart';

class NoCityFoundScreen extends StatelessWidget {
  const NoCityFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getPrimaryColor(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                Image.asset(
                  Images.weatherLocation,
                  width: Get.width * .6,
                  height: Get.height * .2,
                ),
                const SizedBox(
                  height: 70,
                ),
                // Text(
                //   'NO INTERNET CONNECTION',
                //   style: GoogleFonts.montserrat(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //     fontSize: 20,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 5,
                  ),
                  child: Text(
                    'City not found. Please search for a different location or try again later',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height * .92),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cached_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => Get.toEnd(() => LocationScreen()),
                    child: Text(
                      'Try again.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
