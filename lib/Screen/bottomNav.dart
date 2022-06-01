import 'package:flutter/material.dart';
import '/Screen/prodList2.dart';
import '../utils/shared_helper.dart';
import '../utils/style.dart';

import 'OrderDetScr.dart';
import 'cartScr.dart';
import 'CategoryScr.dart';
import 'HomeScr.dart';
import 'ProdList.dart';
import 'ProfileScr.dart';
import 'subCategoryScr.dart';

class UserNavigationBar extends StatefulWidget {
  final int? sellerId;
  int? currentTab;
  Widget? currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserNavigationBar({Key? key, this.currentTab, this.sellerId}) {
    if (currentTab == null) currentTab = 0;
  }
  @override
  _UserNavigationBarState createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  @override
  initState() {
    super.initState();
    _selectTab(widget.currentTab!);
  }

  SharedHelper sharedHelper = SharedHelper();
  dynamic isLogin = false;

  _checkLogin() async {
    bool isUser = await sharedHelper.containsKey('userIdType');
    bool isLog = await sharedHelper.containsKey('current_user');

    setState(() {
      isLogin = isLog;
    });
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeScreen();
          break;
        case 1:
          widget.currentPage = CategoryScreen();
          break;

        case 2:
          // widget.currentPage = ProductListScreen();
          widget.currentPage = ProductShowScreen();
          break;
        case 3:
          widget.currentPage = CartScreen();
          break;

        case 4:
          widget.currentPage = OrderDeatilsScreen();

          break;
        case 5:
          widget.currentPage = ProfileScreen();

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: yellowColor,
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        unselectedItemColor: offWhiteColor,
        iconSize: 25,
        // backgroundColor: offWhiteColor,
        backgroundColor: coffeColor,
        currentIndex: widget.currentTab!,
        showSelectedLabels: true,
        selectedFontSize: 12,

        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
            fontSize: 12, color: coffeColor, fontFamily: poppinsMedium),

        unselectedLabelStyle: TextStyle(
            fontSize: 12, color: Colors.black38, fontFamily: poppinsMedium),
        unselectedFontSize: 12,

        onTap: (int i) {
          this._selectTab(i);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-5.png',
              height: 22,
              color: widget.currentTab == 0 ? yellowColor : offWhiteColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-2.png',
              height: 22,
              color: widget.currentTab == 1 ? yellowColor : offWhiteColor,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard_outlined,
              size: 22,
              color: widget.currentTab == 2 ? yellowColor : offWhiteColor,
            ),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 22,
              //  Image.asset(
              //   'assets/icons/bottom-4.png',
              // height: 22,
              color: widget.currentTab == 3 ? yellowColor : offWhiteColor,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
              size: 22,
              //  Image.asset(
              //   'assets/icons/bottom-1.png',
              //   height: 22,
              color: widget.currentTab == 4 ? yellowColor : offWhiteColor,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 22,
              color: widget.currentTab == 5 ? yellowColor : offWhiteColor,
            ),
            // icon: Image.asset(
            //   'assets/icons/bottom-3.png',
            //   height: 22,
            //   color: widget.currentTab == 2 ? coffeColor : Colors.black38,
            // ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
