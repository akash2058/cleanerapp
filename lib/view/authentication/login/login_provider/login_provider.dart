

import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_view/login_view.dart';
import 'package:binbookingapp/view/authentication/login/model/user_model.dart';
import 'package:binbookingapp/view/authentication/login/service/login_api_service.dart';
import 'package:binbookingapp/view/dashboard/dashboard_view/dashboard_view.dart';
import 'package:binbookingapp/view/shared_preference/binbooking_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get user => _userModel;

  bool loadinglogin = false;
  bool hidepassword = true;
  bool loadinglogout = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void toggleHidepassword() {
    hidepassword = !hidepassword;
    notifyListeners();
  }
  // Replace with your actual utils path

 Future<bool> isSessionActive() async {
  try {
    final token = await Utils.getToken();
    if (token == null || token.isEmpty) {
      print('Token is null or empty');
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final loginTimeStr = prefs.getString('login_time');
    if (loginTimeStr == null) {
      print('Login time not found');
      return false;
    }

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) {
      print('Login time parsing failed');
      return false;
    }

    final now = DateTime.now();
    final hoursSinceLogin = now.difference(loginTime).inHours;

    print('Hours since login: $hoursSinceLogin');

    // Only check 24-hour session expiry
    if (hoursSinceLogin >= 24) {
      print('Session expired: more than 24 hours since login');
      return false;
    }

    print('Session is active');
    return true;
  } catch (e) {
    print('Error checking session: $e');
    return false;
  }
}


  String name = 'N/A';
  String email = 'N/A';
  String userid = 'N/A';
  String gender = 'N/A';
  String contact = 'N/A';
  String address = 'N/A';
  Future<void> loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = _checkEmpty(prefs.getString('name'));
    email = _checkEmpty(prefs.getString('email'));
    userid = _checkEmpty(prefs.getString('userid'));
    gender = _checkEmpty(prefs.getString('gender'));
    contact = _checkEmpty(prefs.getString('contact'));
    address = _checkEmpty(prefs.getString('address'));

    notifyListeners();
  }

  String _checkEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'N/A';
    }
    return value;
  }
Future<void> clearAppCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print('✅ Cache cleared.');
    }
  } catch (e) {
    print('⚠️ Error clearing cache: $e');
  }
}

Future<void> getLogin(context) async {
  try {
    loadinglogin = true;
    notifyListeners();

    final userMap = await fetchLogindata(
      emailcontroller.text,
      passwordcontroller.text,
    );

    _userModel = UserModel.fromJson(userMap);

    if (userMap['status'] == 'success') {
      final token = _userModel?.data?.token ?? '';
      Utils.saveToken(token); 
      print('tokkkes${token}');
      // Save token once, via your utility
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('gender', _userModel?.data?.user?.gender ?? '');
      await prefs.setString('address', _userModel?.data?.user?.address ?? '');
      await prefs.setString('contact', _userModel?.data?.user?.contact ?? '');
      await prefs.setString('name', _userModel?.data?.user?.name ?? '');
      await prefs.setString('email', _userModel?.data?.user?.email ?? '');
      await prefs.setString('userid', _userModel?.data?.user?.id.toString() ?? '');
      await prefs.setString('login_time', DateTime.now().toIso8601String());

      // No need to save 'token' again here if already done via Utils

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height - 170.r,
            left: 10.r,
            right: 10.r,
          ),
          dismissDirection: DismissDirection.up,
          backgroundColor: CleanerAppcolors.primaryGreencolor,
          content: Text(userMap['message'], style: buttonfond),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(child: const DashboardView()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height - 220.r,
            left: 10.r,
            right: 10.r,
          ),
          dismissDirection: DismissDirection.up,
          backgroundColor: CleanerAppcolors.primaryRedcolor,
          content: Text(userMap['message'], style: buttonfond),
        ),
      );
    }

    loadinglogin = false;
    notifyListeners();
  } catch (e) {
    loadinglogin = false;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    print('Error: $e');
    throw {"error": e};
  }
}


  Future<void> getLogout(context) async {
    var token = await Utils.getToken(); // Await the token
    try {
      loadinglogout = true;
      notifyListeners();
      final logout = await fetchLogout(token);
      if (logout['status'] == 'success') {
       await clearAppCache();
        await Utils.deleteToken();
        Navigator.push(context, CustomPageRoute(child: LoginView()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height - 170.r,
              left: 10.r,
              right: 10.r,
            ),
            dismissDirection: DismissDirection.up,
            backgroundColor: CleanerAppcolors.primaryGreencolor,
            content: Text(logout['message'], style: buttonfond),
          ),
        );
      }
      loadinglogout = false;
      notifyListeners();
    } catch (e) {
      loadinglogout = false;
      notifyListeners();
      print('Error in logout: $e');
      rethrow;
    }
  }
}
