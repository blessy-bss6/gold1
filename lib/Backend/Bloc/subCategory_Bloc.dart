import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Resp/category_Resp.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  CategoryRespo cateResp = CategoryRespo();

  SubCategoryBloc() : super(SubCategoryInitialState()) {
    // on<FetchHomeEvent>(_homeMethod);
    on<FetchSubCategoryEvent>(_subCategoryMethod);
  }

  void _subCategoryMethod(FetchSubCategoryEvent event, Emitter emit) async {
    // print(event);
    emit(SubCategoryLoadingState());
    try {
      var user = await cateResp.subCategoryResp(
          pageNum: event.pageNum, parent: event.parent);
      // print('user data $user');
      if (user != false) {
        emit(SubCategorySuccessState(data: user));
      } else {
        emit(SubCategoryInitialState());
      }
    } catch (e) {
      emit(SubCategoryFailedState());
    }
  }
}

abstract class SubCategoryEvent extends Equatable {
  SubCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchSubCategoryEvent extends SubCategoryEvent {
  final String? pageNum, parent;

  FetchSubCategoryEvent({this.pageNum = '1', this.parent = '0'});
  @override
  List<Object> get props => [];
}

abstract class SubCategoryState extends Equatable {
  const SubCategoryState();

  @override
  List<Object> get props => [];
}

class SubCategoryInitialState extends SubCategoryState {}

class SubCategoryLoadingState extends SubCategoryState {}

class SubCategorySuccessState extends SubCategoryState {
  final dynamic data;
  SubCategorySuccessState({this.data});
}

class SubCategoryFailedState extends SubCategoryState {
  final String? message;
  SubCategoryFailedState({this.message});
}
