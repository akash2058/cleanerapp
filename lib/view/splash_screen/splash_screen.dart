import 'dart:async';

import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';

import 'package:binbookingapp/view/shared_preference/binbooking_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  checkLoginStatus() async {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Utils.manipulateLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CleanerAppcolors.primaryminigreycolor,
      body: Center(
        child: Column(
          spacing: 5.r,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 370.h,
              width: MediaQuery.sizeOf(context).width,
              child: DecoratedBox(decoration: BoxDecoration(color: CleanerAppcolors.primarylightpurple,borderRadius:BorderRadius.only(
                topLeft: Radius.circular(80).r,
                topRight: Radius.circular(80).r,
              ),
               ),
               child: Padding(
                 padding:  EdgeInsets.all(50.0),
                 child: Image.asset(AppIcons.applogo,),
               ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
