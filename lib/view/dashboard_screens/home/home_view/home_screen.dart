import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/bin_search_bar_view.dart' show BinSearchScreen;

import 'package:binbookingapp/view/dashboard_screens/home/components/cleaner_app_drawer/cleaner_app_drawer.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/drop_off/drop_off_list.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/greetings_card.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/home_tabs/home_tabs.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/pick_up/pick_up_list.dart';
import 'package:binbookingapp/view/dashboard_screens/home/home_provider/home_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> getData() async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    await myordersdata.getMyordersData(
      logindata.user?.data?.user?.id.toString()?? '',
     
    );
    final binrequestdata = Provider.of<BinRequestProvider>(
      context,
      listen: false,
    );
    await binrequestdata.getBinRequestData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, home, child) {
        return Consumer<BinRequestProvider>(
          builder: (context, binr, child) {
            return Consumer<LoginProvider>(
              builder: (context, log, child) {
                return Consumer<DashboardProvider>(builder: (context, dash, child) {
                  return Scaffold(
                  drawer: CleanerAppDrawer(),
                  appBar: AppBar(
                    scrolledUnderElevation: 0,
                    actions: [
                      Builder(
                        builder:
                            (context) => GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    CleanerAppcolors.primaryminidarkgreycolor,
                                radius: 20.r,
                                child: CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.menu,
                                    size: 22.r,
                                    color: CleanerAppcolors.primarygreycolor,
                                  ),
                                ),
                              ),
                            ),
                      ),
                      SizedBox(width: 12.r),
                    ],
                    backgroundColor: CleanerAppcolors.primaryminigreycolor,
                    automaticallyImplyLeading: false,
                  ),
                  backgroundColor: CleanerAppcolors.primaryminigreycolor,
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 23, vertical: 10).r,
                    child: RefreshIndicator(
                      onRefresh: getData,
                      child: ListView(
                        children: [
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15.r,
                        children: [
                          CleanerTextfield(
                            fillColor: CleanerAppcolors.primaryWhitecolor,
                            onTap: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  child: BinSearchScreen(
                                    model: BinBookingModel(
                                      status: binr.binbook?.status ?? '',
                                      message: binr.binbook?.message ?? '',
                                      data: BinRequestData(
                                        siteRequests:
                                            binr.binbook!.data.siteRequests,
                                        warehouseRequests:
                                            binr
                                                .binbook!
                                                .data
                                                .warehouseRequests,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            prefix: Icon(Icons.search),
                            hintlabel: 'Search',
                          ),
                          GreetingsCard(),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Active Orders',
                                style: greetingsStyleblack,
                              ),
                              GestureDetector(
                                onTap: () {
                                  dash.screenTabs(dash.currenttab =1);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'View more',
                                      style: dashboardlabelfontdarkgrey,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 30.r,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          HomeTabs(),
                          
                          if (home.tabs == 0) PickUp(),
                          if (home.tabs == 1) DropOff(),
                        ],
                      ),
                        ],
                      )
                    ),
                  ),
                );
                },);
              },
            );
          },
        );
      },
    );
  }
}
