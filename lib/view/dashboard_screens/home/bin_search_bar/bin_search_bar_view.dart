import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_tab/bin_request_tabs.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class BinSearchScreen extends StatefulWidget {
  final BinBookingModel model;

  const BinSearchScreen({super.key, required this.model});

  @override
  State<BinSearchScreen> createState() => _BinSearchScreenState();
}

class _BinSearchScreenState extends State<BinSearchScreen> {
   @override
     void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData(context);
    });
  }

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
    myordersdata.paymentreceivecontroller.clear();
    myordersdata.amountreceivecontroller.clear();

    print('userid${logindata.userid}');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) =>
              BinRequestProvider()..setRequests(
                widget.model.data.siteRequests,
                widget.model.data.warehouseRequests,
              ),
      child: Consumer<LoginProvider>(
        builder: (context, log, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Search Requests", style: appbartitlefont),
            ),
            body: Consumer<BinRequestProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
                  child: provider.loadingbinbooking == true? LoadingAnimationWidget.hexagonDots(
                    color: CleanerAppcolors.primarypurple,size: 40.r
                  ): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20.r,
                    children: [
                      Row(
                        spacing: 10.r,
                        children: [
                          Expanded(
                            child: CleanerTextfield(
                              fillColor: CleanerAppcolors.primaryWhitecolor,
                              hintlabel: 'Search',
                              prefix: Icon(Icons.search_outlined),
                            ),
                          ),
                          CircleAvatar(
                            child: Icon(Icons.equalizer_rounded),
                          )
                        ],
                      ),
                      Text('Based on location, binsize',style: dashboardlabelfontblack,),
                      Expanded(
                        child:
                            provider.filteredRequests.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppIcons.closedd,height: 70.r,),
                                      Text(
                                        'No suggestions found',
                                        style: resendfont
                                      ),
                                    ],
                                  ),
                                )
                                : Column(
                                  spacing: 20.r,
                                  children: [
                                    BinRequestTabs(),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: provider.filteredRequests.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              provider.filteredRequests[index];
                                          return BinRequestCard(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return BinBookingBottomSheet(
                                                    customername: item.customerName,
                                                    location: item.location,
                                                    endDate: item.endDate,
                                                    type: item.type,
                                                    binsizeName: item.binSizeName,
                                                    bookingId: item.id.toString(),
                                                    userId: log.userid, startdate: item.startDate,
                                                  );
                                                },
                                              );
                                            },
                                            address: item.location,
                                            quantity: item.quantity.toString(),
                                            startdate: item.startDate,
                                            binsizename: item.binSizeName,
                                            duration: item.orderDuration.toString(), requestoverdue: item.requestOverdue?.toInt()??0,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
