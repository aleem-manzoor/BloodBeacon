import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:blood_beacon/app/utils/utils.dart';

class CheckConnectivity extends GetxService {
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus.value = result.first;
    if (connectionStatus.value == ConnectivityResult.mobile) {
      print("Connected to mobile");
      if (await hasActiveInternetConnection()) {
        print('Connectivity changed: $connectionStatus mobile error');
        Utils.showToast(message: 'No Internet Connection');
      }
    } else if (connectionStatus.value == ConnectivityResult.wifi) {
      print("Connected to WiFi");
      if (await hasActiveInternetConnection()) {
        print('Connectivity changed: $connectionStatus mobile error');
        Utils.showToast(message: 'No Internet Connection');
      }
    } else if (connectionStatus.value == ConnectivityResult.none) {
      Utils.showToast(message: 'No Internet Connection');
    }
  }

  Future<bool> hasActiveInternetConnection(
      {Duration timeout = const Duration(seconds: 3)}) async {
    try {
      final result =
          await InternetAddress.lookup('example.com').timeout(timeout);

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected to the internet');
        return false; // Connection successful
      }
    } on SocketException catch (_) {
      print('No active internet connection');
      return true; // No connection
    } on TimeoutException catch (_) {
      print('Connection attempt timed out');
      return true; // Connection timed out
    }
    return true;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
