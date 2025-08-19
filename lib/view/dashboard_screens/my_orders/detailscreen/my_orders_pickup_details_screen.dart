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
  final String companyname;
  final String comment;
  final String customercontact;

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
    required this.companyname,
    required this.comment,
    required this.customercontact,
  });

  @override
  State<MyOrdersPickupDetailsScreen> createState() =>
      _MyOrdersPickupDetailsScreenState();
}

class _MyOrdersPickupDetailsScreenState
    extends State<MyOrdersPickupDetailsScreen> with WidgetsBindingObserver {
  final serialkey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _buttonKey = GlobalKey();
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize focus nodes for each serial field
    _focusNodes = List.generate(widget.quantity, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyOrderProvider>(context, listen: false)
          .initializeControllers(widget.quantity);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    for (var node in _focusNodes) node.dispose();
    super.dispose();
  }

  // Triggered whenever keyboard opens/closes
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomInset > 0) {
      // Keyboard opened, scroll button up immediately
      _scrollToButton();
    }
  }

  void _scrollToButton() {
    if (_buttonKey.currentContext != null) {
      Scrollable.ensureVisible(
        _buttonKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.9,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyOrderProvider, LoginProvider>(
      builder: (context, order, log, child) {
        return Scaffold(
          backgroundColor: CleanerAppcolors.primaryWhitecolor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: CleanerAppcolors.primaryWhitecolor,
            scrolledUnderElevation: 0,
            title: Text('Pick Up Details', style: appbartitlefont),
          ),
          body: order.loadingserialdata
              ? Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: CleanerAppcolors.primarypurple,
                    size: 50.r,
                  ),
                )
              : NoInternetBanner(
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      left: 20.r,
                      right: 20.r,
                      top: 10.r,
                     
                    ),
                    child: Form(
                      key: serialkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DetailsCard(
                            customername: widget.customername,
                            duration: widget.duration,
                            binsizename: widget.binsizename,
                            quantity: widget.quantity.toString(),
                            location: widget.location,
                            paymentoption: widget.paymentoption ?? 'N/A',
                            paymentreceived:
                                widget.paymentreceived ?? 'N/A',
                            pendingamount: widget.pendingamount ?? 'N/A',
                            paymenttype: widget.payementtype ?? 'N/A',
                            companyname: widget.companyname,
                            comment: widget.comment,
                            customerContact: widget.customercontact,
                          ),
                          SizedBox(height: 20.r),
                          FormCard(
                            quantity: widget.quantity,
                            focusNodes: _focusNodes,
                            buttonKey: _buttonKey,
                            parentContext: context,
                          ),
                          SizedBox(height: 20.r),
                          CleanerButton.elevated(
                            key: _buttonKey,
                            height: 55.r,
                            width: MediaQuery.sizeOf(context).width,
                            isloading: order.loadingserialdata,
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
                          SizedBox(height: 20.r),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
