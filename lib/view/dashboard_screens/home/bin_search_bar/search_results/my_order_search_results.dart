import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/search_tabs/my_order_search_tab.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/field_bottom_sheet/field_bottom_sheet.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orders_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/my_orders_drop_off_details_screen.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/my_orders_pickup_details_screen.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:provider/provider.dart';
class MyOrdersSearchResults extends StatelessWidget {
  const MyOrdersSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, MyOrderProvider>(
      builder: (context, log, myorder, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          child:
              myorder.loadingmyorderdata
                  ? LoadingAnimationWidget.hexagonDots(
                    color: CleanerAppcolors.primarypurple,
                    size: 40.r,
                  )
                  : Column(
                    spacing: 10.r,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CleanerTextfield(
                        controller: myorder.ordersearch,
                        fillColor: CleanerAppcolors.primaryWhitecolor,
                        hintlabel: 'Search My orders',
                        prefix: Icon(Icons.search_outlined),
                        onChanged: (value) {
                          final currentType =
                              myorder.myordersearch == 0
                                  ? 'on_site_order'
                                  : 'warehouse_dropoff';
                          myorder.setFilterType(currentType, query: value);
                        },
                      ),
                      SizedBox(width: 10.r),
                      Text(
                        'Search using location and bin size name',
                        style: dashboardlabelfontblack,
                      ),
                      MyOrderSearchTabs(),
                      Expanded(
                        child:
                            myorder.ordersearch.text.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.type_specimen_outlined,
                                        size: 40.r,
                                      ),
                                      Text(
                                        myorder.selectedType == null
                                            ? 'Start typing to search'
                                            : 'Start typing to search ${myorder.selectedType == 'on_site_order' ? 'DropOff' : 'Pickup'} requests...',
                                        style: resendfont,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                                : myorder.filteredOrders.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppIcons.closedd,
                                        height: 70.r,
                                      ),
                                      Text(
                                        'No suggestions found',
                                        style: resendfont,
                                      ),
                                    ],
                                  ),
                                )
                                : SingleChildScrollView(
                                  child: Column(
                                    spacing: 20.r,
                                    children: List.generate(myorder.filteredOrders.length, (
                                      index,
                                    ) {
                                      final item =
                                          myorder.filteredOrders[index];
                                      if (myorder.myordersearch == 0) {
                                        return MyOrdersCard(
                                          onPressed: () {
                                            if (item.stage ==
                                                    'order_picked_up' &&
                                                item.type == 'on_site_order') {
                                              showModalBottomSheet(
                                                showDragHandle: true,
                                                context: context,
                                                builder:
                                                    (
                                                      context,
                                                    ) => FieldBottomSheet(
                                                      customername:
                                                          item.customerName ??
                                                          '',
                                                      pendingamount:
                                                          item.pendingAmount ??
                                                          '',
                                                      paymentoption:
                                                          item.paymentOption ??
                                                          '',
                                                      paymentreceived:
                                                          item.paymentReceived ??
                                                          '',
                                                      binbookingid:
                                                          item.id.toString(),
                                                      logid: log.userid, customeraddress: item.location??'', customercontact: item.customerContact??'',
                                                    ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                CustomPageRoute(
                                                  child: MyOrdersPickupDetailsScreen(
                                                    payementtype:
                                                        item.paymentType,
                                                    binsizename:
                                                        item.binSizeName ?? '',
                                                    duration:
                                                        item.orderDuration
                                                            .toString(),
                                                    customername:
                                                        item.customerName ?? '',
                                                    startDate:
                                                        item.startDate ?? '',
                                                    endate: item.endDate ?? '',
                                                    quantity:
                                                        item.quantity
                                                            ?.toInt() ??
                                                        0,
                                                    location:
                                                        item.location ?? '',
                                                    bookingid:
                                                        item.id.toString(),
                                                    pendingamount:
                                                        item.pendingAmount ??
                                                        '',
                                                    paymentoption:
                                                        item.paymentOption ??
                                                        '',
                                                    paymentreceived:
                                                        item.paymentReceived ??
                                                        '', companyname: item.customerCompany??'', comment: item.comment??'', customercontact: item.customerContact??'',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          address: item.location ?? '',
                                          quantity: item.quantity.toString(),
                                          startdate: item.startDate ?? '',
                                          endDate: item.endDate ?? '',
                                          binsizename: item.binSizeName ?? '',
                                          buttonlabel:
                                              item.stage == 'order_picked_up' &&
                                                      item.type ==
                                                          'on_site_order'
                                                  ? myorder.loadingconfirmonsitepickup ==
                                                          true
                                                      ? 'Please Wait'
                                                      : 'Confirm Delivery'
                                                  : 'View',
                                          stage: '',
                                          orderoverdue:
                                              item.orderOverdue?.toInt() ?? 0,
                                        );
                                      } else {
                                        return MyOrdersCard(
                                          onPressed: () {
                                            if (item.stage ==
                                                    'picked_up_from_site' &&
                                                item.type ==
                                                    'warehouse_dropoff') {
                                              myorder.getConfirmwarehouseupdate(
                                                context,
                                                log.userid,
                                                item.id.toString(),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                CustomPageRoute(
                                                  child: MyOrdersDropOffDetailsScreen(
                                                    payementtype:
                                                        item.paymentType ?? '',
                                                    quantity:
                                                        item.quantity ?? 0,
                                                    customerName:
                                                        item.customerName ?? '',
                                                    startdate:
                                                        item.startDate ?? '',
                                                    endate:
                                                        item.startDate ?? '',
                                                    location:
                                                        item.location ?? '',
                                                    duration:
                                                        item.orderDuration
                                                            .toString(),
                                                    binsizename:
                                                        item.binSizeName ?? '',
                                                    bookingid:
                                                        item.id.toString(),
                                                    pendingamount:
                                                        item.pendingAmount ??
                                                        '',
                                                    paymentoption:
                                                        item.paymentOption ??
                                                        '',
                                                    paymentreceived:
                                                        item.paymentReceived ??
                                                        '',
                                                    remainingamount:
                                                        item.remainingAmount
                                                            .toString(), companyname: item.customerCompany??'', comment: item.comment??'', customercontact: item.customerContact??'',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          address: item.location ?? '',
                                          quantity: item.quantity.toString(),
                                          startdate: item.startDate ?? '',
                                          endDate: item.endDate ?? '',
                                          binsizename: item.binSizeName ?? '',
                                          buttonlabel:
                                              item.stage ==
                                                          'picked_up_from_site' &&
                                                      item.type ==
                                                          'warehouse_dropoff'
                                                  ? 'Confirm Delivery'
                                                  : 'View',
                                          stage: item.stage ?? '',
                                          orderoverdue:
                                              item.orderOverdue?.toInt() ?? 0,
                                        );
                                      }
                                    }),
                                  ),
                                ),
                      ),
                    ],
                  ),
        );
      },
    );
  }
}

