import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.quantity});

  final int quantity;
  @override
  Widget build(BuildContext context) {

    return Consumer<MyOrderProvider>(builder: (context, order, child) {
      return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: CleanerAppcolors.primaryminigreycolor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 5.r,
                children: [
                  Icon(Icons.file_copy_outlined, size: 20.r),
                  Text('Fill the form', style: ordercardheaderfont),
                ],
              ),
              Divider(
                color: CleanerAppcolors.primaryminigreycolor,
              ),
              SizedBox(height: 10.r),
              Column(
                children: List.generate(
                 order.serialControllers.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serial Number ${index + 1}',
                        style: splashloadingfond,
                      ),
                      TextFormField(
                        validator: enterserialnumber,
                        onChanged: (value) => order.updateSerial(index, value),
                        controller: order.serialControllers[index],
                        style: entertexttile,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10).r,
                          hintText: 'Enter serial number',
                          hintStyle: hintStyle,
                          errorStyle: errorstyle,
          
                          // 🔽 Default border when not focused
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminigreycolor, // change this to your color
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
                      SizedBox(
                        height: 20.r,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    },);
  }
}
