import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  final bool showIndicators;
  final List<String> images; // Accept images from parent

  const CustomCarousel(
      {super.key, required this.images, this.showIndicators = true});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // For smooth control

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController, // Attach controller
          itemCount: widget.images.length,
          options: CarouselOptions(
            height: Get.height * .2,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            bool isCenter = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: isCenter
                    ? [const BoxShadow(color: Colors.black26, blurRadius: 8)]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.images[index], // Use images from widget
                  width: Get.width * .7,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        if (widget.showIndicators) const SizedBox(height: 10),
        if (widget.showIndicators)
          // Smooth Page Indicator
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.images.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.blueAccent,
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 2,
              spacing: 5,
              dotColor: Colors.grey.shade400,
            ),
            onDotClicked: (index) {
              _carouselController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
      ],
    );
  }
}
