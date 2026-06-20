import 'dart:io';
import 'dart:math';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ppsc_preparation/app/extensions/extensions.dart';

import '../config/app_colors.dart';
import 'package:intl/intl.dart';

import '../shared_widgets/custom_confirmation_dialog.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getIconPath(String name, {String format = 'png'}) {
    return 'assets/icons/$name.$format';
  }

  static String formatDate(DateTime date, {String? format}) {
    return DateFormat(format ?? 'd MMM, yyyy').format(date);
  }

  static String convertDateToString(DateTime date, {String? format}) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static TimeOfDay convertToTimeOfDay(String time) {
    final format =
        RegExp(r'^(\d{1,2}):(\d{2})\s?(AM|PM)$', caseSensitive: false);
    final match = format.firstMatch(time);

    if (match == null) {
      throw const FormatException("Invalid time format");
    }

    final hours = int.parse(match.group(1)!);
    final minutes = int.parse(match.group(2)!);
    final period = match.group(3)!.toUpperCase();

    int adjustedHours = period == "PM" && hours != 12
        ? hours + 12
        : period == "AM" && hours == 12
            ? 0
            : hours;

    return TimeOfDay(hour: adjustedHours, minute: minutes);
  }

  static TimeOfDay convertStringToTimeOfDay(String timeString) {
    // Convert string to TimeOfDay
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
    return time;
  }

  static int splitHour(String time) {
    List<String> parts = time.split(":");
    TimeOfDay timeOfDay =
        TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    int hour = timeOfDay.hour;
    return hour;
  }

  static int splitMin(String time) {
    List<String> parts = time.split(":");
    TimeOfDay timeOfDay =
        TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    int minute = timeOfDay.minute;
    return minute;
  }

  static List<String> listOfHour = [
    '0 hour',
    '1 hour',
    '2 hours',
    '3 hours',
    '4 hours',
    '5 hours',
    '6 hours',
    '7 hours',
    '8 hours',
    '9 hours',
    '10 hours',
    '11 hours',
    '12 hours',
    '13 hours',
    '14 hours',
    '15 hours',
    '16 hours',
    '17 hours',
    '18 hours',
    '19 hours',
    '20 hours',
    '21 hours',
    '22 hours',
    '23 hours'
  ];

  static List<String> minutesList = [
    '5 minutes',
    '10 minutes',
    '15 minutes',
    '20 minutes',
    '25 minutes',
    '30 minutes',
    '35 minutes',
    '40 minutes',
    '45 minutes',
    '50 minutes',
    '55 minutes'
  ];

  static String getSvgPath(String name, {String format = 'svg'}) {
    return 'assets/svgIcons/$name.$format';
  }

  static bool validateEmail(String value) {
    String pattern =
        r'^[a-zA-Z0-9][a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String? getTableByNumber(String tableNumber) {
    switch (tableNumber) {
      case "1":
        return 'assets/svgs/four-capacity.svg';
      case "2":
        return 'assets/svgs/two-capacity.svg';
      case "3":
        return 'assets/svgs/four-capacity.svg';
      case "4":
        return 'assets/svgs/six-capacity-h.svg';
      case "5":
        return 'assets/svgs/four-capacity.svg';
      case "6":
        return 'assets/svgs/four-capacity.svg';
      case "7":
        return 'assets/svgs/six-capacity-v.svg';
      case "8":
        return 'assets/svgs/two-capacity.svg';
      case "9":
        return 'assets/svgs/six-capacity-v.svg';
    }
    return null;
  }

  static int convertIntoMinutes(String timeString) {
    RegExp regExp = RegExp(r'(\d+)');
    List<Match> matches = regExp.allMatches(timeString).toList();
    int hours = int.parse(matches[0].group(0)!); // First number is hours
    int minutes = int.parse(matches[1].group(0)!); // Second number is minutes
    int totalMinutes = (hours * 60) + minutes;
    print("Total Minutes: $totalMinutes");

    return totalMinutes;
  }

  static splitTime(String time) {
    if (time.contains('0 hour')) {
      List<String> parts = time.split(' ');
      return '${parts[2]} ${parts[3]}';
    } else {
      return time;
    }
  }

  static bool isTimeValidForAll(
    List<TimeOfDay> formattedTimeList,
    TimeOfDay nextTime,
    List<int> durationList,
    List<DateTime> dateList,
    DateTime nextDate,
  ) {
    for (int i = 0; i < formattedTimeList.length; i++) {
      // Check if the date matches
      if (dateList[i].year == nextDate.year &&
          dateList[i].month == nextDate.month &&
          dateList[i].day == nextDate.day) {
        // Calculate the minutes for current time and next time
        int selectedMinutes =
            formattedTimeList[i].hour * 60 + formattedTimeList[i].minute;
        int nextMinutes = nextTime.hour * 60 + nextTime.minute;
        int rangeEnd = selectedMinutes + durationList[i];

        // If the time falls within the range of any entry, return false
        if (nextMinutes >= selectedMinutes && nextMinutes < rangeEnd) {
          return false;
        }
      }
    }
    return true; // If no conflicts, time is valid
  }

  static bool isDateBeforeToday(DateTime date) {
    DateTime today = DateTime.now().subtract(const Duration(days: 1));
    return date.isBefore(today);
  }

  static Future showWillPopDialog(context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
            title: 'We’re sorry to see you leave!'.tr,
            subTitle: 'Are you sure you want to exit app ?'.tr,
            yesOnTap: () {
              SystemNavigator.pop();
            });
      },
    );
  }

  static Future<void> showBottomSheet(Widget sheetWidget,
      {bool isDismissible = true,
      Color? barrierColor,
      double? maxHeight,
      BorderRadius? borderRadius}) {
    return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      barrierColor: barrierColor ?? AppColors.black.withOpacity(.4),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(0)),
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: sheetWidget,
          ),
        );
      },
    );
  }

  static String convertTo12HourFormat(String time24) {
    // Parse the 24-hour format time "1970-01-01 $time24:00"
    DateTime dateTime = DateTime.parse(time24);

    // Format to 12-hour format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
  }

  static void willPopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'We’re sorry to see you leave!'.tr,
          subTitle: 'Are you sure you want to exit app?'.tr,
          yesOnTap: () {
            Get.back();
            SystemNavigator.pop();
          },
        );
      },
    );
  }

  static DateTime convertDateStingToDateTime(dateString) {
    DateFormat format = DateFormat('d-M-yyyy');
    DateTime date = format.parse(dateString);
    return date;
  }

  static String timeDifference(String startTime, String endTime) {
    DateTime startDateTime = DateTime.parse("2000-01-01 $startTime");
    DateTime endDateTime = DateTime.parse("2000-01-01 $endTime");

    Duration difference = endDateTime.difference(startDateTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    return "$hours hours $minutes minutes";
  }

  static String getWeekdayName(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[weekday - 1];
  }

  static String getProfilePath(String name, {String format = 'png'}) {
    return 'assets/icons/profile_icons/$name.$format';
  }

  static showToast({required String message, int time = 2}) {
    // Get.showSnackbar(
    //    GetSnackBar(
    //     title: message, // Optional, can be left empty
    //     message:null, // Snackbar message
    //     duration: const Duration(seconds: 2), // Duration the snackbar will be visible
    //     snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
    //   ),
    // );

    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: time,
        backgroundColor: AppColors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  static void setStatusBarColorDark() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  static bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static Future getImageFromGallery({bool isVideo = false}) async {
    final file = isVideo
        ? await ImagePicker.platform.getVideo(
            source: ImageSource.gallery,
          )
        : await ImagePicker.platform.getImageFromSource(
            source: ImageSource.gallery,
          );
    if (file != null) {
      // File? returnFile = await refineImage(File(file.path));
      // Get.log(
      //     '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return File(file.path);
    }
  }

  static Future getImageFromCamera() async {
    final pickedFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.camera);
    if (pickedFile != null) {
      File? returnFile = await refineImage(File(pickedFile.path));
      Get.log(
          '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }

  static bool validatePhoneNumber(String phoneNumber, String isoCode) {
    try {
      bool isValid = CountryUtils.validatePhoneNumber(
          phoneNumber.replaceAll(' ', ''), isoCode);
      return isValid;
    } catch (e) {
      return false;
    }
  }

  static Future<File?> refineImage(File pickedFile) async {
    // final tempDir = await getTemporaryDirectory();

    File toCompress = pickedFile;

    print(toCompress.path);

    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: toCompress.path,
      aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
      // aspectRatioPresets: Platform.isAndroid
      //     ? [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ]
      //     : [
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio5x3,
      //   CropAspectRatioPreset.ratio5x4,
      //   CropAspectRatioPreset.ratio7x5,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Refine Image',
            toolbarColor: AppColors.secondary,
            toolbarWidgetColor: AppColors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: AppColors.secondary,
            backgroundColor: AppColors.secondary,
            statusBarColor: AppColors.secondary,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Refine Image',
        )
      ],
    );

    if (croppedFile != null) {
      pickedFile = File(croppedFile.path);
      return pickedFile;
    } else {
      return null;
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<bool> getPermissionStatus(
      {Permission permission = Permission.photos}) async {
    var status = await permission.status;
    print(status.isDenied);

    if (status.isGranted) {
      return true;

      // onNewCameraSelected(cameras[0]);
      // refreshAlreadyCapturedImages();
    } else if (status.isDenied) {
      await permission.request();
      status = await permission.status;
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      await openAppSettings();
      status = await permission.status;
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  // static String getDay(DateTime createdAt) {
  //   //DateTime currentDate = DateTime.now();
  //   final today = DateTime.now().subtract(const Duration(days: 0));
  //   final yesterday = DateTime.now().subtract(const Duration(days: 1));
  //   final thisWeek7 = DateTime.now().subtract(const Duration(days: 7));
  //   final thisWeek6 = DateTime.now().subtract(const Duration(days: 6));
  //   final thisWeek5 = DateTime.now().subtract(const Duration(days: 5));
  //   final thisWeek4 = DateTime.now().subtract(const Duration(days: 4));
  //   final thisWeek3 = DateTime.now().subtract(const Duration(days: 3));
  //   final thisWeek2 = DateTime.now().subtract(const Duration(days: 2));

  //   if (today.day == createdAt.day) {
  //     return "Today".tr;
  //   }

  //   // else if ((currentDate.day - createdAt.day <= 1) || (currentDate.day - createdAt.day == -29)  || (currentDate.day - createdAt.day == -30) || (currentDate.day - createdAt.day == -27)) {
  //   //   return "Yesterday";
  //   // }

  //   else if (yesterday.day == createdAt.day) {
  //     return "Yesterday".tr;
  //   }
  //   // else if (currentDate.day - createdAt.day == 7 ||
  //   //     currentDate.day - createdAt.day < 0) {
  //   //   return "This Week";
  //   // }
  //   else if (thisWeek7.day == createdAt.day) {
  //     return "This Week".tr;
  //   } else if (thisWeek6.day == createdAt.day) {
  //     return "This Week".tr;
  //   } else if (thisWeek5.day == createdAt.day) {
  //     return "This Week".tr;
  //   } else if (thisWeek4.day == createdAt.day) {
  //     return "This Week".tr;
  //   } else if (thisWeek3.day == createdAt.day) {
  //     return "This Week".tr;
  //   } else if (thisWeek2.day == createdAt.day) {
  //     return "This Week".tr;
  //   }
  //   // else if (currentDate.day - createdAt.day > 7 &&
  //   //     currentDate.month - createdAt.month >= 1) {
  //   //   return "Earlier";
  //   // }
  //   return "Earlier".tr;
  // }

  static String getDay(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    // Return minutes ago
    if (difference.inMinutes < 1) {
      return "Just now".tr;
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m".tr; // e.g., 10m
    }

    // Return hours ago
    else if (difference.inHours < 24) {
      return "${difference.inHours}h".tr; // e.g., 5h
    }

    // Return "Yesterday"
    else if (difference.inDays == 1) {
      return "Yesterday".tr;
    }

    // Return "X days ago" for up to 7 days
    else if (difference.inDays <= 7) {
      return "${difference.inDays} days".tr; // e.g., 2 days ago
    }

    // Return "This Week" for dates within this week but not exact days
    else if (isSameWeek(createdAt, now)) {
      return "This Week".tr;
    }

    // Return formatted date for earlier dates
    else {
      return DateFormat.yMMMd().format(createdAt); // e.g., Sep 10, 2022
    }
  }

  /// Helper function to check if two dates are in the same week
  static bool isSameWeek(DateTime date1, DateTime date2) {
    final weekStart1 = date1.subtract(Duration(days: date1.weekday - 1));
    final weekStart2 = date2.subtract(Duration(days: date2.weekday - 1));
    return weekStart1.year == weekStart2.year &&
        weekStart1.weekOfYear == weekStart2.weekOfYear;
  }

  // static Future<String> getFileUrl(String fileName) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return "${directory.path}/$fileName";
  // }

  static int convertToMinutes(String interval) {
    // Split the input into parts (e.g., "2 h 10 min" -> ["2", "h", "10", "min"])
    final parts = interval.split(' ');

    int hours = 0;
    int minutes = 0;
    // Parse the parts
    for (int i = 0; i < parts.length; i += 2) {
      final value = int.tryParse(parts[i]) ?? 0;
      if (parts[i + 1] == 'h') {
        hours = value;
      } else if (parts[i + 1] == 'min') {
        minutes = value;
      }
    }
    // Convert hours and minutes to total minutes
    return (hours * 60) + minutes;
  }

  static String convertToFormattedInterval(int totalMinutes) {
    // Calculate hours and remaining minutes
    int hours = totalMinutes ~/ 60; // Integer division to get hours
    int minutes = totalMinutes % 60; // Modulus to get remaining minutes

    // Build the formatted string
    String formattedInterval = '';
    if (hours > 0) {
      formattedInterval += '$hours h';
    }
    if (minutes > 0) {
      if (formattedInterval.isNotEmpty) {
        formattedInterval += ' ';
      }
      formattedInterval += '$minutes min';
    }

    return formattedInterval;
  }
}
