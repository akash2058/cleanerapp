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
  Future<bool> isSessionActive() async {
    final token = await Utils.getToken();
    final prefs = await SharedPreferences.getInstance();
    final loginTimeStr = prefs.getString('login_time');

    if (token == null || loginTimeStr == null) return false;

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) return false;

    // Session valid for 24 hours
    final now = DateTime.now();
    return now.difference(loginTime).inHours < 24;
  }

  String name = '';
  String email = '';
  String userid = '';
  Future<void> loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    name = prefs.getString('name') ?? '';
    userid = prefs.getString('userid') ?? '';
    notifyListeners();
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
        Utils.saveToken(_userModel?.data?.token ?? '');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', _userModel?.data?.user?.name ?? '');
        await prefs.setString('email', _userModel?.data?.user?.email ?? '');
        await prefs.setString(
          'userid',
          _userModel?.data?.user?.id.toString() ?? '',
        );
        await prefs.setString('token', user?.data?.token ?? '');
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
              bottom: MediaQuery.sizeOf(context).height - 170.r,
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
        Utils.deleteToken();
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
