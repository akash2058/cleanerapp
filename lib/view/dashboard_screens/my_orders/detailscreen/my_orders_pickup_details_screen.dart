import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/details_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/form_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_view.dart';

import 'package:flutter/material.dart';

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
    extends State<MyOrdersPickupDetailsScreen> {
  final serialkey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _buttonKey = GlobalKey(); // Button key
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    // Initialize focus nodes
    _focusNodes = List.generate(widget.quantity, (_) => FocusNode());

    // Add listener to scroll button into view
    for (var node in _focusNodes) {
      node.addListener(() {
        if (node.hasFocus) _scrollToButton();
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize serial controllers
      var orderProvider =
          Provider.of<MyOrderProvider>(context, listen: false);
      orderProvider.initializeControllers(widget.quantity);
    });
  }

  void _scrollToButton() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_buttonKey.currentContext != null) {
        Scrollable.ensureVisible(
          _buttonKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          alignment: 0.5,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var node in _focusNodes) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyOrderProvider, LoginProvider>(
      builder: (context, order, log, child) {
        return Scaffold(
          backgroundColor:CleanerAppcolors.primaryWhitecolor ,
   appBar:       AppBar(
            centerTitle: true,
            backgroundColor: CleanerAppcolors.primaryWhitecolor,
            scrolledUnderElevation: 0,
            title: Text('Drop Off Details', style: appbartitlefont),
          ),
  body: NoInternetBanner(
    child: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _scrollController,
          reverse: true, // important: scrolls from bottom
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
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
                          paymentreceived: widget.paymentreceived ?? 'N/A',
                          pendingamount: widget.pendingamount ?? 'N/A',
                          paymenttype: widget.payementtype ?? 'N/A',
                          companyname: widget.companyname,
                          comment: widget.comment,
                          customerContact: widget.customercontact,
                        ),
                SizedBox(height: 20),
                FormCard(
                  quantity: widget.quantity,
                  focusNodes: _focusNodes,
                  buttonKey: _buttonKey,
                ),
                SizedBox(height: 20),
                CleanerButton.elevated(
                  backgroundcolor: CleanerAppcolors.primarypurple,
                  key: _buttonKey,
                  width: double.infinity,
                  label: "Update Order",
                  onPressed: () {},
                ),
              ],
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
