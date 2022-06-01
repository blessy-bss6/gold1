import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'Backend/Bloc/category_Bloc.dart';
import 'Backend/Bloc/home_Bloc.dart';
import 'Backend/Bloc/localCart_Bloc.dart';
import 'Backend/Bloc/order_Bloc.dart';
import 'Backend/Bloc/prod_Bloc.dart';

import 'Backend/Bloc/reg_Login_Bloc.dart';
import 'Backend/Bloc/subCategory_Bloc.dart';

class MainBloc {
  static List<SingleChildWidget> allBlocs() {
    return [
      BlocProvider(create: (ctx) => AuthBloc()),
      BlocProvider(create: (ctx) => ProductBloc()),
      BlocProvider(create: (ctx) => HomeBloc()),
      BlocProvider(create: (ctx) => CategoryBloc()),
      BlocProvider(create: (ctx) => SubCategoryBloc()),
      BlocProvider(create: (ctx) => LocalCartBloc()),
      BlocProvider(create: (ctx) => OrderBloc()),
    ];
  }
}
