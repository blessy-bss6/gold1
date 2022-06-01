import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/Backend/Resp/prod_home_Resp.dart';
import 'reg_Login_Bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProdHomeRespo prodResp = ProdHomeRespo();

  ProductBloc() : super(ProdInitialState()) {
    // on<FetchHomeEvent>(_homeMethod);
    on<FetchProdEvent>(_prodMethod);
    on<FetchSubProdEvent>(_subProdMethod);
  }
  

  void _prodMethod(FetchProdEvent event, Emitter emit) async {
    // print(event);
    emit(ProdLoadingState());
    try {
      var user = await prodResp.prodResp();
      // print('user data $user');
      if (user != false) {
        emit(ProdSuccessState(data: user));
      } else {
        emit(ProdInitialState());
      }
    } catch (e) {
      emit(ProdFailedState());
    }
  }

  void _subProdMethod(FetchSubProdEvent event, Emitter emit) async {
    // print(event);
    emit(ProdLoadingState());
    try {
      var user = await prodResp.subprodResp(
          pageNum: event.pageNum, categoryId: event.categoryId);
      // print('user data $user');
      if (user != false) {
        emit(ProdSuccessState(data: user));
      } else {
        emit(ProdInitialState());
      }
    } catch (e) {
      emit(ProdFailedState());
    }
  }
}

abstract class ProductEvent extends Equatable {
  ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProdEvent extends ProductEvent {
  FetchProdEvent();
  @override
  List<Object> get props => [];
}

class FetchSubProdEvent extends ProductEvent {
  final String? pageNum, categoryId;
  FetchSubProdEvent({this.pageNum = '1', this.categoryId});
  @override
  List<Object> get props => [];
}

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProdInitialState extends ProductState {}

class ProdLoadingState extends ProductState {}

class ProdSuccessState extends ProductState {
  final dynamic data;
  ProdSuccessState({this.data});
}

class ProdFailedState extends ProductState {
  final String? message;
  ProdFailedState({this.message});
}
