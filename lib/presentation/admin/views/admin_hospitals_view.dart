import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/shared_widgets/app_field.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_button.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/place_model.dart';

import '../controllers/admin_hospitals_controller.dart';

class AdminHospitalsView extends GetView<AdminHospitalsController> {
  const AdminHospitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppTopBar(
        title: 'Hospitals & Blood Banks',
        actions: [
          Obx(
            () => controller.seeding.value
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    tooltip: 'Seed sample blood banks',
                    onPressed: controller.seedSampleBloodBanks,
                    icon: const Icon(Icons.auto_awesome_rounded,
                        color: AppColors.primary),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          controller.prefill(null);
          _form(context);
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
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
            ),
            Expanded(
              child: Obx(() {
                controller.type.value;
                return StreamBuilder<List<PlaceModel>>(
                  stream: controller.places,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final items = snapshot.data ?? [];
                    if (items.isEmpty) {
                      return const EmptyState(
                        icon: Icons.local_hospital_outlined,
                        title: 'No entries yet',
                        subtitle: 'Tap + to add a verified location.',
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 10.h),
                      itemCount: items.length,
                      itemBuilder: (_, i) => _tile(context, items[i]),
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

  Widget _tile(BuildContext context, PlaceModel place) {
    return MyContainer(
      margin: EdgeInsets.only(bottom: 1.4.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: place.name ?? '-',
                  size: 12.5.sp,
                  weight: FontWeight.w700,
                  clr: AppColors.textDark,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
                MyText(
                  title: place.address ?? place.city ?? '',
                  size: 10.sp,
                  clr: AppColors.textMuted,
                  line: 1,
                  overFLow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.toggleVerified(place),
            icon: Icon(
              place.verified
                  ? Icons.verified_rounded
                  : Icons.verified_outlined,
              color: place.verified ? AppColors.success : AppColors.textMuted,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.prefill(place);
              _form(context, id: place.id);
            },
            icon: const Icon(Icons.edit_rounded,
                color: AppColors.info, size: 20),
          ),
          IconButton(
            onPressed: () =>
                place.id == null ? null : controller.delete(place.id!),
            icon: const Icon(Icons.delete_outline_rounded,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  void _form(BuildContext context, {String? id}) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: id == null ? 'Add Location' : 'Edit Location',
                size: 15.sp,
                weight: FontWeight.w800,
                clr: AppColors.textDark,
              ),
              SizedBox(height: 2.h),
              AppField(label: 'Name', controller: controller.nameController),
              AppField(
                  label: 'Address', controller: controller.addressController),
              AppField(label: 'City', controller: controller.cityController),
              AppField(
                  label: 'Phone',
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                        label: 'Latitude',
                        controller: controller.latController,
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: AppField(
                        label: 'Longitude',
                        controller: controller.lngController,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              Obx(
                () => MyButton(
                  text: 'Save',
                  isLoading: controller.saving.value,
                  onPressed: () => controller.save(id: id),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
