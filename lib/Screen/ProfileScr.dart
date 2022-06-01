import 'package:flutter/material.dart';
import '/Screen/splashScr.dart';
import '../Backend/Resp/reg_login_resp.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/notificationScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';
import 'OrderDetScr.dart';
import 'ServicesScr/servicesScr.dart';
import 'ServicesScr/servicesContent.dart';

import 'bottomNav.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(context, true,
          widget: UserNavigationBar(currentTab: 0)),
      child: Scaffold(
        appBar: BaseAppBar(title: 'Profile'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              heightSizedBox(10.0),
              Text('Account Settings', style: liteHeadingTS),

              ProfileCard(
                cardText: 'Personal Information',
                icon: Icons.person_add_alt,
                // onTap: () => navigationPush(context, OrderDeatilsScreen()),
              ),
              ProfileCard(
                cardText: 'Orders',
                icon: Icons.shopping_bag,
                onTap: () => navigationPush(context, OrderDeatilsScreen()),
              ),
              // ProfileCard(
              //   cardText: 'Address & Homes',
              //   icon: Icons.home,
              //   onTap: () => navigationPush(context, NotificationScreen()),
              // ),
              ProfileCard(
                cardText: 'Notifications',
                icon: Icons.notifications,
                onTap: () => navigationPush(context, NotificationScreen()),
              ),
              // heightSizedBox(10.0),
              // ProfileCard(
              //   cardText: 'Get Help ',
              //   icon: Icons.help,
              // ),
              ProfileCard(
                cardText: 'Shipment Policy',
                icon: Icons.help,
                onTap: () => navigationPush(
                    context,
                    ServicesScreen2(
                      title: 'Shipment Policy',
                      lName: shipList,
                    )),
              ),
              ProfileCard(
                cardText: 'About Us ',
                icon: Icons.info,
                onTap: () => navigationPush(
                    context,
                    ServicesScreen(
                      title: 'About Us',
                      lName: aboutUsList,
                    )),
              ),
              ProfileCard(
                cardText: 'Privacy Policies ',
                icon: Icons.policy,
                onTap: () => navigationPush(
                    context,
                    ServicesScreen(
                      title: 'Privacy Policies',
                      lName: policyList,
                    )),
              ),
              ProfileCard(cardText: 'Feedback', icon: Icons.feedback),
              // heightSizedBox(10.0),
              ProfileCard(
                cardText: 'Terms & Condition ',
                icon: Icons.policy_outlined,
                onTap: () => navigationPush(
                    context,
                    ServicesScreen2(
                      title: 'Terms & Condition',
                      lName: aboutUsList,
                    )),
              ),
              ProfileCard(
                cardText: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  logout();
                  navigationPush(context, SplashScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String cardText;
  final String? imagePath;
  final VoidCallback? onTap;
  final IconData? icon;

  ProfileCard({required this.cardText, this.icon, this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cardText,
                    style: TextStyle(fontSize: 14.0, fontFamily: poppinsMedium),
                  ),
                ),
                // Image.asset(imagePath, height: 20)
                // Image.asset(profileIcon)
                Icon(
                  icon,
                  size: 20,
                  color: Colors.black38,
                )
              ],
            ),
          ),
        ),
        divider(),
      ],
    );
  }
}
