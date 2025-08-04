import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart' show AppIcons;
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/detail_label.dart';
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
  const DetailsCard({
    super.key,
    required this.customername,
    required this.duration,
    required this.binsizename,
    required this.quantity,
    required this.location,
    required this.paymentoption,
    required this.paymentreceived,
    required this.pendingamount, required this.paymenttype, required this.companyname, required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, myorder, child) {
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
                  SizedBox(height: 10.r),
                  DetailsLabel(label: 'Customer Name', sublabel: capitalizeEachPart(customername)),
                      SizedBox(height: 5.r),
               Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Company Name', style: subtitlefonts),
                      SizedBox(
                        width: 210.r,
                        child: Text(
                          textAlign: TextAlign.end,
                          capitalizeEachPart(companyname), style: resendfontminigrey))
                    ],
                  ),
                  SizedBox(height: 5.r),
                  DetailsLabel(label: 'Duration', sublabel: '$duration days'),
                  SizedBox(height: 5.r),
                  DetailsLabel(label: 'Bin Size Name', sublabel: binsizename),
                  SizedBox(height: 5.r),
                  DetailsLabel(label: 'Quantity', sublabel: quantity),
                  SizedBox(height: 5.r),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location', style: subtitlefonts),
                      SizedBox(
                        width: 210.r,
                        child: Text(
                          textAlign: TextAlign.end,
                          capitalizeEachPart(location), style: resendfontminigrey))
                    ],
                  ),
                 
                  SizedBox(height: 5.r),
                  if (paymentoption == 'cash_on_delivery' &&
                      pendingamount != '0')
                    DetailsLabel(label: 'Total Amount', sublabel: pendingamount),
                      SizedBox(height: 5.r),
                    if(paymenttype != 'full_payment'&& paymentreceived !='0')
                    DetailsLabel(label: 'Receive amount', sublabel: paymentreceived),
                      SizedBox(height: 5.r),
                      Text('Comment',style: subtitlefontsred,),
                      SizedBox(
                        height: 5.r,
                      ),
                      Text(comment,style: resendfontminigrey,)
                  
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
            .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
            )
            .join(' ');
      })
      .join(', ');
}
