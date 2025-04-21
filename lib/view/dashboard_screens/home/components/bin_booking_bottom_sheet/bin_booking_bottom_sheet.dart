import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BinBookingBottomSheet extends StatelessWidget {
  final String customername;
  final String location;
  final String endDate;
  final String type;
  final String binsizeName;
  final String bookingId;
  final String userId;
  final String usertoken;
  const BinBookingBottomSheet({
    super.key,
    required this.customername,
    required this.location,
    required this.endDate,
    required this.type,
    required this.binsizeName,
    required this.bookingId,
    required this.userId,
    required this.usertoken,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BinRequestProvider>(
      builder: (context, binr, child) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10.r,
                      children: [
                        CustomListtile(
                          subtitle: customername,
                          title: 'Customer Name',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: location,
                          title: 'Location',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: endDate,
                          title: 'End Date',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: endDate,
                          title: 'Type',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: 'Bin Size:$binsizeName',
                          title: 'Bin Size Name',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CleanerButton.elevated(
                  width: MediaQuery.sizeOf(context).width,
                  backgroundcolor: CleanerAppcolors.primarypurple,
                  label:
                      binr.loadingrequestaccept == true
                          ? 'Please Wait....'
                          : 'Accept Request',
                  onPressed: () async {
                    binr.getBinRequestData(
                
                    ); // ← optional, if you want

                    await binr.getRequestAccept(
                      context,
                      userId,
                      bookingId,
                  
                    );

                    // Delay before closing to ensure SnackBar appears
                    await Future.delayed(Duration(milliseconds: 300));
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
