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

class DropOff extends StatelessWidget {
  const DropOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dash, child) {
        return Consumer<BinRequestProvider>(
          builder: (context, bindata, child) {
            return Consumer<LoginProvider>(
              builder: (context, log, child) {
                return bindata.loadingbinbooking == true
                    ? LoadingAnimationWidget.hexagonDots(
                      color: CleanerAppcolors.primarypurple,
                      size: 20.r,
                    )
                    : bindata.binbook?.data.warehouseRequests.isEmpty ?? true
                    ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 90.r),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(AppIcons.closedd, height: 70.r),
                            Text('No Pick Up Request Found', style: resendfont),
                          ],
                        ),
                      ),
                    )
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          (bindata.binbook?.data.warehouseRequests.length ??
                                      0) >
                                  6
                              ? 6
                              : (bindata
                                      .binbook
                                      ?.data
                                      .warehouseRequests
                                      .length ??
                                  0),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 15.r),
                      itemBuilder: (context, index) {
                        final waredata =
                            bindata.binbook?.data.warehouseRequests[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          ), // give space for shadow
                          child: BinRequestCard(
                            onPressed: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                builder: (context) {
                                  return BinBookingBottomSheet(
                                    customername: waredata?.customerName ?? '',
                                    location: waredata?.location ?? '',
                                    endDate: waredata?.endDate ?? '',
                                    type: waredata?.type ?? '',
                                    binsizeName: waredata?.binSizeName ?? '',
                                    bookingId: waredata?.id.toString() ?? '',
                                    userId: log.userid,
                                    usertoken: log.user?.data?.token ?? '',
                                  );
                                },
                              );
                            },
                            quantity: waredata?.quantity.toString() ?? '0',
                            address: waredata?.location ?? 'N/A',
                            startdate: waredata?.startDate ?? 'N/A',
                            binsizename: waredata?.binSizeName ?? 'N/A',
                            duration: waredata?.orderDuration.toString() ?? '',
                          ),
                        );
                      },
                    );
              },
            );
          },
        );
      },
    );
  }
}
