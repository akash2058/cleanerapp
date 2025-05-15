import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BinBookingBottomSheet extends StatefulWidget {
  final String customername;
  final String location;
  final String startdate;
  final String endDate;
  final String type;
  final String binsizeName;
  final String bookingId;
  final String userId;
 
  const BinBookingBottomSheet({
    super.key,
    required this.customername,
    required this.location,
    required this.endDate,
    required this.type,
    required this.binsizeName,
    required this.bookingId,
    required this.userId, required this.startdate,

  });

  @override
  State<BinBookingBottomSheet> createState() => _BinBookingBottomSheetState();
}

class _BinBookingBottomSheetState extends State<BinBookingBottomSheet> {
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    logindata.loadLoginData();
     print('get${widget.bookingId}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BinRequestProvider>(
      builder: (context, binr, child) {
        return Consumer<LoginProvider>(builder: (context, log, child) {
          return  SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15).r,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10.r,
                      children: [
                        CustomListtile(
                          subtitle: capitalizeEachPart(widget.customername),
                          title: 'Customer Name',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: capitalizeEachPart(widget.location),
                          title: 'Location',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: widget.startdate,
                          title: 'Start Date',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: widget.endDate,
                          title: 'End Date',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          subtitle: widget.binsizeName,
                          title: 'Bin Size',
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
                  height: 60.r,
                  width: MediaQuery.sizeOf(context).width,
                  backgroundcolor: CleanerAppcolors.primarypurple,
                  label:
                      binr.loadingrequestaccept == true
                          ? 'Please Wait....'
                          : 'Accept Request',
                  onPressed: () async {
                    await binr.getRequestAccept(
                      context,  log.userid,
                      widget.bookingId,
                    ); 
                  },
                ),
              ],
            ),
          ),
        );
        },);
      },
    );
  }
}
String capitalizeEachPart(String input) {
  return input
      .split(',')
      .map((part) {
        return part
            .trim()
            .split(' ')
            .where((word) => word.isNotEmpty)
            .map((word) =>
                word[0].toUpperCase() + word.substring(1).toLowerCase())
            .join(' ');
      })
      .join(', ');
}
