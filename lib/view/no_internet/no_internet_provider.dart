import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetProvider with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _hasInternet = true;
  bool get hasInternet => _hasInternet;

  InternetProvider() {
    _initialize();
  }

  void _initialize() {
    checkInitialConnection();
    _subscription = _connectivity.onConnectivityChanged.listen((resultList) {
      checkRealInternet(); // Instead of trusting just the connection type
    });
  }

  Future<void> checkInitialConnection() async {
    await checkRealInternet();
  }

  Future<void> checkRealInternet() async {
    bool previousStatus = _hasInternet;
    _hasInternet = await InternetConnection().hasInternetAccess;

    if (_hasInternet != previousStatus) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
