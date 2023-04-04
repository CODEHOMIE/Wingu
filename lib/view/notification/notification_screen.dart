import 'package:wingu/controller/language_controller.dart';
import 'package:wingu/controller/localization_controller.dart';
import 'package:wingu/controller/notification_controller.dart';
import 'package:wingu/util/export_files.dart';
import 'package:flutter/cupertino.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var controller = Get.put(NotificationController(sharedPreferences: Get.find()));
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
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
            child: GetBuilder<NotificationController>(
                builder: (controller) {
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'notification'.tr,
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
                      child: ListTile(
                            title: Text(
                              'Show weather info in statusbar',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: CupertinoSwitch(
                              activeColor: Colors.white,
                              trackColor: ColorResources.getYellowColor().withOpacity(.3),
                              value: switchValue,
                              thumbColor: ColorResources.getPrimaryColor(),
                              
                              onChanged: (bool value) {
                                switchValue = value;
                                setState(() {
                                  
                                });
                              },
                            ),
                            onTap: () {
                             // controller.switchValue.value = !controller.switchValue.value;
                            },
                          ),
                    ),
                  ],
                );
              
            }),
          ),
        ),
      ),
    );
  }
}

