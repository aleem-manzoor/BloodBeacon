import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:blood_beacon/app/config/app_colors.dart';
import 'package:blood_beacon/app/shared_widgets/empty_state.dart';
import 'package:blood_beacon/app/shared_widgets/my_text.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';

import '../controllers/my_requests_controller.dart';
import '../widgets/request_card.dart';

class MyRequestsView extends StatelessWidget {
  const MyRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MyRequestsController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'requestsFab',
        backgroundColor: AppColors.primary,
        onPressed: c.goCreate,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: MyText(
          title: 'New Request',
          size: 12.sp,
          weight: FontWeight.w700,
          clr: AppColors.white,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
              child: MyText(
                title: 'My Requests',
                size: 18.sp,
                weight: FontWeight.w800,
                clr: AppColors.textDark,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<BloodRequestModel>>(
                stream: c.myRequests,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const EmptyState(
                      icon: Icons.bloodtype_outlined,
                      title: 'No requests yet',
                      subtitle:
                          'Create an emergency blood request and reach nearby donors instantly.',
                    );
                  }
                  return ListView(
                    padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 12.h),
                    children: items
                        .map((r) => RequestCard(
                              request: r,
                              onTap: () => c.openDetail(r),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
