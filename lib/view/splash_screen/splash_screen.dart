import 'dart:async';

import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/authentication/login/login_view/login_view.dart';
import 'package:binbookingapp/view/dashboard/dashboard_view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Get the token from SharedPreferences

    // Wait for 2 seconds (splash duration)
    Future.delayed(const Duration(seconds: 2), () {
      if (token != null && token.isNotEmpty) {
        // If token is found, navigate to the Dashboard
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: const DashboardView()),
          (route) => false,
        );
      } else {
        // If no token found, navigate to the Login screen
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: const LoginView()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CleanerAppcolors.primaryminigreycolor,
      body: Center(
        child: Column(
          spacing: 5.r,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcons.cleanerbinlogo, height: 90.r),
            LoadingAnimationWidget.dotsTriangle(
                color: CleanerAppcolors.primarypurple, size: 40.r)
          ],
        ),
      ),
    );
  }
}
