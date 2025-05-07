import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IsDamagedDetailpage extends StatelessWidget {
  const IsDamagedDetailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(builder: (context, myorder, child) {
      return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('IsDamagedDetail',style: appbartitlefont,),
        ),
      );
    },);
  }
}