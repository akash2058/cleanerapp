import 'package:binbookingapp/custom_widget/custom_tile.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/authentication/login/login_provider/login_provider.dart'
    show LoginProvider;
import 'package:binbookingapp/view/dashboard_screens/profile/components/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, log, child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.r,
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: CleanerAppcolors.primaryminigreycolor,
            title: Text('Profile', style: appbartitlefont),
          ),
          backgroundColor: CleanerAppcolors.primaryminigreycolor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
            child: Column(
              spacing: 10.r,
              children: [
                ProfileCard(),
                Divider(),
                CustomListtile(
                  leading: Icon(Icons.place_outlined, size: 30.r),
                  title: 'Address',
                  subtitle: log.address,
                ),
                CustomListtile(
                  leading: Icon(Icons.phone_outlined, size: 30.r),
                  title: 'Contact',
                  subtitle: log.contact,
                ),
                CustomListtile(
                  leading: Icon(
                    log.gender == 'male'
                        ? Icons.person_outline
                        : Icons.person_2_outlined,
                    size: 30.r,
                  ),
                  title: 'Gender',
                  subtitle: log.gender,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
