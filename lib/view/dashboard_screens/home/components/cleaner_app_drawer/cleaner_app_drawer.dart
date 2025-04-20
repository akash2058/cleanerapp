
import 'package:binbookingapp/custom_widget/cleaner_chip.dart';
import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/cleanericonspng.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart';
import 'package:binbookingapp/view/dashboard/dashboard_provider/dashboard_provider.dart';
import 'package:binbookingapp/view/dashboard_screens/profile/components/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CleanerAppDrawer extends StatelessWidget {
  const CleanerAppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dash, child) {
      return Consumer<LoginProvider>(builder: (context, log, child) {
        return Drawer(
      width: 350.r,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 90).r,
        child: Column(
          spacing: 15.r,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(),
            CustomListtile(
              onTap: () {
                dash.screenTabs(dash.currenttab =1);
              },
              leading: Image.asset(
                AppIcons.requesticon,
                height: 20.r,
              ),
              title: 'Bin Request',
            ),
            CustomListtile(
              onTap: () {
                dash.screenTabs(dash.currenttab =2);
              },
              leading: Image.asset(
                AppIcons.myordersicon,
                height: 20.r,
              ),
              title: 'My Orders',
            ),
            CustomListtile(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    actions: [
                    CleanerChip(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'Cancel',backgroundColor: CleanerAppcolors.primaryGreencolor,),
                    CleanerChip(
                      onPressed: () {
                   
                      },
                      label:log.loadinglogout == true?'Please Wait': 'Logout',backgroundColor: CleanerAppcolors.primaryRedcolor,)
                    ],
                    title: Center(child: Text('Log out of your account?',style: dashboardlabelfontblack,)),
                  );
                },);
              },
              leading: Icon(
                Icons.logout,
                size: 20.r,
              ),
              title: 'Logout',
            ),
          ],
        ),
      ),
    );
      },);
    },);
  }
}
