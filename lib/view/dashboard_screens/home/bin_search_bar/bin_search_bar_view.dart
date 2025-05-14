import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_tab/bin_request_tabs.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/bin_search_provider.dart';
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
  final ScrollController _scrollController = ScrollController();

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
    await myordersdata.getMyordersData(logindata.userid);
    await binrequestdata.getBinRequestData();
    myordersdata.paymentreceivecontroller.clear();
    myordersdata.amountreceivecontroller.clear();

    print('userid${logindata.userid}');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider(
      create:
          (_) =>
              SearchDataProvider()..updateData(
                binRequests: widget.model.data.siteRequests,
                myOrders: widget.model.data.warehouseRequests,
                source: SearchDataSource.binRequests,
              ),
      child: Consumer<LoginProvider>(
        builder: (context, log, child) {
          return Consumer<SearchDataProvider>(
            builder: (context, srch, child) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Search Requests", style: appbartitlefont),
                ),
                body: Consumer<BinRequestProvider>(
                  builder: (context, provider, _) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
                      child:
                          provider.loadingbinbooking == true
                              ? LoadingAnimationWidget.hexagonDots(
                                color: CleanerAppcolors.primarypurple,
                                size: 40.r,
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20.r,
                                children: [
                                  Row(
                                    spacing: 10.r,
                                    children: [
                                      Expanded(
                                        child: CleanerTextfield(
                                          controller: searchController,
                                          fillColor:
                                              CleanerAppcolors
                                                  .primaryWhitecolor,
                                          hintlabel: 'Search',
                                          prefix: Icon(Icons.search_outlined),
                                          onChanged: (value) {
                                            Provider.of<SearchDataProvider>(
                                              context,
                                              listen: false,
                                            ).filter(value);
                                          },
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        onSelected: (String value) {
                                          final provider =
                                              Provider.of<SearchDataProvider>(
                                                context,
                                                listen: false,
                                              );
                                          if (value == 'BinRequests') {
                                            provider.updateData(
                                              binRequests:
                                                  widget
                                                      .model
                                                      .data
                                                      .siteRequests,
                                              myOrders:
                                                  widget
                                                      .model
                                                      .data
                                                      .warehouseRequests,
                                              source:
                                                  SearchDataSource.binRequests,
                                            );
                                          } else {
                                            provider.updateData(
                                              binRequests:
                                                  widget
                                                      .model
                                                      .data
                                                      .siteRequests,
                                              myOrders:
                                                  widget
                                                      .model
                                                      .data
                                                      .warehouseRequests,
                                              source: SearchDataSource.myOrders,
                                            );
                                          }
                                          provider.filter(
                                            searchController.text,
                                          ); // Re-apply filter
                                        },

                                        itemBuilder:
                                            (BuildContext context) => [
                                              PopupMenuItem(
                                                value: 'BinRequests',
                                                child: Text('Bin Requests'),
                                              ),
                                              PopupMenuItem(
                                                value: 'MyOrders',
                                                child: Text('My Orders'),
                                              ),
                                            ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Based on location, binsize',
                                    style: dashboardlabelfontblack,
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 20.r,
                                      children: [
                                        SearchTabs(),
                                        Expanded(
                                          child: ListView.builder(
                                            controller: _scrollController,
                                            itemCount:
                                                srch.filteredRequests.isEmpty
                                                    ? 0
                                                    : srch
                                                        .filteredRequests
                                                        .length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  srch.filteredRequests[index];
                                              return BinRequestCard(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return BinBookingBottomSheet(
                                                        customername:
                                                            item.customerName,
                                                        location: item.location,
                                                        endDate: item.endDate,
                                                        type: item.type,
                                                        binsizeName:
                                                            item.binSizeName,
                                                        bookingId:
                                                            item.id.toString(),
                                                        userId: log.userid,
                                                        startdate:
                                                            item.startDate,
                                                      );
                                                    },
                                                  );
                                                },
                                                address: item.location,
                                                quantity:
                                                    item.quantity.toString(),
                                                startdate: item.startDate,
                                                binsizename: item.binSizeName,
                                                duration:
                                                    item.orderDuration
                                                        .toString(),
                                                requestoverdue:
                                                    item.requestOverdue
                                                        ?.toInt() ??
                                                    0,
                                              );
                                            },
                                          ),
                                        ),
                                        // Reset Button Section
                                        if (searchController.text.isNotEmpty)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton.icon(
                                              onPressed: () {
                                                searchController.clear();
                                                srch.filter(''); // Reset filter
                                                _scrollController.animateTo(
                                                  0.0,
                                                  duration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeOut,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.refresh,
                                                color:
                                                    CleanerAppcolors
                                                        .primarypurple,
                                              ),
                                              label: Text(
                                                "Reset Search",
                                                style: TextStyle(
                                                  color:
                                                      CleanerAppcolors
                                                          .primarypurple,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
          );
        },
      ),
    );
  }
}

class SearchTabs extends StatelessWidget {
  const SearchTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchDataProvider>(
      builder: (context, home, child) {
        final siteCount =
            home.filteredRequests
                .where((e) => e.type.toLowerCase() == 'dropoff')
                .length;

        final warehouseCount =
            home.filteredRequests
                .where((e) => e.type.toLowerCase() == 'pickup')
                .length;

        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  home.toggleTab(0);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient:
                        home.searchtab == 0
                            ? LinearGradient(
                              colors: [
                                Color.fromARGB(255, 76, 78, 231),
                                Color.fromARGB(255, 92, 94, 218),
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
                          home.searchtab == 0
                              ? Colors.transparent
                              : CleanerAppcolors.primaryminidarkgreycolor,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 35).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Dropoff',
                          style:
                              home.searchtab == 0
                                  ? resendwhitefont
                                  : resendfontminigrey,
                        ),
                        Badge(
                          label: Text(siteCount.toString(), style: badgefont),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  home.toggleTab(1);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient:
                        home.searchtab == 1
                            ? LinearGradient(
                              colors: [
                                Color.fromARGB(255, 76, 78, 231),
                                Color.fromARGB(255, 92, 94, 218),
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
                          home.searchtab == 1
                              ? Colors.transparent
                              : CleanerAppcolors.primaryminidarkgreycolor,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 35).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Pickup',
                          style:
                              home.searchtab == 1
                                  ? resendwhitefont
                                  : resendfontminigrey,
                        ),
                        Badge(
                          label: Text(
                            warehouseCount.toString(),
                            style: badgefont,
                          ),
                        ),
                      ],
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
