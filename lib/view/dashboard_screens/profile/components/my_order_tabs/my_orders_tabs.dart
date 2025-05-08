import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart'
    show MyOrderProvider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/appcolors.dart';

class MyOrdersTabs extends StatelessWidget {
  const MyOrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, myorder, child) {
        return Row(
          spacing: 5.r,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  myorder.toggleTab(myorder.tabs = 0);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient:
                          myorder.tabs == 0
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
                            myorder.tabs == 0
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13).r,
                      child: Center(
                        child: Text(
                          'Dropoff',
                          style:
                              myorder.tabs == 0
                                  ? resendwhitefont
                                  : resendfontminigrey,
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
                  myorder.toggleTab(myorder.tabs = 1);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient:
                          myorder.tabs == 1
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
                            myorder.tabs == 1
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13).r,
                      child: Center(
                        child: Text(
                          'Pickup',
                          style:
                              myorder.tabs == 1
                                  ? resendwhitefont
                                  : resendfontminigrey,
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
