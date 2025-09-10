

import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/search_results/binrequest_search_results.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/search_results/my_order_search_results.dart';

import 'package:binbookingapp/view/dashboard_screens/my_orders/model/my_order_model.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/session_expire_dialog/session_expire_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class BinSearchScreen extends StatefulWidget {
  final BinBookingModel binmodel;
  final MyOrderModel myordermodel;

  const BinSearchScreen({
    super.key,
    required this.binmodel,
    required this.myordermodel,
  });

  @override
  State<BinSearchScreen> createState() => _BinSearchScreenState();
}

class _BinSearchScreenState extends State<BinSearchScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<BinRequestProvider>().init();
    context.read<MyOrderProvider>().init();
    return MultiProvider(
  providers: [
    ChangeNotifierProvider<BinRequestProvider>(
      create: (_) => BinRequestProvider()
        ..setRequests(
          widget.binmodel.data!.siteRequests,
          widget.binmodel.data!.warehouseRequests,
        ),
    ),
    ChangeNotifierProvider<MyOrderProvider>(
      create: (_) => MyOrderProvider()
        ..setOrders(
          widget.myordermodel.data?.siteOrder??[],
          widget.myordermodel.data?.warehouseOrder??[],
        ),
    ),
  ],
  child: Consumer3<LoginProvider, MyOrderProvider, BinRequestProvider>(
    builder: (context, log, myorders, provider, child) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                provider.setIsBinRequest(value == 'Bin Requests');
              },
              icon: Icon(Icons.swap_horizontal_circle,color: CleanerAppcolors.primarypurple),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Bin Requests',
                  child: Text('Bin Requests'),
                ),
                PopupMenuItem(
                  value: 'My Orders',
                  child: Text('My Orders'),
                ),
              ],
            ),
                        SizedBox(width: 20.r,),

          ],
          title: Text(
            provider.isBinRequest ? 'Search Requests' : 'Search Orders',
            style: appbartitlefont,
          ),
        ),
        body:SessionWrapper(child:  provider.isBinRequest
            ? MyRequestSearchResults()
            : MyOrdersSearchResults(),)
      );
    },
  ),
);
  }
}




 