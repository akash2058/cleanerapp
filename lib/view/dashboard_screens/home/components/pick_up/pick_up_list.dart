
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PickUp extends StatelessWidget {
  const PickUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dash, child) {
        return Consumer<LoginProvider>(builder: (context, log, child) {
          return Consumer<BinRequestProvider>(
            builder: (context, bindata, child) {
              if (bindata.loadingbinbooking == true) {
                return Center(
                  child: LoadingAnimationWidget.hexagonDots(
                      color: CleanerAppcolors.primarypurple, size: 20.r),
                );
              } else if ((bindata.binbook?.data.siteRequests.length ?? 0) == 0) {
                // If the data is empty, show "No data found"
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: 90.r),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(AppIcons.nodatafound,height: 70.r),
                        Text(
                          'No Pick Up Request Found',
                          style: resendfont,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  spacing: 15.r,
                  children: [
                    ...List.generate(
                      (bindata.binbook?.data.siteRequests.length ?? 0) > 6
                          ? 6
                          : (bindata.binbook?.data.siteRequests.length ?? 0),
                      (index) {
                        var data = bindata.binbook?.data.siteRequests[index];
                        return BinRequestCard(
                          onPressed: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              context: context,
                              builder: (context) {
                                return BinBookingBottomSheet(
                                  customername: data?.customerName ?? '',
                                  location: data?.location ?? '',
                                  endDate: data?.endDate ?? '',
                                  type: data?.type ?? '',
                                  binsizeName: data?.binSizeName ?? '',
                                  bookingId: data?.id.toString() ?? '',
                                  userId: log.userid,
                                  usertoken: log.user?.data?.token ?? '',
                                );
                              },
                            );
                          },
                          address: data?.location ?? 'N/A',
                          quantity: data?.quantity.toString() ?? 'N/A',
                          startdate: data?.startDate ?? 'N/A',
                          duration: data?.orderDuration.toString() ?? 'N/A',
                          binsizename: data?.binSizeName ?? '',
                        );
                      },
                    ),
                    if ((bindata.binbook?.data.siteRequests.length ?? 0) > 6)
                      GestureDetector(
                        onTap: () {
                          dash.screenTabs(dash.currenttab = 1);
                        },
                        child: Text(
                          'See all',
                          style: seeallfont,
                        ),
                      )
                  ],
                );
              }
            },
          );
        });
      },
    );
  }
}
