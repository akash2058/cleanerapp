import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FormCard extends StatelessWidget {
  final int quantity;
  final List<FocusNode> focusNodes;
  final GlobalKey buttonKey;

  const FormCard({
    super.key,
    required this.quantity,
    required this.focusNodes,
    required this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(builder: (context, order, child) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: CleanerAppcolors.primaryminigreycolor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              quantity < order.serialControllers.length
                  ? quantity
                  : order.serialControllers.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Serial Number ${index + 1}', style: splashloadingfond),
                  TextFormField(
                    focusNode: focusNodes[index],
                    controller: order.serialControllers[index],
                    validator: enterserialnumber,
                    style: entertexttile,
                    onChanged: (value) => order.updateSerial(index, value),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10).r,
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
                    onTap: () {
                      // Scroll button into view when TextField tapped
                      if (buttonKey.currentContext != null) {
                        Scrollable.ensureVisible(
                          buttonKey.currentContext!,
                          duration: const Duration(milliseconds: 300),
                          alignment: 0.5,
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
    });
  }
}
