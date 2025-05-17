import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_card.dart';
import 'package:binbookingapp/view/dashboard_screens/home/components/bin_booking_bottom_sheet/bin_booking_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BinRequestDropoffList extends StatelessWidget {
  const BinRequestDropoffList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BinRequestProvider, LoginProvider>(
      builder: (context, binr, log, child) {
        return (binr.binbook?.data.siteRequests.isEmpty ?? true)
            ? Padding(
              padding: EdgeInsets.symmetric(vertical: 250).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.closedd, height: 70.r),
                  Text('No Drop off Request Found', style: resendfont),
                ],
              ),
            )
            : Column(
              spacing: 15.r,
              children: List.generate(
                binr.binbook?.data.siteRequests.length ?? 0,
                (index) {
                  var bindata = binr.binbook?.data.siteRequests[index];
                  return BinRequestCard(
                    onPressed: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return BinBookingBottomSheet(
                            customername: bindata?.customerName ?? '',
                            location: bindata?.location ?? '',
                            endDate: bindata?.endDate ?? '',
                            type: bindata?.type ?? '',
                            binsizeName: bindata?.binSizeName ?? '',
                            bookingId: bindata?.id.toString() ?? '',
                            userId: log.user?.data?.user?.id.toString() ?? '',
                            startdate: bindata?.startDate ?? '',
                          );
                        },
                      );
                    },
                    address: bindata?.location ?? 'N/A',
                    quantity: bindata?.quantity.toString() ?? '0',
                    startdate: bindata?.startDate ?? '',
                    duration: bindata?.orderDuration.toString() ?? '0',
                    binsizename: bindata?.binSizeName ?? 'N/A',
                    requestoverdue: bindata?.requestOverdue?.toInt() ?? 0,
                  );
                },
              ),
            );
      },
    );
  }
}
