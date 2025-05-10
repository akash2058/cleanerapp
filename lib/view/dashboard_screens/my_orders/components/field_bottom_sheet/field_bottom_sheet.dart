import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldBottomSheet extends StatelessWidget {
  final String customername;
  final String pendingamount;
  final String paymentoption;
  final String paymentreceived;
  const FieldBottomSheet({super.key, required this.customername, required this.pendingamount, required this.paymentoption, required this.paymentreceived});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CleanerAppcolors.primarylightgreycolor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          child: Column(
            spacing: 5.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomListtile(
                        title: 'Customer Name',
                        leading: Icon(Icons.arrow_forward_ios, size: 20.r),
                        subtitle: customername,
                      ),
                     if(paymentoption =='cash_on_delivery'&& pendingamount != '0')
                     CustomListtile(title: 'Pickup Amount',subtitle: pendingamount,leading: Icon(Icons.arrow_forward_ios,size: 20.r,),),
                     SizedBox(
                      height: 10.r,
                     ),
                      Row(
                        spacing: 10.r,
                        children: [Icon(Icons.arrow_forward_ios, size: 20.r),
                          Text('Amount Received',style: resendfont,),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 32).r,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: enterserialnumber,
                          style: entertexttile,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10).r,
                            hintText: 'Enter received amount',
                            hintStyle: hintStyle,
                            errorStyle: errorstyle,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CleanerAppcolors
                                        .primaryminigreycolor, // change this to your color
                                width: 1.5.r, // change thickness here
                              ),
                            ),
                            // 🔽 Default border when not focused
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CleanerAppcolors
                                        .primaryminidarkgreycolor, // change this to your color
                                width: 1.5.r, // change thickness here
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
                      ),
                    ],
                  ),
                ),
              ),
              CleanerButton.elevated(
                height: 55.r,
                backgroundcolor: CleanerAppcolors.primarypurple,
                width: MediaQuery.sizeOf(context).width,
                label: 'Confirm',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
