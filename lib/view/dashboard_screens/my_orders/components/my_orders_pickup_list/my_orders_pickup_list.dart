import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/field_bottom_sheet/field_bottom_sheet.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orders_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/my_orders_pickup_details_screen.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersPickUpList extends StatefulWidget {
  const MyOrdersPickUpList({super.key});

  @override
  State<MyOrdersPickUpList> createState() => _MyOrdersPickUpListState();
}

class _MyOrdersPickUpListState extends State<MyOrdersPickUpList> {
  void getData(context) async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    await logindata.loadLoginData();
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    await myordersdata.getMyordersData(logindata.userid);
    final binrequestdata = Provider.of<BinRequestProvider>(
      context,
      listen: false,
    );
    await binrequestdata.getBinRequestData();

    print('userid${logindata.userid}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        final siteRequests = order.order?.data?.siteOrder ?? [];
        
        if (siteRequests.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 250.r),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(AppIcons.closedd, height: 70.r),
                    Text('No Pick Up Request Found', style: resendfont),
                  ],
                ),
              ),
            ),
          );
        }

        return Consumer<LoginProvider>(
          builder: (context, log, child) {
            return order.loadingconfirmonsitepickup == true
                ? Padding(
                  padding:  EdgeInsets.symmetric(vertical: 250).r,
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: CleanerAppcolors.primarypurple,
                      size: 45.r,
                    ),
                  ),
                )
                : Column(
                  spacing: 15.r,
                  children: List.generate(siteRequests.length, (index) {
                    var sitedata = siteRequests[index];
                    return MyOrdersCard(
                      onPressed: () {
                        if (sitedata.stage == 'order_picked_up' &&
                            sitedata.type == 'on_site_order') {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder:
                                (context) => FieldBottomSheet(
                                  customername: sitedata.customerName ?? '',
                                  pendingamount: sitedata.pendingAmount ?? '',
                                  paymentoption: sitedata.paymentOption ?? '',
                                  paymentreceived:
                                      sitedata.paymentReceived ?? '',
                                  binbookingid: sitedata.id.toString(),
                                  logid: log.userid, customeraddress: sitedata.location??'', customercontact:sitedata.customerContact??'',
                                ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: MyOrdersPickupDetailsScreen(
                                payementtype: sitedata.paymentType,
                                binsizename: sitedata.binSizeName ?? '',
                                duration: sitedata.orderDuration.toString(),
                                customername: sitedata.customerName ?? '',
                                startDate: sitedata.startDate ?? '',
                                endate: sitedata.endDate ?? '',
                                quantity: sitedata.quantity?.toInt() ?? 0,
                                location: sitedata.location ?? '',
                                bookingid: sitedata.id.toString(),
                                pendingamount: sitedata.pendingAmount ?? '',
                                paymentoption: sitedata.paymentOption ?? '',
                                paymentreceived: sitedata.paymentReceived ?? '', companyname: sitedata.customerCompany??'N/A', comment: sitedata.comment??'N/A', customercontact: sitedata.customerContact??'N/A',
                              ),
                            ),
                          );
                        }
                      },
                      address: sitedata.location ?? '',
                      quantity: sitedata.quantity.toString(),
                      startdate: sitedata.startDate ?? '',
                      endDate: sitedata.endDate ?? '',
                      binsizename: sitedata.binSizeName ?? '',
                      buttonlabel:
                          sitedata.stage == 'order_picked_up' &&
                                  sitedata.type == 'on_site_order'
                              ? order.loadingconfirmonsitepickup == true
                                  ? 'Please Wait'
                                  : 'Confirm Delivery'
                              : 'View',
                      stage: '', orderoverdue: sitedata.orderOverdue?.toInt()??0,
                    );
                  }),
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
            .map((word) {
              String lowerWord = word.toLowerCase();

              // If it's exactly 2 letters, make both uppercase
              if (lowerWord.length == 2 && RegExp(r'^[a-zA-Z]{2}$').hasMatch(lowerWord)) {
                return lowerWord.toUpperCase();
              }

              // If contains slash like a/a, capitalize both parts
              if (word.contains('/')) {
                return word
                    .split('/')
                    .map((w) => w.isNotEmpty
                        ? w[0].toUpperCase() + w.substring(1).toLowerCase()
                        : '')
                    .join('/');
              }

              // Default capitalization
              return word[0].toUpperCase() + word.substring(1).toLowerCase();
            })
            .join(' ');
      })
      .join(', ');
}