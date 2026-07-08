import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:blood_beacon/data/provider/local_storage/local_db.dart';
import 'package:sizer/sizer.dart';
import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/services/osm_service.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/data/provider/firebase/push_notification_service.dart';
import 'package:blood_beacon/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LocalDB());
  Get.put(SessionService(), permanent: true);
  Get.put(LocationService(), permanent: true);
  Get.put(OsmService(), permanent: true);
  final pushService = Get.put(PushNotificationService(), permanent: true);
  await pushService.init();
  runApp(Sizer(builder: (context, orientation, screenType) {
    return GetMaterialApp(
      title: "BloodBeacon",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.primary,
      ),
      // theme: ThemeData.dark(),
      // darkTheme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: const Color(0xFF020202),
      // ),
      // themeMode: ThemeMode.dark,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: const TextScaler.linear(1.4),
          ),
          child: child ?? Container(),
        );
      },
    );
  }));
}
