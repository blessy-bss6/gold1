import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Resp/category_Resp.dart';
import 'reg_Login_Bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRespo cateResp = CategoryRespo();

  CategoryBloc() : super(CategoryInitialState()) {

    on<FetchCategoryEvent>(_categoryMethod);
  }

  void _categoryMethod(FetchCategoryEvent event, Emitter emit) async {
    // print(event);
    emit(CategoryLoadingState());
    try {
      var user = await cateResp.categoryResp(pageNum: event.pageNum);
      // print('user data $user');
      if (user != false) {
        emit(CategorySuccessState(data: user));
      } else {
        emit(CategoryInitialState());
      }
    } catch (e) {
      emit(CategoryFailedState());
    }
  }
}

abstract class CategoryEvent extends Equatable {
  CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryEvent extends CategoryEvent {
  final String? pageNum;
  FetchCategoryEvent({this.pageNum = '1'});
  @override
  List<Object> get props => [];
}



abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final dynamic data;
  CategorySuccessState({this.data});
}

class CategoryFailedState extends CategoryState {
  final String? message;
  CategoryFailedState({this.message});
}
