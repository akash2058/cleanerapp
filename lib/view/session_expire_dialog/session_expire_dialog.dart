import 'dart:async';
import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/authentication/login/login_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SessionWrapper extends StatefulWidget {
  final Widget child;
  const SessionWrapper({super.key, required this.child});

  @override
  State<SessionWrapper> createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> {
  Timer? _sessionTimer;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scheduleSessionCheck());
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }

  Future<void> scheduleSessionCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTimeStr = prefs.getString('login_time');

    if (loginTimeStr == null) {
      // Fallback if no login time is stored
      print('Login time not found. Expiring session immediately.');
      checkSession(); // This will trigger logout
      return;
    }

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) {
      print('Login time parsing failed. Expiring session immediately.');
      checkSession();
      return;
    }

    final sessionExpiry = loginTime.add(Duration(hours: 24));
    final now = DateTime.now();
    final remaining = sessionExpiry.difference(now);

    if (remaining.isNegative) {
      // Session already expired
      print('Session already expired.');
      checkSession();
      return;
    }

    print('Session check scheduled in: ${remaining.inMinutes} minutes');
    _sessionTimer = Timer(remaining, checkSession);
  }

  Future<void> checkSession() async {
    final isValid = await context.read<LoginProvider>().isSessionActive();

    if (!isValid && mounted && !_dialogShown) {
      _dialogShown = true;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text("Session Expired", style: appbartitlefont),
          content: Text("Your session has expired. Please log in again.", style: dashboardlabelfontblack),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  CustomPageRoute(child: const LoginView()),
                  (route) => false,
                );
              },
              child: const Text("Go to Login"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
