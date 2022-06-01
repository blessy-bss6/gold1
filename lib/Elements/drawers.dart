import 'package:flutter/material.dart';
import '../Elements/button.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  dynamic dbtn = 'Menu';
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(shrinkWrap: true, children: <Widget>[
      //  orc Custom Header file
      // CusDrawerHeader(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Btn(
                height: 40,
                margin: EdgeInsets.all(5),
                btnName: 'Menu',
                // color: FaqBgColor,
                color: dbtn == 'Menu' ? orangeColor : FaqBgColor,
                onTap: () => setState(() {
                  dbtn = 'Menu';
                }),
                style: TextStyle(
                    color: dbtn == 'Menu' ? txtWhiteColor : blackColor),
              ),
            ),
            Expanded(
              child: Btn(
                height: 40,
                margin: EdgeInsets.all(5),
                // color: FaqBgColor,
                color: dbtn == 'Categories' ? orangeColor : FaqBgColor,
                style: TextStyle(
                    color: dbtn == 'Categories' ? txtWhiteColor : blackColor),
                btnName: 'Categories',
                onTap: () => setState(() {
                  dbtn = 'Categories';
                }),
              ),
            ),
          ],
        ),
      ),

      Container(
          child: dbtn == 'Categories'
              ? Container(
                  child: ListView.builder(
                      controller: ScrollController(),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, i) => CategoryList()))
              : MenuDrawerList()),
    ]));
  }
}

// ! DRAWER List
class MenuDrawerList extends StatelessWidget {
  const MenuDrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, i) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                height: 40,
                alignment: Alignment.center,
                child: Text('item $i', style: labelTextStyle),
              )),
    );
  }
}

// ! Category List
class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  dynamic category1 = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category1 == false) {
          setState(() {
            category1 = true;
          });
        } else {
          setState(() {
            category1 = false;
          });
        }
      },
      child: Column(
        children: [
          // ! Category 1
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black12))),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Txt(t: 'Category ', style: labelTextStyle),
                ),
                IconButton(
                  onPressed: () {
                    if (category1 == false) {
                      setState(() {
                        category1 = true;
                      });
                    } else {
                      setState(() {
                        category1 = false;
                      });
                    }
                  },
                  icon: Icon(category1 == true
                      ? Icons.arrow_drop_down
                      : Icons.chevron_right_sharp),
                  color: category1 == true ? orangeColor : blackColor,
                )
              ],
            ),
          ),

          Container(
            child: category1 == true
                ? Container(
                    child: ListView.builder(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, i) => CategoryLevel2()),
                  )
                : null,
          )
        ],
      ),
    );
  }
}

class CategoryLevel2 extends StatefulWidget {
  const CategoryLevel2({Key? key}) : super(key: key);

  @override
  State<CategoryLevel2> createState() => _CategoryLevel2State();
}

class _CategoryLevel2State extends State<CategoryLevel2> {
  dynamic category2 = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category2 == false) {
          setState(() {
            category2 = true;
          });
        } else {
          setState(() {
            category2 = false;
          });
        }
      },
      child: Column(
        children: [
          // ! Category 1
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black12))),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text('Sub Category  ', style: smallTextStyle),
                ),
                IconButton(
                  onPressed: () {
                    if (category2 == false) {
                      setState(() {
                        category2 = true;
                      });
                    } else {
                      setState(() {
                        category2 = false;
                      });
                    }
                  },
                  icon: Icon(category2 == true
                      ? Icons.arrow_drop_down
                      : Icons.chevron_right_sharp),
                  color: category2 == true ? orangeColor : blackColor,
                )
              ],
            ),
          ),

          Container(
            child: category2 == true
                ? Container(
                    child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, i) => CategoryLevel3()),
                  )
                : null,
          )
        ],
      ),
    );
  }
}

class CategoryLevel3 extends StatefulWidget {
  const CategoryLevel3({Key? key}) : super(key: key);

  @override
  State<CategoryLevel3> createState() => _CategoryLevel3State();
}

class _CategoryLevel3State extends State<CategoryLevel3> {
  dynamic category3 = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category3 == false) {
          setState(() {
            category3 = true;
          });
        } else {
          setState(() {
            category3 = false;
          });
        }
      },
      child: Column(
        children: [
          // ! Category 1
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black12))),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text('Grand Child Category ', style: smallTextStyle),
                ),
                IconButton(
                  onPressed: () {
                    if (category3 == false) {
                      setState(() {
                        category3 = true;
                      });
                    } else {
                      setState(() {
                        category3 = false;
                      });
                    }
                  },
                  icon: Icon(category3 == true
                      ? Icons.arrow_circle_down_sharp
                      : Icons.chevron_right_sharp),
                  color: category3 == true ? orangeColor : blackColor,
                )
              ],
            ),
          ),

          Container(
            child: category3 == true
                ? Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    color: offWhiteColor,
                    height: 40,
                    child: Text('Product List'))
                // Container(child: ListView.builder(itemBuilder: (context,i) => CategoryLevel3()),)
                : null,
          )
        ],
      ),
    );
  }
}

// CusDrawerList(
//         title: 'Dashboard',
//         icon: Icons.speed,
//       ),
//       CusDrawerList(title: 'My Account', icon: Icons.person),
//       CusDrawerList(
//         title: 'Your Orders',
//         icon: Icons.shopping_bag,
//       ),
//       CusDrawerList(
//         title: 'Wishlist',
//         icon: Icons.favorite_border,
//       ),
//       CusDrawerList(title: 'Manage Address', icon: Icons.location_on),
//       CusDrawerList(title: 'Payment ', icon: Icons.payment),
//       CusDrawerList(
//         title: 'Offers',
//         icon: Icons.pages,
//       ),
//       CusDrawerList(
//         title: 'Notifictions',
//         icon: Icons.payment,
//       ),

/* -------------------------------------------------------------------------- */
/*               // ! P:-2. CUSTOM DRAWER LIST VIEW DATA                     */
/* -------------------------------------------------------------------------- */

class CusDrawerList extends StatelessWidget {
  final Widget? submitMethod;
  final String? title;
  final IconData? icon;

  CusDrawerList({
    Key? key,
    this.title,
    this.icon,
    this.submitMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => navigationPush(context, submitMethod!),
        // {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (BuildContext context) {
        //     return submitMethod();
        //   }));
        // },
        child: ListTile(
          title: Text(title!,
              style: TextStyle(fontFamily: poppinsMedium, fontSize: 14)),
          leading: Icon(
            icon,
            size: 20,
            color: offgreenColor,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ));
  }
}

class CusDrawerHeader extends StatelessWidget {
  CusDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Hey, Username! ',
              style: labelTextStyle,
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            iconSize: 25,
            onPressed: () => navigationPop(context),
          )
        ]);
  }
}
