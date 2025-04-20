import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/form_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';
import 'package:binbookingapp/view/session_expire_dialog/session_expire_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const MyOrdersPickupDetailsScreen({
    super.key,
    required this.customername,
    required this.startDate,
    required this.endate,
    required this.quantity,
    required this.binsizename,
    required this.duration,
    required this.location, required this.bookingid,
  });

  @override
  State<MyOrdersPickupDetailsScreen> createState() => _MyOrdersPickupDetailsScreenState();
}

class _MyOrdersPickupDetailsScreenState extends State<MyOrdersPickupDetailsScreen> {
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      initialisethequantity();
    });
  }
  Future<void> initialisethequantity()async{
    var myorderstate = Provider.of<MyOrderProvider>(context,listen: false);
  myorderstate.initializeControllers(widget.quantity);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(builder: (context, order, child) {
      return Consumer<LoginProvider>(builder: (context, log, child) {
        var userdata = log.user?.data?.user;
        return Scaffold(
      backgroundColor: CleanerAppcolors.primaryWhitecolor,
      bottomNavigationBar: BottomAppBar(
        color:  CleanerAppcolors.primaryWhitecolor,
        elevation: 0,
        height: 95.r,
        child:  CleanerButton.elevated(
              width: MediaQuery.sizeOf(context).width,
              backgroundcolor: CleanerAppcolors.primarypurple,
              label:order.loadingserialdata == true?'Please Wait...' :'Update Order',
              onPressed: () {
                order.getSerialData(context, log.user?.data?.user?.id.toString()??'',widget.bookingid,);
              },
            ),
      ),
      appBar: AppBar(
        backgroundColor: CleanerAppcolors.primaryWhitecolor,
        scrolledUnderElevation: 0.r,
        title: Text('Pick Up Details', style: appbartitlefont)),
      body: NoInternetBanner(
        child: SessionWrapper(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.r,
              children: [
                DetailsCard(
                  customername: widget.customername,
                  duration: widget.duration,
                  binsizename: widget.binsizename,
                  quantity: widget.quantity.toString(),
                  location: widget.location,
                ),
                FormCard(quantity: widget.quantity),
             
              ],
            ),
          ),
                ),
        ),
      )
    );
      },);
    },);
  }
}
