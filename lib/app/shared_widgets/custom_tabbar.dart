import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/shared_widgets/my_text.dart';

class CustomTabBar extends StatefulWidget {
  final List<Widget>? topbarWidgets;
  final List<String> tabs;
  final List<Widget> tabbarViews;
  final int initialIndex;
  final Function(int index)? setIndex;
  final TabController? tabController;
  final TabAlignment? tabAlignment;

  const CustomTabBar({
    super.key,
    this.initialIndex = 0,
    this.tabController,
    this.setIndex,
    required this.tabs,
    this.tabAlignment,
    required this.tabbarViews,
    this.topbarWidgets,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    log('Tabs length: ${widget.tabs.length}');
    _tabController = widget.tabController ??
        TabController(length: widget.tabs.length, vsync: this);
    _tabController.animateTo(widget.initialIndex);
    _tabController.animation?.addListener(() {
      final newIndex = _tabController.animation!.value.round();
      if (newIndex != selectedIndex) {
        setState(() {
          selectedIndex = newIndex;
        });
        log('Tab index during swipe: $selectedIndex');
      }
    });
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        selectedIndex = _tabController.index;
        widget.setIndex?.call(selectedIndex);
        if (mounted) {
          setState(() {});
        }
        log('Swiped to tab index: $selectedIndex');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DefaultTabController(
        length: widget.tabs.length,
        initialIndex: widget.initialIndex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.topbarWidgets != null &&
                widget.topbarWidgets!.isNotEmpty)
              Column(
                children: widget.topbarWidgets!,
              ),
            TabBar(
              controller: _tabController,
              isScrollable:
                  widget.tabAlignment == TabAlignment.fill ? false : true,
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              tabAlignment: widget.tabAlignment ?? TabAlignment.start,
              indicatorColor: AppColors.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
              dividerHeight: 3,
              dividerColor: AppColors.grey,
              overlayColor: const WidgetStatePropertyAll(AppColors.trans),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              indicatorWeight: 3,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  log('Selected index: $selectedIndex');
                });
              },
              tabs: List.generate(
                widget.tabs.length,
                (index) => Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          color: index == selectedIndex
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyText(
                          size: 10.5.sp,
                          title: widget.tabs[index],
                          clr: index == selectedIndex
                              ? Colors.white
                              : AppColors.hint,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (index == selectedIndex)
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.tabbarViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
