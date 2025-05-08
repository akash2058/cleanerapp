import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';

class IsDamagedDetailpage extends StatelessWidget {
  final String customername;
  final String duration;
  final String binsizename;
  final String quantity;
  final String location;
  final String driverid;
  final String bookingid;
  const IsDamagedDetailpage({super.key, required this.customername, required this.duration, required this.binsizename, required this.quantity, required this.location, required this.driverid, required this.bookingid});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryWhitecolor,
          bottomNavigationBar: BottomAppBar(
            color: CleanerAppcolors.primaryWhitecolor,
            height: 95.r,
            elevation: 0.r,
            child: CleanerButton.elevated(
              isloading: order.loadingbookingdamage,
              label: 'Update',
              backgroundcolor: CleanerAppcolors.primarypurple,
              onPressed: () {
                order.getbookingdamage(context, bookingid, driverid);
              },
            ),
          ),
          appBar: AppBar(
            backgroundColor: CleanerAppcolors.primaryWhitecolor,
            centerTitle: true,
            title: Text('IsDamagedDetail', style: appbartitlefont),
          ),
          body:order.loadingbookingdamage == true? LoadingAnimationWidget.hexagonDots(color: CleanerAppcolors.primarypurple, size: 40.r): Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 15).r,
            child: Column(
              spacing: 15.r,
              children: [
                DetailsCard(
                  customername: customername,
                  duration: duration,
                  binsizename: binsizename,
                  quantity: quantity,
                  location: location,
                ),
                SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: CleanerAppcolors.primaryminidarkgreycolor,
                              ),),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 10).r,
                      child: Column(
                        children: List.generate(
                          order.orderdetail?.bookingSerialNumbers?.length ?? 0,
                          (index) {
                             final serialdatta =
                              order.orderdetail?.bookingSerialNumbers?[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.format_list_numbered_outlined,
                                      size: 25.r,
                                    ),
                                    SizedBox(width: 8.r),
                                    Text(
                                      'SN#${serialdatta?.serialNumber ?? ''}',
                                      style: ordercardheaderfont,
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'Is Damaged',
                                      style: dashboardlabelfontblack,
                                    ),
                                    Checkbox(
                                      side: BorderSide(
                                        color:
                                            CleanerAppcolors
                                                .primaryminidarkgreycolor,
                                      ),
                                      activeColor: CleanerAppcolors.primarypurple,
                                      visualDensity: VisualDensity(
                                        horizontal: -4,
                                        vertical: -4,
                                      ),
                                      value: order.isDamagedList[index],
                                      onChanged: (value) {
                                        order.toggleCheckbox(index, value);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
