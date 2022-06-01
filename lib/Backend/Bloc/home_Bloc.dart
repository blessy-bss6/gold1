import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/Backend/Resp/prod_home_Resp.dart';
import '../Resp/category_Resp.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ProdHomeRespo prodResp = ProdHomeRespo();
  CategoryRespo cateResp = CategoryRespo();

  HomeBloc() : super(HomeInitialState()) {
    on<FetchHomeEvent>(_homeMethod);
  }
  void _homeMethod(FetchHomeEvent event, Emitter emit) async {
    // print(event);
    emit(HomeLoadingState());
    try {
      
      var prod = await prodResp.prodResp();
      var cate = await cateResp.categoryResp();
      // print('user data ${user['cate']}');
      // if (user != false)
      if (prod != false || cate != false) {
    
        emit(HomeSuccessState(product: prod, category: cate));
      } else {
        emit(HomeInitialState());
      }
    } catch (e) {
      emit(HomeFailedState());
    }
  }
}

abstract class HomeEvent extends Equatable {
  HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeEvent extends HomeEvent {
  FetchHomeEvent();
  @override
  List<Object> get props => [];
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final dynamic product;
  final dynamic category;
  HomeSuccessState({this.product, this.category});
}

class HomeFailedState extends HomeState {
  final String? message;
  HomeFailedState({this.message});
}
