import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/search_tabs/bin_request_search_tab.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
import 'package:provider/provider.dart';

class MyRequestSearchResults extends StatelessWidget {
  const MyRequestSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, BinRequestProvider>(
      builder: (context, log, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          child:
              provider.loadingbinbooking
                  ? LoadingAnimationWidget.hexagonDots(
                    color: CleanerAppcolors.primarypurple,
                    size: 40.r,
                  )
                  : Column(
                    spacing: 10.r,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CleanerTextfield(
                        controller: provider.searchController,
                        fillColor: CleanerAppcolors.primaryWhitecolor,
                        hintlabel: 'Search Requests',
                        prefix: Icon(Icons.search_outlined),
                        onChanged: (value) {
                          final currentType =
                              provider.searchtab == 0
                                  ? 'on_site_order'
                                  : 'warehouse_dropoff';
                          provider.setFilterType(currentType, query: value);
                        },
                      ),
                      SizedBox(width: 10.r),
                      Text(
                        'Search using location and bin size name',
                        style: dashboardlabelfontblack,
                      ),
                      RequestSearchTabs(),
                      Expanded(
                        child:
                            provider.searchController.text.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.type_specimen_outlined,
                                        size: 40.r,
                                      ),
                                      Text(
                                        provider.selectedType == null
                                            ? 'Start typing to search'
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
                                    children: List.generate(
                                      provider.filteredRequests.length,
                                      (index) {
                                        final item =
                                            provider.filteredRequests[index];
                                        return BinRequestCard(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                                          showDragHandle: true,

                                              context: context,
                                              builder: (context) {
                                                return BinBookingBottomSheet(
                                                  customername:
                                                      item.customerName,
                                                  location: item.location,
                                                  endDate: item.endDate,
                                                  type: item.type,
                                                  binsizeName: item.binSizeName,
                                                  bookingId: item.id.toString(),
                                                  userId: log.userid,
                                                  startdate: item.startDate, contactnumber: item.customerContact, companyname: item.customerCompany??'', comment: item.comment??'',
                                                );
                                              },
                                            );
                                          },
                                          address: item.location,
                                          quantity: item.quantity.toString(),
                                          startdate: item.startDate,
                                          binsizename: item.binSizeName,
                                          duration:
                                              item.orderDuration.toString(),
                                          requestoverdue:
                                              item.orderOverdue?.toInt() ?? 0,
                                        );
                                      },
                                    ),
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