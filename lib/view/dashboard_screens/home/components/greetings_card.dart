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
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                              Text(capitalizeEachPart(log.name), style: drivernamefont),
                              SizedBox(height: 20.r),
                              CleanerWhiteFontChip(
                                width: 195.r,
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
                                child:Row(
                                    spacing: 5.r,
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                        width: 2.r,
                                        child: DecoratedBox(decoration: BoxDecoration(
                                          color: CleanerAppcolors.primaryWhitecolor
                                        )),
                                      ),
                                      Row(
                                        spacing: 5.r,
                                        children: [
                                          Icon(
                                            Icons.arrow_circle_down,
                                            size: 20.r,
                                            color:
                                                CleanerAppcolors
                                                    .primaryWhitecolor,
                                          ),
                                       myorder.loadingmyorderdata == true?LoadingAnimationWidget.fallingDot(color: CleanerAppcolors.primaryWhitecolor,size: 10.r):Text(
                                            myorder
                                                    .order
                                                    ?.data
                                                    ?.siteOrder
                                                    ?.length
                                                    .toString() ??
                                                '0',
                                            style: dashboardlablefontwhite,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 5.r,
                                        children: [
                                          Icon(
                                        Icons.arrow_circle_up_outlined,
                                        size: 20.r,
                                        color:
                                            CleanerAppcolors.primaryWhitecolor,
                                      ),
                                                                           myorder.loadingmyorderdata == true?LoadingAnimationWidget.fallingDot(color: CleanerAppcolors.primaryWhitecolor,size: 10.r):  Text(
                                        myorder
                                                .order
                                                ?.data
                                                ?.warehouseOrder
                                                ?.length
                                                .toString() ??
                                            '0',
                                        style: dashboardlablefontwhite,
                                      ),
                                        ],
                                      )
                                    ],
                                  ),
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
String capitalizeEachPart(String input) {
  return input
      .split(',')
      .map((part) {
        return part
            .trim()
            .split(' ')
            .where((word) => word.isNotEmpty)
            .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
            )
            .join(' ');
      })
      .join(', ');
}