import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/dropoffselectimagecard.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/is_damaged_detailpage.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final String? pendingamount;
  final String? paymentoption;
  final String? paymentreceived;
  final String? remainingamount;
  final String? payementtype;
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
    required this.pendingamount,
    required this.paymentoption,
    required this.paymentreceived,
    this.payementtype, required this.remainingamount,
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
      getData(context);
    });
  }

  Future<void> getData(context) async {
    final logindata = Provider.of<LoginProvider>(context, listen: false);
    await logindata.loadLoginData();
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    await myordersdata.getMyordersData(logindata.userid);
    final binrequestdata = Provider.of<BinRequestProvider>(
      context,
      listen: false,
    );
    await binrequestdata.getBinRequestData();
    print(widget.remainingamount);
    // myordersdata.paymentreceivecontroller.clear();
  }

  void refreshdata() async {
    // final logindata = Provider.of<LoginProvider>(context, listen: false);

    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    myordersdata.getMyorderDropOffDetail(widget.bookingid);
    print(widget.bookingid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider,MyOrderProvider>(builder: (context, log, order, child) {
       final fieldkey = GlobalKey<FormState>();

        final orderdata = order.orderdetail?.data;
      return Scaffold(
              backgroundColor: CleanerAppcolors.primaryWhitecolor,
              bottomNavigationBar: BottomAppBar(
                color: CleanerAppcolors.primaryWhitecolor,
                height: 90.r,
                elevation: 0,
                child: CleanerButton.elevated(
                  isloading: order.loadingattachments,
                          backgroundcolor: CleanerAppcolors.primarypurple,
                          label:
                             'Update Order',
                          onPressed: () {
                           if(fieldkey.currentState!.validate()){
                             order.getUpdateAttachments(
                              context,
                              widget.bookingid,
                              log.userid,
                            );
                           }
                          },
                        ),
              ),
              appBar: AppBar(
                centerTitle: true,
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
                              size: 40.r,
                            ),
                          )
                          : order.loadingattachments == true
                          ? Center(
                            child: LoadingAnimationWidget.hexagonDots(
                              color: CleanerAppcolors.primarypurple,
                              size: 30.r,
                            ),
                          )
                          : SingleChildScrollView(
                            child: Form(
                              key: fieldkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 15.r,
                                children: [
                                  DetailsCard(
                                    customername: orderdata?.customerName ?? '',
                                    duration:
                                        orderdata?.orderDuration.toString() ??
                                        '0',
                                    binsizename: widget.binsizename,
                                    quantity: widget.quantity.toString(),
                                    location: widget.location,
                                    paymentoption: widget.paymentoption ?? '',
                                    paymentreceived: widget.paymentreceived ?? '',
                                    pendingamount: widget.pendingamount ?? '',
                                    paymenttype: widget.payementtype ?? '',
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CustomPageRoute(
                                            child: IsDamagedDetailpage(
                                              customername:
                                                  orderdata?.customerName ?? '',
                                              duration:
                                                  orderdata?.orderDuration
                                                      .toString() ??
                                                  '',
                                              binsizename:
                                                  orderdata?.binSizeName ?? '',
                                              quantity:
                                                  orderdata?.quantity
                                                      .toString() ??
                                                  '',
                                              location: orderdata?.location ?? '',
                                              driverid: log.userid,
                                              bookingid:
                                                  orderdata?.id.toString() ?? '',
                                              pendingamount:
                                                  widget.pendingamount ?? '',
                                              paymentoption:
                                                  widget.paymentoption ?? '',
                                              paymentreceived:
                                                  widget.paymentreceived ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Report Damage',
                                        style: reportdamagefont,
                                      ),
                                    ),
                                  ),
                                  if (widget.payementtype != 'full_payment')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Amount Received',
                                          style: resendfont,
                                        ),
                                        TextFormField(
                                          controller:
                                              order.paymentreceivecontroller,
                                          keyboardType: TextInputType.number,
                                          validator:
                                              (value) => validatedropAmount(
                                                value,
                                               widget.remainingamount??'',
                                              ),
                                          style: entertexttile,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ).r,
                                            hintText: 'Enter received amount',
                                            hintStyle: hintStyle,
                                            errorStyle: errorstyle,
                                            disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    CleanerAppcolors
                                                        .primaryminigreycolor, // change this to your color
                                                width:
                                                    1.5.r, // change thickness here
                                              ),
                                            ),
                                            // 🔽 Default border when not focused
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    CleanerAppcolors
                                                        .primaryminidarkgreycolor, // change this to your color
                                                width:
                                                    1.5.r, // change thickness here
                                              ),
                                            ),
                              
                                            // 🔽 Border when focused (on tap)
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    CleanerAppcolors
                                                        .primarypurple, // focused color
                                                width: 1.5.r, // focused thickness
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  Text(
                                    'Please Add Images Below',
                                    style: ordercardheaderfont,
                                  ),
                                  DropOffSelectImageCard(),
                                ],
                              ),
                            ),
                          ),
                ),
              ),
            );
    },);
  }
}


  