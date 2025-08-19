import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FormCard extends StatelessWidget {
  final int quantity;
  final List<FocusNode> focusNodes; // Focus nodes from parent
  final GlobalKey buttonKey; // Update button key
  final BuildContext parentContext; // Needed for MediaQuery

  const FormCard({
    super.key,
    required this.quantity,
    required this.focusNodes,
    required this.buttonKey,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        return DecoratedBox(
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
                  children: [
                    Icon(Icons.file_copy_outlined, size: 20.r),
                    SizedBox(width: 5.r),
                    Text('Fill the form', style: ordercardheaderfont),
                  ],
                ),
                Divider(color: CleanerAppcolors.primaryminigreycolor),
                SizedBox(height: 10.r),
                Column(
                  children: List.generate(quantity, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Serial Number ${index + 1}',
                          style: splashloadingfond,
                        ),
                        TextFormField(
                          controller: order.serialControllers[index],
                          focusNode: focusNodes[index],
                          validator: enterserialnumber,
                          onChanged:
                              (value) => order.updateSerial(index, value),
                          onTap: () {
                            // Wait for keyboard to open
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                final keyboardHeight =
                                    MediaQuery.of(
                                      parentContext,
                                    ).viewInsets.bottom;
                                if (keyboardHeight > 0 &&
                                    buttonKey.currentContext != null) {
                                  Scrollable.ensureVisible(
                                    buttonKey.currentContext!,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    alignment: 0.9,
                                  );
                                }
                              },
                            );
                          },

                          style: entertexttile,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10).r,
                            hintText: 'Enter serial number',
                            hintStyle: hintStyle,
                            errorStyle: errorstyle,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: CleanerAppcolors.primaryminigreycolor,
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
                        SizedBox(height: 20.r),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
