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
  final String companyname;
  final String comment;
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
    this.payementtype,
    required this.remainingamount,
    required this.companyname,
    required this.comment,
  });

  @override
  State<MyOrdersDropOffDetailsScreen> createState() =>
      _MyOrdersDropOffDetailsScreenState();
}

class _MyOrdersDropOffDetailsScreenState
    extends State<MyOrdersDropOffDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  final fieldkey = GlobalKey<FormState>();
  final GlobalKey _buttonKey = GlobalKey(); // Key to track button position

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshdata();
      getData(context);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
  }

  void refreshdata() async {
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    myordersdata.getMyorderDropOffDetail(widget.bookingid);
    print(widget.bookingid);
  }

  // Function to scroll to the Update Order button
  void _scrollToButton() {
    if (_scrollController.hasClients) {
      final RenderBox? buttonBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (buttonBox != null) {
        final position = buttonBox.localToGlobal(Offset.zero).dy;
        final viewportHeight = MediaQuery.of(context).size.height;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final targetOffset = position - (viewportHeight - keyboardHeight - 100.r); // Adjust for button visibility
        final maxScroll = _scrollController.position.maxScrollExtent;
        final scrollOffset = targetOffset.clamp(0.0, maxScroll);
        
        _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, MyOrderProvider>(
      builder: (context, log, order, child) {
        final orderdata = order.orderdetail?.data;
        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryWhitecolor,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: CleanerAppcolors.primaryWhitecolor,
            scrolledUnderElevation: 0,
            title: Text('Drop Off Details', style: appbartitlefont),
          ),
          body: NoInternetBanner(
            child: order.loadingattachments
                ? Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: CleanerAppcolors.primarypurple,
                      size: 50.r,
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.r,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Form(
                              key: fieldkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailsCard(
                                    customername: orderdata?.customerName ?? '',
                                    duration: orderdata?.orderDuration.toString() ?? '0',
                                    binsizename: widget.binsizename,
                                    quantity: widget.quantity.toString(),
                                    location: widget.location,
                                    paymentoption: widget.paymentoption ?? '',
                                    paymentreceived: widget.paymentreceived ?? '',
                                    pendingamount: widget.pendingamount ?? '',
                                    paymenttype: widget.payementtype ?? '',
                                    companyname: widget.companyname,
                                    comment: widget.comment,
                                  ),
                                  SizedBox(height: 10.r),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CustomPageRoute(
                                          child: IsDamagedDetailpage(
                                            customername: orderdata?.customerName ?? '',
                                            duration: orderdata?.orderDuration.toString() ?? '',
                                            binsizename: orderdata?.binSizeName ?? '',
                                            quantity: orderdata?.quantity.toString() ?? '',
                                            location: orderdata?.location ?? '',
                                            driverid: log.userid,
                                            bookingid: orderdata?.id.toString() ?? '',
                                            pendingamount: widget.pendingamount ?? '',
                                            paymentoption: widget.paymentoption ?? '',
                                            paymentreceived: widget.paymentreceived ?? '',
                                            companyname: '',
                                            comment: '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Report Damage',
                                        style: reportdamagefont,
                                      ),
                                    ),
                                  ),
                                   if (widget.payementtype != 'full_payment' &&
                                      widget.paymentoption !=
                                          'cash_on_order') ...[
                                  Text('Amount Received', style: resendfont),
                                  TextFormField(
                                    controller: order.paymentreceivecontroller,
                                    keyboardType: TextInputType.number,
                                    validator: (value) => validatedropAmount(
                                      value,
                                      widget.remainingamount ?? '',
                                    ),
                                    style: entertexttile,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Enter received amount',
                                      hintStyle: hintStyle,
                                      errorStyle: errorstyle,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CleanerAppcolors.primarypurple,
                                          width: 1.5.r,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Future.delayed(
                                        const Duration(milliseconds: 300),
                                        _scrollToButton,
                                      );
                                    },
                                  ),
                                          ],    
                                  SizedBox(height: 20.r),
                                  Text(
                                    'Please Add Images Below',
                                    style: ordercardheaderfont,
                                  ),
                                  SizedBox(height: 20.r),
                                  DropOffSelectImageCard(),
                                 
                                  SizedBox(height: 50.r), // Fixed space
                                  CleanerButton.elevated(
                                    key: _buttonKey, // Assign key to button
                                    height: 55.r,
                                    width: MediaQuery.sizeOf(context).width,
                                    isloading: order.loadingattachments,
                                    backgroundcolor: CleanerAppcolors.primarypurple,
                                    label: 'Update Order',
                                    onPressed: () {
                                      if (fieldkey.currentState!.validate()) {
                                        order.getUpdateAttachments(
                                          context,
                                          widget.bookingid,
                                          log.userid,
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.r),
                                  SizedBox(
                                    height: MediaQuery.of(context).viewInsets.bottom + 20.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}