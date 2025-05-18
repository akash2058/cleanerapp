import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:binbookingapp/view/authentication/login/login_view/login_view.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/custom_widget/transaction_route.dart';

class SessionWrapper extends StatefulWidget {
  final Widget child;
  const SessionWrapper({super.key, required this.child});

  @override
  State<SessionWrapper> createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> {
  @override
 void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Short delay
    checkSession();
  });
}

  Future<void> checkSession() async {
    final isValid = await context.read<LoginProvider>().isSessionActive();

    if (!isValid && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title:  Text("Session Expired",style: appbartitlefont,),
          content:  Text("Your session has expired. Please log in again.",style: dashboardlabelfontblack,),
          actions: [
            TextButton(
              onPressed: () {
                checkSession();
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  CustomPageRoute(child: const LoginView()),
                  (route) => false,
                );
              },
              child:  Text("Go to Login"),
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
