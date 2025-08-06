import 'package:binbookingapp/custom_widget/cleaner_chip.dart' show CleanerChip;
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BinRequestCard extends StatelessWidget {
  final String address;
  final String binsizename;
  final String quantity;
  final String startdate;
  final String duration;
  final int requestoverdue;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  const BinRequestCard({
    super.key,
    required this.address,
    required this.quantity,
    required this.startdate,
    required this.binsizename,
    required this.duration,
    this.onPressed,
    this.onTap,
    required this.requestoverdue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: CleanerAppcolors.primaryWhitecolor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(105, 108, 255, 0.4).withOpacity(0.5.r),
                spreadRadius: 1.5.r,
                blurRadius: 1.5.r,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5.r,
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          size: 20.r,
                          color: CleanerAppcolors.primarylightbrowncolor,
                        ),
                        SizedBox(
                          width: 220.r,
                          child: Text(
                            capitalizeEachPart(address),
                            style: listiletitlefont,
                          ),
                        ),
                      ],
                    ),
                    CleanerChip(
                      onPressed: onPressed,
                      label: 'View',
                      backgroundColor: CleanerAppcolors.primarypurple,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25).r,
                  child: Text('Bin Size:$binsizename', style: listiletitlefont),
                ),
                SizedBox(height: 5.r),
                Card(
                  elevation: 5.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  color:
                      requestoverdue == 0
                          ? const Color.fromARGB(255, 142, 240, 183)
                          : requestoverdue == 1
                          ? CleanerAppcolors.primarylightredcolor
                          : requestoverdue == 3
                          ? CleanerAppcolors.primarylightredcolor
                          : CleanerAppcolors.primarylightredcolor,

                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Start Date', style: greetingsStyleblack),
                            Text(startdate, style: dashboardlabelfontdarkgrey),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Quantity', style: greetingsStyleblack),
                            Text(quantity, style: dashboardlabelfontdarkgrey),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Duration', style: greetingsStyleblack),
                            Text(
                              '$duration days',
                              style: dashboardlabelfontdarkgrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
