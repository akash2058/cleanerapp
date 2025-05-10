import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orders_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/my_orders_drop_off_details_screen.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersDropOffList extends StatefulWidget {
  const MyOrdersDropOffList({super.key});

  @override
  State<MyOrdersDropOffList> createState() => _MyOrdersDropOffListState();
}

class _MyOrdersDropOffListState extends State<MyOrdersDropOffList> {
  // void getData() async {
  //   final logindata = Provider.of<LoginProvider>(context, listen: false);
  //   await logindata.loadLoginData();
  //   final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
  //   await myordersdata.getMyordersData(logindata.userid);
  //   final binrequestdata = Provider.of<BinRequestProvider>(
  //     context,
  //     listen: false,
  //   );
  //   await binrequestdata.getBinRequestData();

  //   print('userid${logindata.userid}');
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        return order.order?.data?.warehouseOrder?.isEmpty ?? true
            ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 250.r),
                child: Column(
                  children: [
                    Image.asset(AppIcons.closedd, height: 70.r),
                    Text('No DropOff Order Found', style: resendfont),
                  ],
                ),
              ),
            )
            : Consumer<LoginProvider>(
              builder: (context, log, child) {
                return order.loadingupdatewarehouse == true
                    ? LoadingAnimationWidget.hexagonDots(
                      color: CleanerAppcolors.primarypurple,
                      size: 45.r,
                    )
                    : Column(
                      spacing: 15.r,
                      children: List.generate(
                        order.order?.data?.warehouseOrder?.length ?? 0,
                        (index) {
                          var waredata =
                              order.order?.data?.warehouseOrder?[index];

                          return MyOrdersCard(
                            onPressed: () {
                              if (waredata?.stage == 'picked_up_from_site' &&
                                  waredata?.type == 'warehouse_dropoff') {
                                order.getConfirmwarehouseupdate(
                                  context,
                                  log.userid,
                                  waredata?.id.toString() ?? '',
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: MyOrdersDropOffDetailsScreen(
                                      payementtype: waredata?.paymentType??'',
                                      quantity: waredata?.quantity ?? 0,
                                      customerName:
                                          waredata?.customerName ?? '',
                                      startdate: waredata?.startDate ?? '',
                                      endate: waredata?.startDate ?? '',
                                      location: waredata?.location ?? '',
                                      duration:
                                          waredata?.orderDuration.toString() ??
                                          '',
                                      binsizename: waredata?.binSizeName ?? '',
                                      bookingid: waredata?.id.toString() ?? '', pendingamount: waredata?.pendingAmount??'', paymentoption: waredata?.paymentOption??'', paymentreceived: waredata?.paymentReceived??'',
                                    ),
                                  ),
                                );
                              }
                            },
                            address: waredata?.location ?? '',
                            quantity: waredata?.quantity.toString() ?? '',
                            startdate: waredata?.startDate ?? '',
                            endDate: waredata?.endDate ?? '',
                            binsizename: waredata?.binSizeName ?? '',
                            buttonlabel:
                                waredata?.stage == 'picked_up_from_site' &&
                                        waredata?.type == 'warehouse_dropoff'
                                    ? 'Confirm Delivery'
                                    : 'View',
                            stage: waredata?.stage??'', orderoverdue: waredata?.orderOverdue?.toInt()??0,
                          );
                        },
                      ),
                    );
              },
            );
      },
    );
  }
}
