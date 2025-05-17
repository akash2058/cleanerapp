import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/home/home_provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RequestSearchTabs extends StatelessWidget {
  const RequestSearchTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, BinRequestProvider>(
      builder: (context, home, binr, child) {
        return Row(
          spacing: 5.r,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final currentType =
                      binr.searchtab == 0
                          ? 'on_site_order'
                          : 'warehouse_dropoff';
                  binr.setFilterType(currentType, query: '');
                  binr.toggleSearchTab(0);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            105,
                            108,
                            255,
                            0.4,
                          ).withOpacity(0.5.r),
                          spreadRadius: 1.5.r,
                          blurRadius: 1.5.r,
                          offset: Offset(0, 0),
                        ),
                      ],
                      gradient:
                          binr.searchtab == 0
                              ? LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 76, 78, 231),
                                  const Color.fromARGB(255, 92, 94, 218),
                                ],
                              )
                              : LinearGradient(
                                colors: [
                                  CleanerAppcolors.primarylightgreycolor,
                                  CleanerAppcolors.primarylightgreycolor,
                                ],
                              ),
                      border: Border.all(
                        color:
                            binr.searchtab == 0
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dropoff',
                              style:
                                  binr.searchtab == 0
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                            Badge(
                              backgroundColor: CleanerAppcolors.primarypurple,
                              label:
                                  binr.loadingbinbooking
                                      ? LoadingAnimationWidget.fallingDot(
                                        color:
                                            CleanerAppcolors.primaryWhitecolor,
                                        size: 15.r,
                                      )
                                      : Text(
                                        binr.dropoffCount.toString(),
                                        style: badgefont,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final currentType =
                      binr.searchtab == 1
                          ? 'on_site_order'
                          : 'warehouse_dropoff';
                  binr.setFilterType(currentType, query: '');
                  binr.toggleSearchTab(1);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            105,
                            108,
                            255,
                            0.4,
                          ).withOpacity(0.5.r),
                          spreadRadius: 1.5.r,
                          blurRadius: 1.5.r,
                          offset: Offset(0, 0),
                        ),
                      ],
                      gradient:
                          binr.searchtab == 1
                              ? LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 76, 78, 231),
                                  const Color.fromARGB(255, 92, 94, 218),
                                ],
                              )
                              : LinearGradient(
                                colors: [
                                  CleanerAppcolors.primarylightgreycolor,
                                  CleanerAppcolors.primarylightgreycolor,
                                ],
                              ),
                      border: Border.all(
                        color:
                            binr.searchtab == 1
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Pickup',
                              style:
                                  binr.searchtab == 1
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                            Badge(
                              backgroundColor: CleanerAppcolors.primarypurple,
                              label:
                                  binr.loadingbinbooking
                                      ? LoadingAnimationWidget.fallingDot(
                                        color:
                                            CleanerAppcolors.primaryWhitecolor,
                                        size: 15.r,
                                      )
                                      : Text(
                                        binr.pickupCount.toString(),
                                        style: badgefont,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}