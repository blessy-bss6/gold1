import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Screen/ProdList.dart';

import '../Elements/button.dart';

import '../Elements/imgScr.dart';
import '../Screen/cartScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../Backend/Bloc/home_Bloc.dart';
import 'CategoryScr.dart';
import 'LoginScr.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc prodBloc = HomeBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    prodBloc.add(FetchHomeEvent());
    super.initState();
  }

  final TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            // print(state);
            if (state is HomeSuccessState) {
              return CustomScrollView(
                slivers: [
                  // ! Sliver app Bar
                  SliverAppBar(
                    backgroundColor: offWhiteColor,
                    automaticallyImplyLeading: false,
                    title: Image.asset(
                      "assets/imgs/applogo.png",
                      fit: BoxFit.contain,
                      height: 50,
                      width: 150,
                    ),
                    centerTitle: true,
                    expandedHeight: 100.0,
                    floating: true,
                    pinned: true,
                    snap: true,
                    actionsIconTheme: IconThemeData(opacity: 0.0),
                    flexibleSpace: FlexibleSpaceBar(
                      // title: Text("Sliverappbar"),
                      centerTitle: true,
                      background: Image.asset(
                        "assets/imgs/topheader.png",
                        fit: BoxFit.fill,
                      ),
                      collapseMode: CollapseMode.pin,
                    ),
                    // flexibleSpace: Stack(
                    //   children: <Widget>[
                    //     Positioned.fill(
                    //         child: Image.asset(
                    //       "assets/imgs/topheader.png",
                    //       width: double.infinity,
                    //       height: double.maxFinite,
                    //       fit: BoxFit.fill,
                    //       ),
                    //       collapseMode: CollapseMode.pin,
                    //     )
                    //   ],
                    // ),

                    // actions: <Widget>[
                    //   IconButton(
                    //     icon: const Icon(Icons.login),
                    //     tooltip: 'Login',
                    //     onPressed: () => navigationPush(context, LoginScreen()),
                    //   ),
                    //   IconButton(
                    //     icon: const Icon(Icons.shopping_bag),
                    //     tooltip: 'Cart',
                    // //     onPressed: () => navigationPush(context, CartScreen()),
                    //   ),
                    // ],
                  ),
                  SliverToBoxAdapter(
                    child: ImgSlider(),
                  ),
                  

                  // ! First List
                  SliverPadding(
                    padding: const EdgeInsets.all(2),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Divider(),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Special Offers ',
                                style: labelTextStyle,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(4.0),
                    sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.9),
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return CategeoryGridProdList(
                            onTap: () =>
                                navigationPush(context, CategoryScreen()),
                            imageUrl:
                                '${state.category[index]["image"] != null ? state.category[index]["image"]['src'] : 'assets/imgs/prodcat2.png'}',
                            title: '${state.category[index]['name']}',
                          );
                        }, childCount: state.category.length)),
                  ),

                  SliverToBoxAdapter(
                    child: ImgSlider(),
                  ),
                  // ! First List
                  SliverPadding(
                    padding: const EdgeInsets.all(3),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Divider(),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'For Return Gift',
                                style: labelTextStyle,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(5.0),
                    sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.9),
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return CategeoryGridProdList(
                            onTap: () =>
                                navigationPush(context, ProductListScreen()),
                            imageUrl:
                                '${state.product[index]["images"].length > 0 ? state.product[index]["images"][0]['src'] : ''}',
                            title: state.product[index]['name'],
                          );
                        }, childCount: 6)),
                  )
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      // drawer: DrawerScreen(),
    );
  }
}

// !  Vertical list for Category
class CategoryListItem extends StatelessWidget {
  final dynamic cateList;

  CategoryListItem({Key? key, this.cateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('catelist data $cateList');
    //  print(cateList.runtimeType);
    //  print(cateList.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ! Title Value
              Text(
                'Shop By Category',
                style: labelTextStyle,
              ),

              Btn(
                padding: EdgeInsets.only(left: 6, right: 6),
                height: 30,
                btnName: 'VIEW ALL',
                style: TextStyle(fontSize: 13, color: blackColor),
                color: Color.fromARGB(246, 200, 200, 214),
                onTap: () => navigationPush(context, CategoryScreen()),
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cateList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 8, right: 8, bottom: 3),
                child: InkWell(
                  onTap: () => navigationPush(context, CategoryScreen()),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ! Pic Section
                      Container(
                        child: Pics(
                          networkImg: true,
                          src: cateList[i]['src'].toString(),
                          height: 120,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      heightSizedBox(1.0),
                      // ! Bottom Name
                      Container(
                        margin: EdgeInsets.only(top: 0.0),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          ' ${cateList[i]['name']}',
                          style: mediumTextStyle,
                        ),
                      ),
                      // ! Bottom Name
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${cateList[i]['count']} product',
                          style: smallTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Product GridList
