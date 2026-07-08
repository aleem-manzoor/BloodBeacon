import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/place_sheet.dart';

import '../controllers/map_tab_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MapTabController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Obx(() {
        final center = c.center.value;
        if (center == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(initialCenter: center, initialZoom: 13),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.bloodbeacon.app',
                ),
                MarkerLayer(markers: _markers(c, center)),
              ],
            ),
            SafeArea(child: _typeToggle(c)),
            if (c.loading.value)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: _searchingChip(c),
                ),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'mapFab',
        backgroundColor: AppColors.primary,
        onPressed: c.load,
        child: const Icon(Icons.my_location_rounded, color: AppColors.white),
      ),
    );
  }

  List<Marker> _markers(MapTabController c, LatLng center) {
    final markers = <Marker>[
      Marker(
        point: center,
        width: 44,
        height: 44,
        child: const Icon(Icons.my_location_rounded,
            color: AppColors.info, size: 30),
      ),
    ];
    for (final p in c.places) {
      if (p.latitude == null || p.longitude == null) continue;
      final pinColor = p.verified ? AppColors.success : AppColors.primary;
      markers.add(
        Marker(
          point: LatLng(p.latitude!, p.longitude!),
          width: 42,
          height: 42,
          child: GestureDetector(
            onTap: () => PlaceSheet.show(p),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: pinColor, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: AppColors.shadow, blurRadius: 6),
                ],
              ),
              child: Icon(
                p.verified
                    ? Icons.verified_rounded
                    : Icons.local_hospital_rounded,
                color: pinColor,
                size: 22,
              ),
            ),
          ),
        ),
      );
    }
    return markers;
  }

  Widget _searchingChip(MapTabController c) {
    final label = c.placeType.value == PlaceType.bloodBank
        ? 'blood banks'
        : 'hospitals';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 12)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 3.w),
          MyText(
            title: 'Finding nearby $label...',
            size: 11.sp,
            weight: FontWeight.w600,
            clr: AppColors.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _typeToggle(MapTabController c) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 12)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _chip(c, 'Hospitals', PlaceType.hospital),
            _chip(c, 'Blood Banks', PlaceType.bloodBank),
          ],
        ),
      ),
    );
  }

  Widget _chip(MapTabController c, String label, PlaceType type) {
    final selected = c.placeType.value == type;
    return GestureDetector(
      onTap: () => c.setType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.trans,
          borderRadius: BorderRadius.circular(30),
        ),
        child: MyText(
          title: label,
          size: 11.sp,
          weight: FontWeight.w700,
          clr: selected ? AppColors.white : AppColors.textMuted,
        ),
      ),
    );
  }
}
