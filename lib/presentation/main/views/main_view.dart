import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/presentation/dashboard/views/dashboard_view.dart';
import 'package:blood_beacon/presentation/map/views/map_view.dart';
import 'package:blood_beacon/presentation/profile/views/profile_view.dart';
import 'package:blood_beacon/presentation/requests/views/my_requests_view.dart';
import 'package:blood_beacon/presentation/search/views/search_view.dart';

import '../controllers/main_controller.dart';
import '../widgets/bottom_nav_bar.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      DashboardView(),
      MyRequestsView(),
      SearchView(),
      MapView(),
      ProfileView(),
    ];
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: tabs,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}
