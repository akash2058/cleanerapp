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
                    ? Padding(
                      padding:  EdgeInsets.symmetric(vertical: 150).r,
                      child: LoadingAnimationWidget.hexagonDots(
                        color: CleanerAppcolors.primarypurple,
                        size: 40.r,
                      ),
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
                   :Column(
                    spacing: 15.r,
                    children: [
                      ...List.generate(
                        (bindata.binbook?.data.warehouseRequests.length ?? 0) > 6
                            ? 6
                            : (bindata.binbook?.data.warehouseRequests.length ?? 0),
                        (index) {
                          var data = bindata.binbook?.data.warehouseRequests[index];
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
                                    userId: log.userid, startdate: data?.startDate??'',
                                   
                                  );
                                },
                              );
                            },
                            address: data?.location ?? 'N/A',
                            quantity: data?.quantity.toString() ?? 'N/A',
                            startdate: data?.startDate ?? 'N/A',
                            duration: data?.orderDuration.toString() ?? 'N/A',
                            binsizename: data?.binSizeName ?? '', requestoverdue: data?.requestOverdue?.toInt()??0,
                          );
                        },
                      ),
                      if ((bindata.binbook?.data.warehouseRequests.length ?? 0) > 6)
                        GestureDetector(
                          onTap: () {
                            dash.screenTabs(dash.currenttab = 1);
                          },
                          child: Text('See all', style: seeallfont),
                        ),
                    ],
                  );
              },
            );
          },
        );
      },
    );
  }
}


  //  final waredata =
  //                           bindata.binbook?.data.warehouseRequests[index];
  //                       return BinRequestCard(
  //                         onPressed: () {
  //                           showModalBottomSheet(
  //                             showDragHandle: true,
  //                             context: context,
  //                             builder: (context) {
  //                               return BinBookingBottomSheet(
  //                                 customername: waredata?.customerName ?? '',
  //                                 location: waredata?.location ?? '',
  //                                 endDate: waredata?.endDate ?? '',
  //                                 type: waredata?.type ?? '',
  //                                 binsizeName: waredata?.binSizeName ?? '',
  //                                 bookingId: waredata?.id.toString() ?? '', userId: '',
                                 
  //                               );
  //                             },
  //                           );
  //                         },
  //                         quantity: waredata?.quantity.toString() ?? '0',
  //                         address: waredata?.location ?? 'N/A',
  //                         startdate: waredata?.startDate ?? 'N/A',
  //                         binsizename: waredata?.binSizeName ?? 'N/A',
  //                         duration: waredata?.orderDuration.toString() ?? '',
  //                       );