import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BinRequestProvider()
        ..setRequests(
          widget.model.data.siteRequests,
          widget.model.data.warehouseRequests,
        ),
      child: Consumer<LoginProvider>(
        builder: (context, log, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Search Requests', style: appbartitlefont),
            ),
            body: Consumer<BinRequestProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
                  child: provider.loadingbinbooking
                      ? LoadingAnimationWidget.hexagonDots(
                          color: CleanerAppcolors.primarypurple,
                          size: 40.r,
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CleanerTextfield(
                                    controller: searchController,
                                    fillColor: CleanerAppcolors.primaryWhitecolor,
                                    hintlabel: 'Search',
                                    prefix: Icon(Icons.search_outlined),
                                    onChanged: (value) {
                                      // If no type selected, default to DropOff
                                      if (provider.selectedType == null) {
                                        provider.setFilterType(
                                          'on_site_order',
                                          query: value.trim(),
                                        );
                                      } else {
                                        provider.filter(value.trim());
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.r),
                                CircleAvatar(
                                  backgroundColor: CleanerAppcolors.primarypurple,
                                  child: PopupMenuButton<String>(
                                    icon: Image.asset(
                                      AppIcons.equalizericon,
                                      height: 30.r,
                                      color: CleanerAppcolors.primaryWhitecolor,
                                    ),
                                    onSelected: (value) {
                                      provider.setFilterType(
                                        value,
                                        query: searchController.text,
                                      );
                                    },
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                        value: 'on_site_order',
                                        child: Text('DropOff'),
                                      ),
                                      PopupMenuItem(
                                        value: 'warehouse_dropoff',
                                        child: Text('Pick up'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.r),
                            Expanded(
                              child: searchController.text.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.type_specimen_outlined, size: 40.r),
                                          Text(
                                            provider.selectedType == null
                                                ? 'Start typing to search DropOff requests...'
                                                : 'Start typing to search ${provider.selectedType == 'on_site_order' ? 'DropOff' : 'Pickup'} requests...',
                                            style: resendfont,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  : provider.filteredRequests.isEmpty
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(AppIcons.closedd, height: 70.r),
                                              Text(
                                                'No suggestions found',
                                                style: resendfont,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.separated(
                                          itemCount: provider.filteredRequests.length,
                                          separatorBuilder: (_, __) => SizedBox(height: 10.r),
                                          itemBuilder: (context, index) {
                                            final item = provider.filteredRequests[index];
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
                                                      userId: log.userid,
                                                      startdate: item.startDate,
                                                    );
                                                  },
                                                );
                                              },
                                              address: item.location,
                                              quantity: item.quantity.toString(),
                                              startdate: item.startDate,
                                              binsizename: item.binSizeName,
                                              duration: item.orderDuration.toString(),
                                              requestoverdue: item.orderOverdue?.toInt() ?? 0,
                                            );
                                          },
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


  // itemCount:
  //                                             provider.filteredRequests.length,
  //                                         itemBuilder: (context, index) {
  //                                           final item =
  //                                               provider.filteredRequests[index];