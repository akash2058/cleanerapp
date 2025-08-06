import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
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
  final String contactnumber;
  final String companyname;
  final String comment;

  const BinBookingBottomSheet({
    super.key,
    required this.customername,
    required this.location,
    required this.endDate,
    required this.type,
    required this.binsizeName,
    required this.bookingId,
    required this.userId,
    required this.startdate,
    required this.contactnumber,
    required this.companyname,
    required this.comment,
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
    return Consumer2<BinRequestProvider, LoginProvider>(
      builder: (context, binr, log, child) {
        return SizedBox(
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
                          subtitle: capitalizeEachPart(widget.companyname),
                          title: 'Company Name',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          trailing: GestureDetector(
                            onTap: () {
                              binr.copyToClipboard(widget.location, context);
                            },
                            child: Icon(Icons.copy_outlined, size: 30.r),
                          ),
                          subtitle: capitalizeEachPart(widget.location),
                          title: 'Location',
                          leading: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20.r,
                          ),
                        ),
                        CustomListtile(
                          trailing: GestureDetector(
                            onTap: () {
                              binr.launchDialer(widget.contactnumber);
                            },
                            child: Icon(Icons.call_outlined, size: 30.r),
                          ),
                          subtitle: widget.contactnumber,
                          title: 'Customer Contact',
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
                        ListTile(
                          minLeadingWidth: -12.r,
                          contentPadding:
                              EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ).r,
                          dense: true,
                          visualDensity: VisualDensity(
                            vertical: -4,
                            horizontal: -4,
                          ),
                          leading: Icon(Icons.arrow_forward_ios, size: 20.r),
                          title: Text('Comment', style: errorstyle),
                          subtitle: Text(
                            widget.comment,
                            style: dashboardlabelfontblack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CleanerButton.elevated(
                  isloading: binr.loadingrequestaccept,
                  height: 60.r,
                  width: MediaQuery.sizeOf(context).width,
                  backgroundcolor: CleanerAppcolors.primarypurple,
                  label: 'Accept Request',
                  onPressed: () async {
                    await binr.getRequestAccept(
                      context,
                      log.userid,
                      widget.bookingId,
                    );
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

String capitalizeEachPart(String input) {
  return input
      .split(',')
      .map((part) {
        return part
            .trim()
            .split(' ')
            .where((word) => word.isNotEmpty)
            .map((word) {
              String lowerWord = word.toLowerCase();

              // If it's exactly 2 letters, make both uppercase
              if (lowerWord.length == 2 && RegExp(r'^[a-zA-Z]{2}$').hasMatch(lowerWord)) {
                return lowerWord.toUpperCase();
              }

              // If contains slash like a/a, capitalize both parts
              if (word.contains('/')) {
                return word
                    .split('/')
                    .map((w) => w.isNotEmpty
                        ? w[0].toUpperCase() + w.substring(1).toLowerCase()
                        : '')
                    .join('/');
              }

              // Default capitalization
              return word[0].toUpperCase() + word.substring(1).toLowerCase();
            })
            .join(' ');
      })
      .join(', ');
}

