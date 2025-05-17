import 'package:binbookingapp/custom_widget/cleaner_textfield.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:binbookingapp/view/dashboard_screens/home/home_provider/home_provider.dart';
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
                        spacing: 10.r,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CleanerTextfield(
                              controller: provider.searchController,
                              fillColor: CleanerAppcolors.primaryWhitecolor,
                              hintlabel: 'Search',
                              prefix: Icon(Icons.search_outlined),
                              onChanged: (value) {
                                // If no type selected, default to DropOff
                              provider.filter(value);
                              },
                            ),
                            SizedBox(width: 10.r),
                            Text('Search using location and bin size name',style: dashboardlabelfontblack),
                            SearchTabs(),
                            SizedBox(height: 10.r),
                            Expanded(
                              child: provider.searchController.text.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.type_specimen_outlined, size: 40.r),
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


class SearchTabs extends StatelessWidget {
  const SearchTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider,BinRequestProvider>(builder: (context, home, binr, child) {
      return Row(
          spacing: 5.r,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  binr.togglesearchtab(binr.searchtab = 0);
                  binr.setFilterType('on_site_order',query: binr.searchController.text);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            105,
                            108,
                            255,
                            0.4,
                          ).withOpacity(0.5.r),
                          spreadRadius: 1.5.r,
                          blurRadius: 1.5.r,
                          offset: Offset(0, 0),
                        ),
                      ],
                      gradient:
                          binr.searchtab == 0
                              ? LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 76, 78, 231),
                                  const Color.fromARGB(255, 92, 94, 218),
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
                            binr.searchtab == 0
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dropoff',
                              style:
                                  binr.searchtab == 0
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                          Badge(
                            backgroundColor: CleanerAppcolors.primarypurple,
                            label:binr.loadingbinbooking == true?
                            LoadingAnimationWidget.fallingDot(color: CleanerAppcolors.primaryWhitecolor,size: 15.r):
                             Text(binr.filteredRequests.length.toString(),style: badgefont,),
                           )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  binr.togglesearchtab(binr.searchtab = 1);
                  binr.setFilterType('warehouse_dropoff',query: binr.searchController.text);
                },
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            105,
                            108,
                            255,
                            0.4,
                          ).withOpacity(0.5.r),
                          spreadRadius: 1.5.r,
                          blurRadius: 1.5.r,
                          offset: Offset(0, 0),
                        ),
                      ],
                      gradient:
                          binr.searchtab == 1
                              ? LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 76, 78, 231),
                                  const Color.fromARGB(255, 92, 94, 218),
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
                            binr.searchtab == 1
                                ? Colors.transparent
                                : CleanerAppcolors.primaryminidarkgreycolor,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 35).r,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Pickup',
                              style:
                                  binr.searchtab == 1
                                      ? resendwhitefont
                                      : resendfontminigrey,
                            ),
                             Badge(
                            backgroundColor: CleanerAppcolors.primarypurple,
                            label: binr.loadingbinbooking == true?
                            LoadingAnimationWidget.fallingDot(color: CleanerAppcolors.primaryWhitecolor,size: 15.r):Text(binr.filteredRequests.length.toString(),style: badgefont,),
                           )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
    },);
  }
}


  // itemCount:
  //                                             provider.filteredRequests.length,
  //                                         itemBuilder: (context, index) {
  //                                           final item =
  //                                               provider.filteredRequests[index];