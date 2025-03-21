import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppsc_preparation/app/shared_widgets/appbar_custom.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarCustom(
              title: 'Main',
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await controller.logout();
                  },
                ),
              ],
            ),
            body: const Center(
              child: Text(
                'MainView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        });
  }
}
