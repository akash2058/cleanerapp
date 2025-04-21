import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/forgot_password/forgot_password_view/forgot_password_screen.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, login, child) {
        final loginkey = GlobalKey<FormState>();

        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryminigreycolor,
          body: NoInternetBanner(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25).r,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: loginkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 180.r),
                          Text('Hello!', style: loginscreentitlefont),
                          SizedBox(height: 5.r),
                          Text('Welcome Back', style: loginscreentitlefont),
                          SizedBox(height: 40.r),
                          Text('Email', style: dashboardlablefontgrey),
                          SizedBox(height: 8.r),
                          CleanerTextfield(
                            fillColor: CleanerAppcolors.primaryWhitecolor,
                            autofills: [AutofillHints.email],
                            validation: validateEmail,
                            controller: login.emailcontroller,
                            prefix: Icon(Icons.email_outlined, size: 18.r),
                            hintlabel: 'Enter your email',
                          ),
                          SizedBox(height: 15.r),
                          Text('Password', style: dashboardlablefontgrey),
                          SizedBox(height: 5.r),
                          CleanerTextfield(
                            fillColor: CleanerAppcolors.primaryWhitecolor,
                            autofills: [AutofillHints.password],
                            validation: validatePassword,
                            controller: login.passwordcontroller,
                            obstructtext: login.hidepassword,
                            suffix: InkWell(
                              onTap: () {
                                login.toggleHidepassword();
                              },
                              child: Icon(
                                login.hidepassword == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.r,
                                color:
                                    login.hidepassword == true
                                        ? CleanerAppcolors.primarygreycolor
                                        : CleanerAppcolors.primarypurple,
                              ),
                            ),
                            prefix: Icon(Icons.lock_clock_outlined, size: 18.r),
                            hintlabel: 'Enter your password',
                          ),
                          SizedBox(height: 10.r),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password',
                                style: forgotpasswordfont,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.r),
                           CleanerButton.elevated(isloading: login.loadinglogin,
                            
                                height: 55.r,
                                width: MediaQuery.sizeOf(context).width,
                                backgroundcolor: CleanerAppcolors.primarypurple,
                                label: 'Login',
                                onPressed: () {
                                  if (loginkey.currentState!.validate()) {
                                    login.getLogin(context);
                                  }
                                },
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
