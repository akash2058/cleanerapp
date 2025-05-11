import 'package:binbookingapp/custom_widget/cleaner_chip.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart'
    show LoginProvider;
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/home/home_provider/home_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GreetingsCard extends StatelessWidget {
  const GreetingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, home, child) {
        return Consumer<LoginProvider>(
          builder: (context, log, child) {
            return Consumer<DashboardProvider>(
              builder: (context, dash, child) {
                return Consumer<MyOrderProvider>(
                  builder: (context, myorder, child) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            opacity: 0.6.r,
                            image: AssetImage(AppIcons.backimg),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(
                                105,
                                108,
                                255,
                                0.4,
                                // ignore: deprecated_member_use
                              ).withOpacity(0.5.r),
                              spreadRadius: 1.5.r,
                              blurRadius: 1.5.r,
                              offset: Offset(0, 0),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 121, 123, 245),
                              const Color.fromARGB(255, 123, 125, 246),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(
                                horizontal: 17,
                                vertical: 25,
                              ).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(home.getGreeting(), style: buttonfond),
                              SizedBox(height: 10.r),
                              Text(log.name, style: drivernamefont),
                              SizedBox(height: 20.r),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CleanerWhiteFontChip(
                                    onPressed: () {
                                      dash.screenTabs(dash.currenttab = 2);
                                    },
                                    label: 'My Orders',
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      54,
                                      57,
                                      251,
                                    ),
                                  ),
                                  Row(
                                    spacing: 5.r,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward_outlined,
                                            size: 20.r,
                                            color:
                                                CleanerAppcolors
                                                    .primaryWhitecolor,
                                          ),
                                          Text(
                                            myorder
                                                    .order
                                                    ?.data
                                                    ?.siteOrder
                                                    ?.length
                                                    .toString() ??
                                                '',
                                            style: dashboardlablefontwhite,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                        Icons.arrow_downward_outlined,
                                        size: 20.r,
                                        color:
                                            CleanerAppcolors.primaryWhitecolor,
                                      ),
                                      Text(
                                        myorder
                                                .order
                                                ?.data
                                                ?.warehouseOrder
                                                ?.length
                                                .toString() ??
                                            '',
                                        style: dashboardlablefontwhite,
                                      ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
