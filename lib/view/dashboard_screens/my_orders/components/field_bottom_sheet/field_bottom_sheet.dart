import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FieldBottomSheet extends StatefulWidget {
  final String customername;
  final String pendingamount;
  final String paymentoption;
  final String paymentreceived;
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
  });

  @override
  State<FieldBottomSheet> createState() => _FieldBottomSheetState();
}

class _FieldBottomSheetState extends State<FieldBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearfields();
    });
  }

  void clearfields() {
    final myordersdata = Provider.of<MyOrderProvider>(context, listen: false);

    myordersdata.paymentreceivecontroller.clear();
    myordersdata.amountreceivecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final fieldkey = GlobalKey<FormState>();

    return Consumer<MyOrderProvider>(
      builder: (context, myorder, child) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: CleanerAppcolors.primarylightgreycolor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15).r,
              child: Form(
                key: fieldkey,
                child: Column(
                  spacing: 5.r,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomListtile(
                              title: 'Customer Name',
                              leading: Icon(
                                Icons.arrow_forward_ios,
                                size: 20.r,
                              ),
                              subtitle: widget.customername,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32).r,
                                    child: TextFormField(
                                      // validator:
                                      //     (value) => validateamount(
                                      //       value,
                                      //       widget.pendingamount,
                                      //     ),
                                      controller:
                                          myorder.amountreceivecontroller,
                                      keyboardType: TextInputType.number,
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
                                                    .primaryminigreycolor,
                                            width: 1.5.r,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                CleanerAppcolors
                                                    .primaryminidarkgreycolor,
                                            width: 1.5.r,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                CleanerAppcolors.primarypurple,
                                            width: 1.5.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
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
