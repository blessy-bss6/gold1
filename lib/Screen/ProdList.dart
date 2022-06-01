import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/ProdDetails.dart';
import '../utils/common.dart';

import '../Backend/Bloc/prod_Bloc.dart';
import 'CategoryScr.dart';
import 'bottomNav.dart';
import 'prodList2.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Widget> tabs = [];

  ProductBloc prodBloc = ProductBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    prodBloc.add(FetchProdEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(context, true,
          widget: UserNavigationBar(currentTab: 0)),
      child: Scaffold(
        body:
            // BlocProvider(
            //   create: (BuildContext context) =>
            //       ProductBloc()..add(FetchProdEvent()),
            // child:
            BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {},
                builder: (context, state) {
                  // print(state);
                  if (state is ProdSuccessState) {
                    return CustomScrollView(
                      slivers: [
                        // ! Sliver app Bar

                        SliverAppBars(
                          title: 'Product List',
                        ),

                        //  ! Sliver Product Content

                        SliverPadding(
                          padding: const EdgeInsets.all(5.0),
                          sliver: SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.9),
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                // print(state.data[index]);
                                return CategeoryGridProdList(
                                  // onTap: () => navigationPush(context, ProductShowScreen()),
                                  imageUrl:
                                      '${state.data[index]["images"].length > 0 ? state.data[index]["images"][0]['src'] : ''}',
                                  title: state.data[index]['name'],
                                  onTap: () => navigationPush(
                                      context,
                                      ProdDetailScreen(
                                          prodNumber: state.data[index])),
                                );
                              }, childCount: state.data.length)),
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
      ),
      // ),
    );
  }
}

class ProductSubCategoryScreen extends StatelessWidget {
  final String? categoryId;
  ProductSubCategoryScreen({Key? key, this.categoryId}) : super(key: key);

  final List<Widget> tabs = [];

  // dynamic Order;

  // dynamic OrderItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) =>
            ProductBloc()..add(FetchSubProdEvent(categoryId: categoryId)),
        child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              // print(state);
              if (state is ProdSuccessState) {
                return CustomScrollView(
                  slivers: [
                    // ! Sliver app Bar

                    SliverAppBars(
                      title: 'Product List',
                    ),

                    //  ! Sliver Product Content

                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, i) {
                      return InkWell(
                          onTap: () => navigationPush(context,
                              ProdDetailScreen(prodNumber: state.data[i])),
                          child: CheckProd1(
                            prodNumber: state.data[i],
                            // cartData: state.cartData["data"],
                          ));
                    }, childCount: state.data.length))

                    // SliverPadding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   sliver: SliverGrid(
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         childAspectRatio:
                    //             MediaQuery.of(context).size.width /
                    //                 (MediaQuery.of(context).size.height / 1.9),
                    //         mainAxisSpacing: 10.0,
                    //         crossAxisSpacing: 10.0,
                    //       ),
                    //       delegate:
                    //           SliverChildBuilderDelegate((context, index) {
                    //         // print('${state.data[index]}');
                    //         return CategeoryGridProdList(
                    //           // onTap: () => navigationPush(context, ProductShowScreen()),
                    //           imageUrl:
                    //               '${state.data[index]["images"][0]['src']}',
                    //           title: state.data[index]['name'],
                    //           onTap: () => navigationPush(
                    //               context,
                    //               ProdDetailScreen(
                    //                   prodNumber: state.data[index])),
                    //         );
                    //       }, childCount: state.data.length)),
                    // ),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
