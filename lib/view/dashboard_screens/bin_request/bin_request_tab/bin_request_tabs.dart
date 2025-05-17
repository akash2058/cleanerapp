import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class BinRequestTabs extends StatelessWidget {
  const BinRequestTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BinRequestProvider>(
      builder: (context, home, child) {
        return Row(
          spacing: 5.r,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  home.toggleTab(home.currenttab = 0);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient:
                          home.currenttab == 0
                              ? LinearGradient(
                                colors: [
                        const Color.fromARGB(255, 76, 78, 231),
                      const Color.fromARGB(255, 92, 94, 218)
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
                            home.currenttab == 0
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dropoff',
                              style:
                                  home.currenttab == 0
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                            Badge(
                              backgroundColor: CleanerAppcolors.primarypurple,
                              label:home.loadingbinbooking == true?LoadingAnimationWidget.fallingDot(color:CleanerAppcolors.primaryWhitecolor , size: 15.r): Text(home.binbook?.data.siteRequests.length.toString()??'0',style: badgefont,),
                            )
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
                  home.toggleTab(home.currenttab = 1);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient:
                          home.currenttab == 1
                              ? LinearGradient(
                                colors: [
                              const Color.fromARGB(255, 76, 78, 231),
                      const Color.fromARGB(255, 92, 94, 218)
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
                            home.currenttab == 1
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Pickup',
                              style:
                                  home.currenttab == 1
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                            Badge(
                              backgroundColor: CleanerAppcolors.primarypurple,
                              label:home.loadingbinbooking == true?LoadingAnimationWidget.fallingDot(color:CleanerAppcolors.primaryWhitecolor , size: 15.r): Text(home.binbook?.data.warehouseRequests.length.toString()??'0',style: badgefont,),
                            )
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


