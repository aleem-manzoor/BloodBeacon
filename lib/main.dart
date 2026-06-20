import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';
import 'package:sizer/sizer.dart';
import 'package:ppsc_preparation/app/config/app_colors.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase config is not set up yet. Once you run `flutterfire configure`,
  // import the generated firebase_options.dart and pass
  // `options: DefaultFirebaseOptions.currentPlatform` here.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    log('Firebase not initialized (config missing): $e');
  }
  Get.put(LocalDB());
  runApp(Sizer(builder: (context, orientation, screenType) {
    return GetMaterialApp(
      title: "Beaverise",
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
            textScaler: const TextScaler.linear(1.1),
          ),
          child: child ?? Container(),
        );
      },
    );
  }));
}
