import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart' show AppIcons;
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsCard extends StatelessWidget {
  final String customername;
  final String duration;
  final String binsizename;
  final String quantity;
  final String location;
  final String pendingamount;
  final String paymentoption;
  final String paymentreceived;
  final String paymenttype;
  final String companyname;
  final String comment;
  final String customerContact;
  const DetailsCard({
    super.key,
    required this.customername,
    required this.duration,
    required this.binsizename,
    required this.quantity,
    required this.location,
    required this.paymentoption,
    required this.paymentreceived,
    required this.pendingamount,
    required this.paymenttype,
    required this.companyname,
    required this.comment,
    required this.customerContact,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyOrderProvider, BinRequestProvider>(
      builder: (context, myorder, binr, child) {
        return SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              border: Border.all(color: CleanerAppcolors.primaryminigreycolor),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 5.r,
                    children: [
                      Image.asset(AppIcons.myordersicon, height: 20.r),
                      Text('Orders Details', style: ordercardheaderfont),
                    ],
                  ),
                  Divider(color: CleanerAppcolors.primaryminigreycolor),
                  CustomListtile(
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Customer Name',
                    subtitle: capitalizeEachPart(companyname),
                  ),
                  SizedBox(height: 5.r),
                  CustomListtile(
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Customer Company',
                    subtitle: companyname,
                  ),
                  SizedBox(height: 5.r),
                  CustomListtile(
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Duration',
                    subtitle: '$duration days',
                  ),
                  SizedBox(height: 5.r),
                  CustomListtile(
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Bin Size Name',
                    subtitle: binsizename,
                  ),
                  SizedBox(height: 5.r),
                  CustomListtile(
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Quantity',
                    subtitle: quantity,
                  ),
                  SizedBox(height: 5.r),
                  CustomListtile(
                    trailing: GestureDetector(
                      onTap: () {
                        binr.copyToClipboard(location, context);
                      },
                      child: Icon(Icons.copy_all_outlined, size: 25.r)),
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Location',
                    subtitle: capitalizeEachPart(location),
                  ),

                  SizedBox(height: 5.r),

                  CustomListtile(
                    trailing: GestureDetector(
                      onTap: () {
                        binr.launchDialer(customerContact, context);
                      },
                      child: Icon(Icons.call_outlined, size: 25.r),
                    ),
                    leading: Icon(Icons.arrow_forward_ios_outlined, size: 20.r),
                    title: 'Customer Contact ',
                    subtitle: customerContact,
                  ),
                  SizedBox(height: 5.r),

                  if (paymentoption == 'cash_on_delivery' &&
                      pendingamount != '0')
                    CustomListtile(
                      leading: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20.r,
                      ),
                      title: 'Total Amount',
                      subtitle: pendingamount,
                    ),

                  if (paymenttype != 'full_payment' && paymentreceived != '0')
                    CustomListtile(
                      leading: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20.r,
                      ),
                      title: 'Receive amount',
                      subtitle: paymentreceived,
                    ),

                  SizedBox(height: 5.r),
                  ListTile(
                    minLeadingWidth: -12.r,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0).r,
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    leading: Icon(Icons.arrow_forward_ios, size: 20.r),
                    title: Text('Comment', style: listiletitlefont),
                    subtitle: Text(comment, style: dashboardlabelfontred),
                  ),
                ],
              ),
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
              if (lowerWord.length == 2 &&
                  RegExp(r'^[a-zA-Z]{2}$').hasMatch(lowerWord)) {
                return lowerWord.toUpperCase();
              }

              // If contains slash like a/a, capitalize both parts
              if (word.contains('/')) {
                return word
                    .split('/')
                    .map(
                      (w) =>
                          w.isNotEmpty
                              ? w[0].toUpperCase() +
                                  w.substring(1).toLowerCase()
                              : '',
                    )
                    .join('/');
              }

              // Default capitalization
              return word[0].toUpperCase() + word.substring(1).toLowerCase();
            })
            .join(' ');
      })
      .join(', ');
}
