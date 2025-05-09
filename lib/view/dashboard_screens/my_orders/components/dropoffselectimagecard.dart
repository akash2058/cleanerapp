

import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/select_image_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DropOffSelectImageCard extends StatelessWidget {
  const DropOffSelectImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        return SizedBox(
          child:
              order.orderdetail?.bookingSerialNumbers?.isEmpty ?? true
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 250.r),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(AppIcons.closedd, height: 70.r),
                          Text('No Serial Numbers Found', style: resendfont),
                        ],
                      ),
                    ),
                  )
                  : Column(
                    spacing: 20.r,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(order.orderdetail?.bookingSerialNumbers?.length ?? 0, (
                      index,
                    ) {
                      final serialdatta =
                          order.orderdetail?.bookingSerialNumbers?[index];
                      return SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: CleanerAppcolors.primaryminidarkgreycolor,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ).r,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.format_list_numbered_outlined,
                                      size: 25.r,
                                    ),
                                    SizedBox(width: 8.r),
                                    Text(
                                      'SN #${serialdatta?.serialNumber ?? ''}',
                                      style: ordercardheaderfont,
                                    ),
                                  ],
                                ),
                                Divider(),
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Is Damaged',
                                //       style: dashboardlabelfontblack,
                                //     ),
                                //     Checkbox(
                                //       side: BorderSide(
                                //         color:
                                //             CleanerAppcolors
                                //                 .primaryminidarkgreycolor,
                                //       ),
                                //       activeColor:
                                //           CleanerAppcolors.primarypurple,
                                //       visualDensity: VisualDensity(
                                //         horizontal: -4,
                                //         vertical: -4,
                                //       ),
                                //       value: order.isDamagedList[index],
                                //       onChanged: (value) {
                                //         order.toggleCheckbox(index, value);
                                //       },
                                //     ),
                                //   ],
                                // ),

                                // ✅ Unified layout with image list + add image section
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: DottedBorder(
                                    color:
                                        CleanerAppcolors
                                            .primaryminidarkgreycolor,
                                    dashPattern: [3, 3],
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10.r),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Column(
                                        children: [
                                          // ✅ Show selected images
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 10.r,
                                            runSpacing: 10.r,
                                            children: List.generate(
                                              order.imagesPerBin[index].length,
                                              (imgIndex) {
                                                var image =
                                                    order
                                                        .imagesPerBin[index][imgIndex];
                                                return SelectedImageCard(
                                                  imagepath: image,
                                                  onTap: () {
                                                    order.removeImage(
                                                      index,
                                                      imgIndex,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),

                                          // ✅ Add image button if less than 3 images
                                          if (order.imagesPerBin[index].length <
                                              3)
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Center(
                                                        child: Text(
                                                          'Choose Image',
                                                          style: resendfont,
                                                        ),
                                                      ),
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              order.pickImage(
                                                                index,
                                                                context,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons.image,
                                                                ),
                                                                Text(
                                                                  'Gallery',
                                                                  style:
                                                                      dashboardlabelfontblack,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              order
                                                                  .captureImage(
                                                                    index,
                                                                  );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons.camera,
                                                                ),
                                                                Text(
                                                                  'Camera',
                                                                  style:
                                                                      dashboardlabelfontblack,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.r,
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.image_outlined,
                                                        size: 50.r,
                                                        color:
                                                            CleanerAppcolors
                                                                .primarypurple,
                                                      ),
                                                      Text(
                                                        'Add Image',
                                                        style:
                                                            addimagefont,
                                                      ),
                                                      Text(
                                                        'Only 3 images allowed',
                                                        style:
                                                            allowimagefont,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
        );
      },
    );
  }
}
