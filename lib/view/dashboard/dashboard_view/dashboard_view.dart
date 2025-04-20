
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:binbookingapp/view/session_expire_dialog/session_expire_dialog.dart';
import 'package:binbookingapp/view/shared_preference/binbooking_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final token = Utils.getToken();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
        final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
await myordersdata.getMyordersData(logindata.user?.data?.user?.id.toString()??'' );
    final binrequestdata =
        Provider.of<BinRequestProvider>(context, listen: false);
    await binrequestdata.getBinRequestData(); 
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dash, child) {
        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryminigreycolor,
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
          color: CleanerAppcolors.primaryminigreycolor
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
                                    color: dash.currenttab == 0
                                        ?  const Color.fromARGB(255, 54, 57, 251)
                                        : null)),
                          ),
                          Image.asset(
                            AppIcons.homeicon,
                            height: 23.r,
                            color: dash.currenttab == 0
                                ?  const Color.fromARGB(255, 54, 57, 251)
                                : null,
                          ),
                          Text(
                            'Home',
                            style: dash.currenttab == 0
                                ? dashboardlablefontpurple
                                : dashboardlabelfontblack,
                          ),
                          SizedBox(
                            height: 5.r,
                          )
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
                                    color: dash.currenttab == 1
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null)),
                          ),
                          Image.asset(
                            AppIcons.requesticon,
                            height: 23.r,
                            color: dash.currenttab == 1
                                ?  const Color.fromARGB(255, 54, 57, 251)
                                : null,
                          ),
                          Text(
                            'Bin Request',
                            style: dash.currenttab == 1
                                ? dashboardlablefontpurple
                                : dashboardlabelfontblack,
                          ),
                          SizedBox(
                            height: 5.r,
                          )
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
                                    color: dash.currenttab == 2
                                        ? const Color.fromARGB(255, 54, 57, 251)
                                        : null)),
                          ),
                          Image.asset(
                            AppIcons.myordersicon,
                            height: 23.r,
                            color: dash.currenttab == 2
                                ?  const Color.fromARGB(255, 54, 57, 251)
                                : null,
                          ),
                          Text(
                            'My Orders',
                            style: dash.currenttab == 2
                                ? dashboardlablefontpurple
                                : dashboardlabelfontblack,
                          ),
                          SizedBox(
                            height: 5.r,
                          )
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
                                    color: dash.currenttab == 3
                                        ?  const Color.fromARGB(255, 54, 57, 251)
                                        : null)),
                          ),
                          Image.asset(AppIcons.profileicon,
                              height: 23.r,
                              color: dash.currenttab == 3
                                  ? const Color.fromARGB(255, 54, 57, 251)
                                  : null),
                          Text(
                            'Profile',
                            style: dash.currenttab == 3
                                ? dashboardlablefontpurple
                                : dashboardlabelfontblack,
                          ),
                          SizedBox(
                            height: 5.r,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              NoInternetBanner(),
              Expanded(child: dash.screens[dash.currenttab])
            ],
          ),
        );
      },
    );
  }
}
