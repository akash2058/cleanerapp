import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:binbookingapp/view/session_expire_dialog/session_expire_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData(context);
    });
  }

  void getData(context) async {
    try {
      final logindata = Provider.of<LoginProvider>(context, listen: false);
      await logindata.loadLoginData();

      final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
      final binrequestdata = Provider.of<BinRequestProvider>(
        context,
        listen: false,
      );

      await Future.wait([
        myordersdata.getMyordersData(logindata.userid),
        binrequestdata.getBinRequestData(),
      ]);
      
      myordersdata.paymentreceivecontroller.clear();
      myordersdata.amountreceivecontroller.clear();

      print('userid: ${logindata.userid}');
    } catch (e) {
      print('Error loading dashboard data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<DashboardProvider, MyOrderProvider, BinRequestProvider>(
      builder: (context, dash, myroder, binreqest, child) {
        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryminigreycolor,
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              color: CleanerAppcolors.primaryminigreycolor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15).r,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      dash.screenTabs(dash.currenttab = 0);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Column(
                        spacing: 4.5.r,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 2.r,
                            width: 50.r,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    dash.currenttab == 0
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null,
                              ),
                            ),
                          ),
                          Image.asset(
                            AppIcons.homeicon,
                            height: 23.r,
                            color:
                                dash.currenttab == 0
                                    ? const Color.fromARGB(255, 54, 57, 251)
                                    : null,
                          ),
                          Text(
                            'Home',
                            style:
                                dash.currenttab == 0
                                    ? dashboardlablefontpurple
                                    : dashboardlabelfontblack,
                          ),
                          SizedBox(height: 5.r),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dash.screenTabs(dash.currenttab = 1);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Column(
                        spacing: 5.r,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 2.r,
                            width: 50.r,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    dash.currenttab == 1
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null,
                              ),
                            ),
                          ),
                          Badge(
                            largeSize: 14.r,
                            alignment: Alignment.topRight,
                            label:
                                binreqest.loadingbinbooking == true
                                    ? LoadingAnimationWidget.fallingDot(
                                      color: CleanerAppcolors.primaryWhitecolor,
                                      size: 15.r,
                                    )
                                    : Text(
                                      ((binreqest
                                                      .binbook
                                                      ?.data
                                                      .siteRequests
                                                      .length ??
                                                  0) +
                                              (binreqest
                                                      .binbook
                                                      ?.data
                                                      .warehouseRequests
                                                      .length ??
                                                  0))
                                          .toString(),
                                      style: badgefont,
                                    ),

                            child: Image.asset(
                              AppIcons.requesticon,
                              height: 23.r,
                              color:
                                  dash.currenttab == 1
                                      ? const Color.fromARGB(255, 54, 57, 251)
                                      : null,
                            ),
                          ),
                          Text(
                            'Bin Request',
                            style:
                                dash.currenttab == 1
                                    ? dashboardlablefontpurple
                                    : dashboardlabelfontblack,
                          ),
                          SizedBox(height: 5.r),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dash.screenTabs(dash.currenttab = 2);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Column(
                        spacing: 5.r,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 2.r,
                            width: 50.r,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    dash.currenttab == 2
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null,
                              ),
                            ),
                          ),
                          Badge(
                            alignment: Alignment.topRight,
                            largeSize: 14.r,
                            label:
                                myroder.loadingmyorderdata == true
                                    ? LoadingAnimationWidget.fallingDot(
                                      color: CleanerAppcolors.primaryWhitecolor,
                                      size: 15.r,
                                    )
                                    : Text(
                                      ((myroder
                                                      .order
                                                      ?.data
                                                      ?.siteOrder
                                                      ?.length ??
                                                  0) +
                                              (myroder
                                                      .order
                                                      ?.data
                                                      ?.warehouseOrder
                                                      ?.length ??
                                                  0))
                                          .toString(),
                                      style: badgefont,
                                    ),

                            child: Image.asset(
                              AppIcons.myordersicon,
                              height: 23.r,
                              color:
                                  dash.currenttab == 2
                                      ? const Color.fromARGB(255, 54, 57, 251)
                                      : null,
                            ),
                          ),
                          Text(
                            'My Job/Task',
                            style:
                                dash.currenttab == 2
                                    ? dashboardlablefontpurple
                                    : dashboardlabelfontblack,
                          ),
                          SizedBox(height: 5.r),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dash.screenTabs(dash.currenttab = 3);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Column(
                        spacing: 5.r,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 2.r,
                            width: 50.r,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color:
                                    dash.currenttab == 3
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null,
                              ),
                            ),
                          ),
                          Image.asset(
                            AppIcons.profileicon,
                            height: 23.r,
                            color:
                                dash.currenttab == 3
                                    ? const Color.fromARGB(255, 54, 57, 251)
                                    : null,
                          ),
                          Text(
                            'Profile',
                            style:
                                dash.currenttab == 3
                                    ? dashboardlablefontpurple
                                    : dashboardlabelfontblack,
                          ),
                          SizedBox(height: 5.r),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SessionWrapper(
            child: Column(
              children: [
                NoInternetBanner(),
                Expanded(child: dash.screens[dash.currenttab]),
              ],
            ),
          ),
        );
      },
    );
  }
}
