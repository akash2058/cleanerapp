import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/components/my_orders_card.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/detailscreen/my_orders_pickup_details_screen.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/my_orders_provider/my_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyOrdersPickUpList extends StatelessWidget {
  const MyOrdersPickUpList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, order, child) {
        final siteRequests = order.order?.data.siteOrder ?? [];

        if (siteRequests.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 250.r),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(AppIcons.nodatafound, height: 70.r),
                    Text('No Pick Up Request Found', style: resendfont),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          spacing: 15.r,
          children: List.generate(siteRequests.length, (index) {
            var sitedata = siteRequests[index];
            return MyOrdersCard(
              onPressed: () {
                if (sitedata.stage == 'order_picked_up'&& sitedata.type =='on_site_order') {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('lol')));
                } else {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: MyOrdersPickupDetailsScreen(
                        binsizename: sitedata.binSizeName,
                        duration: sitedata.orderDuration.toString(),
                        customername: sitedata.customerName,
                        startDate: sitedata.startDate,
                        endate: sitedata.endDate,
                        quantity: sitedata.quantity,
                        location: sitedata.location,
                        bookingid: sitedata.id.toString(),
                      ),
                    ),
                  );
                }
              },
              address: sitedata.location,
              quantity: sitedata.quantity.toString(),
              startdate: sitedata.startDate,
              endDate: sitedata.endDate,
              binsizename: sitedata.binSizeName,
              buttonlabel:
                  sitedata.stage == 'order_picked_up' && sitedata.type == 'warehouse_dropoff'
                      ? 'Confirm Delivery'
                      : 'View',
              stage: '',
            );
          }),
        );
      },
    );
  }
}
