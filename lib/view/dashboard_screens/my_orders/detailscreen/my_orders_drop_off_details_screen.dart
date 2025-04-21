import 'dart:io';

import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersDropOffDetailsScreen extends StatefulWidget {
  final int quantity;
  final String customerName;
  final String startdate;
  final String endate;
  final String location;
  final String duration;
  final String binsizename;
  final String bookingid;
  const MyOrdersDropOffDetailsScreen({
    super.key,
    required this.quantity,
    required this.customerName,
    required this.startdate,
    required this.endate,
    required this.location,
    required this.duration,
    required this.binsizename,
    required this.bookingid,
  });

  @override
  State<MyOrdersDropOffDetailsScreen> createState() =>
      _MyOrdersDropOffDetailsScreenState();
}

class _MyOrdersDropOffDetailsScreenState
    extends State<MyOrdersDropOffDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshdata();
      getData();
    });
  }

  Future<void> getData() async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    await logindata.loadLoginData();
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    await myordersdata.getMyordersData(
    logindata.userid
  
    );
    print('logindata.userid${logindata.name}');
    final binrequestdata = Provider.of<BinRequestProvider>(
      context,
      listen: false,
    );
    await binrequestdata.getBinRequestData();
  }

  void refreshdata() async {
    // final logindata = Provider.of<LoginProvider>(context, listen: false);
    
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    myordersdata.getMyorderDropOffDetail(
      widget.bookingid,
    );
    print(widget.bookingid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        final orderdata = order.orderdetail?.data;
        return Consumer<LoginProvider>(builder: (context, log, child) {
          return Scaffold(
          backgroundColor: CleanerAppcolors.primaryWhitecolor,
          bottomNavigationBar: BottomAppBar(
            color: CleanerAppcolors.primaryWhitecolor,
            height: 90.r,
            elevation: 0,
            child:order.orderdetail?.bookingSerialNumbers?.isEmpty??true?null: CleanerButton.elevated(
              backgroundcolor: CleanerAppcolors.primarypurple,
              label:order.loadingattachments == true?'Please Wait...': 'Update Order',
              onPressed: () {
              order.getUpdateAttachments(context,widget.bookingid,log.userid,);
              },
            ),
          ),
          appBar: AppBar(
            backgroundColor: CleanerAppcolors.primaryWhitecolor,
            scrolledUnderElevation: 0,
            title: Text('Drop Off Details', style: appbartitlefont),
          ),
          body: NoInternetBanner(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
              child:
                  order.loadingmyorderdropoffdetail == true
                      ? Center(
                        child: LoadingAnimationWidget.hexagonDots(
                          color: CleanerAppcolors.primarypurple,
                          size: 30.r,
                        ),
                      )
                      : order.loadingattachments == true?Center(
                        child: LoadingAnimationWidget.hexagonDots(
                          color: CleanerAppcolors.primarypurple,
                          size: 30.r,
                        ),
                      ): SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15.r,
                          children: [
                            DetailsCard(
                              customername: orderdata?.customerName ?? '',
                              duration:
                                  orderdata?.orderDuration.toString() ?? '0',
                              binsizename: widget.binsizename,
                              quantity: widget.quantity.toString(),
                              location: widget.location,
                            ),
                            Text(
                              'Please Fill The Neccessary Information',
                              style: ordercardheaderfont,
                            ),
                            DropOffSelectImageCard(),
                          ],
                        ),
                      ),
            ),
          ),
        );
        },);
      },
    );
  }
}

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
                                    Icon(Icons.format_list_numbered_outlined, size: 25.r),
                                    SizedBox(width: 8.r),
                                    Text(
                                      'SN#${serialdatta?.serialNumber ?? ''}',
                                      style: ordercardheaderfont,
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'Is Damaged',
                                      style: dashboardlabelfontblack,
                                    ),
                                    Checkbox(side: BorderSide(color: CleanerAppcolors.primaryminidarkgreycolor),
                                      activeColor: CleanerAppcolors.primarypurple,
                                      visualDensity: VisualDensity(
                                        horizontal: -4,
                                        vertical: -4,
                                      ),
                                      value: order.isDamagedList[index],
                                      onChanged: (value) {
                                        order.toggleCheckbox(index, value);
                                      },
                                    ),
                                  ],
                                ),

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
                                                        size: 30.r,
                                                        color:
                                                            CleanerAppcolors
                                                                .primarypurple,
                                                      ),
                                                      SizedBox(height: 5.r),
                                                      Text(
                                                        'Add Image',
                                                        style:
                                                            dashboardlablefontpurple,
                                                      ),
                                                      Text(
                                                        'Only 3 images allowed',
                                                        style:
                                                            dashboardlablefontgrey,
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

class SelectedImageCard extends StatelessWidget {
  final VoidCallback? onTap;
  final XFile imagepath;
  const SelectedImageCard({super.key, required this.imagepath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.r,
      width: 100.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 80.r,
            width: 100.r,
            child: DecoratedBox(
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.file(File(imagepath.path), fit: BoxFit.fill),
              ),
            ),
          ),
          Positioned(
            top: -10.r,
            right: -10.r,
            child: GestureDetector(
              onTap: onTap,
              child: Icon(Icons.remove_circle, color: Colors.red, size: 40.r),
            ),
          ),
        ],
      ),
    );
  }
}
