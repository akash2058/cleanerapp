import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FieldBottomSheet extends StatefulWidget {
  final String customername;
  final String pendingamount;
  final String paymentoption;
  final String paymentreceived;
  final String customeraddress;
  final String customercontact;
  final String binbookingid;
  final String logid;
  const FieldBottomSheet({
    super.key,
    required this.customername,
    required this.pendingamount,
    required this.paymentoption,
    required this.paymentreceived,
    required this.binbookingid,
    required this.logid,
    required this.customeraddress,
    required this.customercontact,
  });

  @override
  State<FieldBottomSheet> createState() => _FieldBottomSheetState();
}

class _FieldBottomSheetState extends State<FieldBottomSheet> {
  final fieldkey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearfields();
    });
    // Listen for focus changes to scroll to the bottom
    _amountFocusNode.addListener(() {
      if (_amountFocusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  void clearfields() {
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);
    myordersdata.paymentreceivecontroller.clear();
    myordersdata.amountreceivecontroller.clear();
  }

  void _scrollToBottom() {
    // Delay to ensure keyboard is fully visible
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients && mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyOrderProvider, BinRequestProvider>(
      builder: (context, myorder, binr, child) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: CleanerAppcolors.primarylightgreycolor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20).r,
              child: Form(
                key: fieldkey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 60.r,
                    top: 20.r,
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomListtile(
                        title: 'Customer Name',
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.r,
                        ),
                        subtitle: capitalizeEachPart(widget.customername),
                      ),
                      CustomListtile(
                        trailing: GestureDetector(
                          onTap: () {
                            binr.copyToClipboard(widget.customeraddress, context);
                          },
                          child: Icon(Icons.copy_all_outlined, size: 30.r),
                        ),
                        title: 'Location',
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.r,
                        ),
                        subtitle: capitalizeEachPart(widget.customeraddress),
                      ),
                      CustomListtile(
                        trailing: GestureDetector(
                          onTap: () {
                            binr.launchDialer(widget.customercontact, context);
                          },
                          child: Icon(Icons.call_outlined, size: 30.r),
                        ),
                        title: 'Customer number',
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.r,
                        ),
                        subtitle: widget.customercontact,
                      ),
                      if (widget.paymentoption == 'cash_on_delivery' &&
                          widget.pendingamount != '0')
                        CustomListtile(
                          title: 'Pickup Amount',
                          subtitle: widget.pendingamount,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 20.r,
                          ),
                        ),
                      SizedBox(height: 10.r),
                      if (!(widget.paymentoption == 'cash_on_order' &&
                          widget.pendingamount != '0'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_forward_ios, size: 20.r),
                                SizedBox(width: 10.r),
                                Text(
                                  'Amount Received',
                                  style: resendfont,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32).r,
                              child: TextFormField(
                                focusNode: _amountFocusNode,
                                validator: (value) => validateAmount(
                                  value,
                                  widget.pendingamount,
                                ),
                                controller: myorder.amountreceivecontroller,
                                keyboardType: TextInputType.number,
                                style: entertexttile,
                                onTap: () {
                                  // Ensure scroll on every tap
                                  _scrollToBottom();
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ).r,
                                  hintText: 'Enter received amount',
                                  hintStyle: hintStyle,
                                  errorStyle: errorstyle,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CleanerAppcolors.primaryminidarkgreycolor,
                                      width: 1.5.r,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CleanerAppcolors.primarypurple,
                                      width: 1.5.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 30.r),
                      CleanerButton.elevated(
                        isloading: myorder.loadingconfirmonsitepickup,
                        height: 55.r,
                        backgroundcolor: CleanerAppcolors.primarypurple,
                        width: MediaQuery.sizeOf(context).width,
                        label: 'Confirm',
                        onPressed: () {
                          if (fieldkey.currentState!.validate()) {
                            myorder.getConfirmonsiteupdate(
                              context,
                              widget.logid,
                              widget.binbookingid,
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
            .map((word) {
              String lowerWord = word.toLowerCase();

              // If it's exactly 2 letters, make both uppercase
              if (lowerWord.length == 2 &&
                  RegExp(r'^[a-zA-Z]{2}$').hasMatch(lowerWord)) {
                return lowerWord.toUpperCase();
              }

              // If contains slash like a/a, capitalize both parts
              if (word.contains('/')) {
                return word
                    .split('/')
                    .map(
                      (w) =>
                          w.isNotEmpty
                              ? w[0].toUpperCase() +
                                  w.substring(1).toLowerCase()
                              : '',
                    )
                    .join('/');
              }

              // Default capitalization
              return word[0].toUpperCase() + word.substring(1).toLowerCase();
            })
            .join(' ');
      })
      .join(', ');
}
