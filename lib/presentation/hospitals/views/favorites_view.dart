import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/app_top_bar.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_container.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/app/shared_widgets/place_sheet.dart';
import 'package:blood_beacon/data/model/favorite_model.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const AppTopBar(title: 'Saved Places'),
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<FavoriteModel>>(
          stream: controller.favorites,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data ?? [];
            if (items.isEmpty) {
              return const EmptyState(
                icon: Icons.favorite_border_rounded,
                title: 'No saved places',
                subtitle: 'Save hospitals and blood banks for quick access.',
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final f = items[i];
                return MyContainer(
                  margin: EdgeInsets.only(bottom: 1.6.h),
                  onTap: () => PlaceSheet.show(controller.toPlace(f)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.favorite_rounded,
                            color: AppColors.primary),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: f.name ?? 'Saved place',
                              size: 13.sp,
                              weight: FontWeight.w700,
                              clr: AppColors.textDark,
                              line: 1,
                              overFLow: TextOverflow.ellipsis,
                            ),
                            MyText(
                              title: f.address ?? f.placeType ?? '',
                              size: 10.5.sp,
                              clr: AppColors.textMuted,
                              line: 1,
                              overFLow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            f.id == null ? null : controller.remove(f.id!),
                        icon: const Icon(Icons.delete_outline_rounded,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
