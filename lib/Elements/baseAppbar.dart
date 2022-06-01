import 'package:flutter/material.dart';

import '../utils/style.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  final double? elevation;
  final bool? boolLeading;
  final bool? centerTitle;
  final Widget? leading, bottomChild;
  final Function? onTap;
  final String? title;
  final List<Widget>? actionList;
  final Color? bgColor, txtColor;
  final dynamic leadingOnTap;

  BaseAppBar(
      {this.boolLeading,
      this.bottomChild,
      this.elevation,
      this.leading,
      this.centerTitle,
      this.onTap,
      this.title,
      this.bgColor,
      this.txtColor,
      this.leadingOnTap,
      this.actionList});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? coffeColor,
      elevation: elevation,
      // automaticallyImplyLeading: boolLeading ?? true,
      // leading: leading,
      // leading: leading != null
      //     ? leading
      //     : boolLeading == false
      //         ? null
      //         : IconButton(
      //             iconSize: 28,
      //             icon: Icon(Icons.chevron_left_sharp, color: txtWhiteColor),
      //             onPressed: leadingOnTap ?? () => Navigator.of(context).pop(),
      //           ),
      title: title != null
          ? Text(title!,
              style: TextStyle(
                  fontFamily: poppinsMedium, color: txtColor ?? orangeColor))
          : null,
      centerTitle: centerTitle ?? false,
      actions: actionList,
      bottom: bottomChild != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(child: bottomChild),
              ))
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

// ! SLIVER APP BAR
class SliverAppBars extends StatelessWidget {
  final Widget? bottomChild;
  final double? elevation;
  final bool? boolLeading;

  final Widget? leading;
  final Function? onTap;
  final String? title;
  final List<Widget>? actionList;
  final Color? bgColor, txtColor;
  final double? toolBarHeight;
  SliverAppBars(
      {Key? key,
      this.bottomChild,
      this.actionList,
      this.bgColor,
      this.boolLeading,
      this.elevation,
      this.leading,
      this.title,
      this.txtColor,
      this.toolBarHeight = 50,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: coffeColor,
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: true,
      // toolbarHeight:toolBarHeight ,

      elevation: elevation,
      // automaticallyImplyLeading: boolLeading ?? true,
      // leading: leading != null
      //     ? leading
      //     : boolLeading == false
      //         ? null
      //         : IconButton(
      //             iconSize: 28,
      //             icon: Icon(Icons.chevron_left_sharp, color: txtWhiteColor),
      //             onPressed: () => Navigator.of(context).pop(),
      //           ),
      // title: Text(
      //   'All Category ',
      //   style: appBarTS,
      // ),
      title: title != null
          ? Text(title!,
              style: TextStyle(
                  fontFamily: poppinsMedium, color: txtColor ?? txtWhiteColor))
          : null,
      actions: actionList,
      bottom: bottomChild != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(child: bottomChild))
          : null,
    );
  }
}
