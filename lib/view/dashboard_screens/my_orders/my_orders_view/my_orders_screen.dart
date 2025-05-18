import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orderes_drop_off_list/my_orders_dropoff_list.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orders_pickup_list/my_orders_pickup_list.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/profile/components/my_order_tabs/my_orders_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Future<void> refestdata() async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    await logindata.loadLoginData();
    await myordersdata.getMyordersData(logindata.userid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, orders, child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('My Orders', style: appbartitlefont),
            backgroundColor: CleanerAppcolors.primaryminigreycolor,
          ),
          backgroundColor: CleanerAppcolors.primaryminigreycolor,

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
            child: RefreshIndicator(
              onRefresh: refestdata,
              child:
                  orders.loadingmyorderdata == true
                      ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 250).r,
                        child: Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: CleanerAppcolors.primarypurple,
                            size: 45.r,
                          ),
                        ),
                      )
                      : Column(
                        spacing: 20.r,
                        children: [
                          MyOrdersTabs(),
                          Expanded(
                            child: ListView(
                              children: [
                                if (orders.tabs == 0) MyOrdersPickUpList(),

                                if (orders.tabs == 1) MyOrdersDropOffList(),
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
  }
}
