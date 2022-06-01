import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../Elements/formfield.dart';
import '../Screen/subCategoryScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../Backend/Bloc/category_Bloc.dart';
import 'bottomNav.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? searchController = TextEditingController();

  dynamic pageNum = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => willPopCallback(context, true,
          widget: UserNavigationBar(currentTab: 0)),
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) =>
              CategoryBloc()..add(FetchCategoryEvent()),
          child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {},
              builder: (context, state) {
                // print(state);
                if (state is CategorySuccessState) {
                  return state.data.length > 0
                      ? CustomScrollView(
                          slivers: [
                            // ! Sliver app Bar
                            SliverAppBar(
                              title: Text('CategoryList'),
                              centerTitle: true,
                              automaticallyImplyLeading: false,
                              backgroundColor: coffeColor,
                              // title: 'Category List',
                              // bottomChild: Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 5.0, horizontal: 15.0),
                              //     child: SearchBox(
                              //       controller: searchController,
                              //     ),
                              //   ),
                              // ),
                            ),
    
                            // ! Category List
                            SliverPadding(
                              padding: const EdgeInsets.all(5.0),
                              sliver: SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width /
                                            (MediaQuery.of(context).size.height /
                                                1.9),
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                               
                                    return CategeoryGridProdList(
                                      // imageUrl: null,
    
                                      imageUrl:
                                          '${state.data[index]["image"] != null ? state.data[index]["image"]['src'] : 'assets/imgs/prodcat2.png'}',
                                      title: '${state.data[index]['name']}',
                                      onTap: () => navigationPush(
                                          context,
                                          SubCategoryScreen(
                                            pageNum: pageNum.toString(),
                                            parent: state.data[index]['parent']
                                                .toString(),
                                          )),
                                    );
                                  }, childCount: state.data.length)),
                            ),
    
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: pageNum != 1? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Btn(
                                          height: 40,
                                          btnName: 'Next',
                                          color: coffeColor,
                                          onTap: () {
                                            setState(() {
                                              pageNum = pageNum + 1;
                                            });
                                            BlocProvider.of<CategoryBloc>(context,
                                                listen: false)
                                              ..add(FetchCategoryEvent(
                                                  pageNum: pageNum.toString()));
                                          },
                                        ),
                                      )),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Expanded(
                                          child: Container(
                                              child: pageNum > 1
                                                  ? Btn(
                                                      height: 40,
                                                      btnName: 'Previous',
                                                      color: coffeColor,
                                                      onTap: () {
                                                        setState(() {
                                                          pageNum = pageNum - 1;
                                                        });
                                                        BlocProvider.of<
                                                                CategoryBloc>(
                                                            context,
                                                            listen: false)
                                                          ..add(FetchCategoryEvent(
                                                              pageNum: pageNum
                                                                  .toString()));
                                                      },
                                                    )
                                                  : null)),
                                    ]) :Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Btn(
                                          height: 40,
                                          btnName: 'Next',
                                          color: coffeColor,
                                          onTap: () {
                                            setState(() {
                                              pageNum = pageNum + 1;
                                            });
                                            BlocProvider.of<CategoryBloc>(context,
                                                listen: false)
                                              ..add(FetchCategoryEvent(
                                                  pageNum: pageNum.toString()));
                                          },
                                        ),
                                      )),
                                      
                                    ]),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text("No Data"),
                        );
                }
    
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

// ! Category ProdList
class CategeoryGridProdList extends StatelessWidget {
  final String? title;
  final String? imageUrl;

  final dynamic onTap;
  final bool? fromSubProducts;
  const CategeoryGridProdList(
      {Key? key,
      this.title,
      this.imageUrl,
      this.onTap,
      this.fromSubProducts = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("imnage usr $imageUrl");
    return InkWell(
        onTap: onTap,
        child: Container(
         
          decoration: BoxDecoration(
              color: offWhiteColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color.fromARGB(255, 236, 234, 234),
              )),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                     decoration: BoxDecoration(
                          // color: offWhiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Color.fromARGB(255, 236, 234, 234),
                          )),
                    
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl != null ? imageUrl! : '',
                              width: 150,
                              height: 100,
                              // padding: EdgeInsets.all(2),
                            )
                          : null),
                ),
                Divider(),
                // ! title  and Subtitle for
                Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 3, top: 3, bottom: 2),
                  child: Text(
                    title!.length <= 40 ? title! : title!.substring(0, 40),
                    textAlign: TextAlign.center,
                    style: TextStyle( 
                      fontFamily: poppinsMedium,
                             fontSize: 15,
                        fontWeight: FontWeight.bold,
                    ),

             
                  ),
                )
              ]),
        ));
  }
}
