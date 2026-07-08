import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/place_sheet.dart';

import '../controllers/hospitals_controller.dart';
import '../widgets/place_card.dart';

class HospitalsView extends GetView<HospitalsController> {
  const HospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Hospitals & Blood Banks'),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _toggle(),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.places.isEmpty) {
                  return const EmptyState(
                    icon: Icons.local_hospital_outlined,
                    title: 'Nothing nearby',
                    subtitle: 'No verified or mapped locations found around you.',
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
                  itemCount: controller.places.length,
                  itemBuilder: (_, i) {
                    final place = controller.places[i];
                    return PlaceCard(
                      place: place,
                      onTap: () => PlaceSheet.show(
                        place,
                        onFavorite: () => controller.saveFavorite(place),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Obx(
        () => Row(
          children: [
            _chip('Hospitals', PlaceType.hospital),
            SizedBox(width: 3.w),
            _chip('Blood Banks', PlaceType.bloodBank),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, PlaceType type) {
    final selected = controller.type.value == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setType(type),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: selected ? AppColors.primary : AppColors.divider),
          ),
          child: MyText(
            title: label,
            size: 12.sp,
            weight: FontWeight.w700,
            clr: selected ? AppColors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
