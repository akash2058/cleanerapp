import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/form_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersPickupDetailsScreen extends StatefulWidget {
  final String customername;
  final String startDate;
  final String endate;
  final int quantity;
  final String binsizename;
  final String duration;
  final String location;
  final String bookingid;
  final String? pendingamount;
  final String? paymentoption;
  final String? paymentreceived;
  final String? payementtype;
  const MyOrdersPickupDetailsScreen({
    super.key,
    required this.customername,
    required this.startDate,
    required this.endate,
    required this.quantity,
    required this.binsizename,
    required this.duration,
    required this.location,
    required this.bookingid,
    required this.pendingamount,
    required this.paymentoption,
    required this.paymentreceived,
    this.payementtype,
  });

  @override
  State<MyOrdersPickupDetailsScreen> createState() =>
      _MyOrdersPickupDetailsScreenState();
}

class _MyOrdersPickupDetailsScreenState
    extends State<MyOrdersPickupDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialisethequantity();
    });
  }

  Future<void> initialisethequantity() async {
    var myorderstate = Provider.of<MyOrderProvider>(context, listen: false);
    myorderstate.initializeControllers(widget.quantity);
  }

  final serialkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyOrderProvider,LoginProvider>(builder: (context, order, log, child) {
      return Scaffold(
              backgroundColor: CleanerAppcolors.primaryWhitecolor,
              
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: CleanerAppcolors.primaryWhitecolor,
                scrolledUnderElevation: 0.r,
                title: Text('Pick Up Details', style: appbartitlefont),
              ),
              body:  NoInternetBanner(
  child: order.loadingserialdata
      ? Center(
          child: LoadingAnimationWidget.hexagonDots(
            color: CleanerAppcolors.primarypurple,
            size: 50.r,
          ),
        )
      : LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: serialkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailsCard(
                          customername: widget.customername,
                          duration: widget.duration,
                          binsizename: widget.binsizename,
                          quantity: widget.quantity.toString(),
                          location: widget.location,
                          paymentoption: widget.paymentoption ?? '',
                          paymentreceived: widget.paymentreceived ?? '',
                          pendingamount: widget.pendingamount ?? '',
                          paymenttype: widget.payementtype ?? '',
                        ),
                        FormCard(quantity: widget.quantity),
                        const Spacer(),
                        SizedBox(height: 20.r),
                        if (widget.quantity != 0)
                          CleanerButton.elevated(
                            isloading: order.loadingserialdata,
                            width: MediaQuery.sizeOf(context).width,
                            backgroundcolor: CleanerAppcolors.primarypurple,
                            label: 'Update Order',
                            onPressed: () {
                              if (serialkey.currentState!.validate()) {
                                order.getSerialData(
                                  context,
                                  widget.bookingid,
                                  log.userid,
                                );
                              }
                            },
                          ),
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
    },);
  }
}

