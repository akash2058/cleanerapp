import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_provider/bin_request_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/bin_request_tab/bin_request_tabs.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_drop_off_list.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/components/bin_request_pickup_list.dart';

class BinRequestView extends StatelessWidget {
  const BinRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BinRequestProvider>(
      builder: (context, binr, child) {
        return Consumer<LoginProvider>(
          builder: (context, log, child) {
            return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0.r,
                backgroundColor: CleanerAppcolors.primaryminigreycolor,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text('Bin Request', style: appbartitlefont),
              ),
              backgroundColor: CleanerAppcolors.primaryminigreycolor,
              body: binr.loadingbinbooking
                  ? Center(
                      child: LoadingAnimationWidget.hexagonDots(
                        color: CleanerAppcolors.primarypurple,
                        size: 40.r,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => binr.getBinRequestData(),
                      child: Column(
                        children: [
                            Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 10).r,
                              child: BinRequestTabs(),
                            ),
                              SizedBox(height: 10.r),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,).r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    binr.currenttab == 0
                                        ? BinRequestDropoffList()
                                        : BinRequestPickupList(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
