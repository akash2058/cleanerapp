import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BinRequestPickupList extends StatelessWidget {
  const BinRequestPickupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BinRequestProvider, LoginProvider>(
      builder: (context, binr, log, child) {
        return (binr.binbook?.data.warehouseRequests.isEmpty ?? true)
            ? Padding(
              padding: EdgeInsets.symmetric(vertical: 250.r),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(AppIcons.closedd, height: 70.r),
                    Text('No Pick Up Request Found', style: resendfont),
                  ],
                ),
              ),
            )
            : Column(
              spacing: 15.r,
              children: List.generate(
                binr.binbook?.data.warehouseRequests.length ?? 0,
                (index) {
                  final waredata = binr.binbook?.data.warehouseRequests[index];
                  return BinRequestCard(
                    onPressed: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return BinBookingBottomSheet(
                            customername: waredata?.customerName ?? 'N/A',
                            location: waredata?.location ?? 'N/A',
                            endDate: waredata?.endDate ?? 'N/A',
                            type: waredata?.type ?? 'N/A',
                            binsizeName: waredata?.binSizeName ?? 'N/A',
                            bookingId: waredata?.id.toString() ?? 'N/A',
                            userId:
                                log.user?.data?.user?.id.toString() ?? 'N/A',
                            startdate: waredata?.startDate ?? 'N/A',
                            contactnumber: waredata?.customerContact ?? 'N/A',
                            companyname: waredata?.customerCompany??'N/A',
                            comment: waredata?.comment??'N/A',
                          );
                        },
                      );
                    },
                    address: waredata?.location ?? 'N/A',
                    quantity: waredata?.quantity.toString() ?? '0',
                    startdate: waredata?.startDate ?? 'N/A',
                    duration: waredata?.orderDuration.toString() ?? 'N/A',
                    binsizename: waredata?.binSizeName ?? 'N/A',
                    requestoverdue: waredata?.requestOverdue?.toInt() ?? 0,
                  );
                },
              ),
            );
      },
    );
  }
}
