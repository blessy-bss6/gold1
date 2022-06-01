import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/shared_helper.dart';

class LocalCartBloc extends Bloc<LocalCartEvent, LocalCartState> {
  ShopC shoping = ShopC();

  LocalCartBloc() : super(LocalCartInitialState()) {
    on<FetchLocalCartEvent>(_localCartMethod);

    // ====================ADD==========================
    on<LocalCartItemAddEvent>(_localCartAddMethod);

    // ! Update LocalCart and Wishlist
    on<LocalCartItemPutEvent>(_localCartUpdateMethod);

    // ! Delete LocalCart and Wishlist
    on<LocalCartItemDelEvent>(_localCartDeleteMethod);
  }

  //  ! LocalCart Data Get

  void _localCartMethod(FetchLocalCartEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      dynamic user = shoping.refreshItems();

      if (user != null) {
        emit(LocalCartSuccessState(data: user['data'], priceData: {
          "subPrice": user['subPrice'],
          "mrpPrice": user['mrpPrice'],
          "shipPrice": user['shipPrice']
        }));
      }
      // emit(LocalCartInitialState());
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  //  ============ LocalCart AND WISHLIST PRODUCT ADD ======================
  _localCartAddMethod(LocalCartItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      shoping.createItem(event.prodData);
      dynamic user = shoping.refreshItems();
      if (user != null) {
        emit(LocalCartSuccessState(data: user['data']));
      } else {
        // snackBar(event.context, user['msg'] ?? '');
        emit(LocalCartInitialState());
      }
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update LocalCart and WishlIst Item
  void _localCartUpdateMethod(LocalCartItemPutEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      shoping.updateItem(event.id, event.prodData);
      dynamic user = shoping.refreshItems();

      if (user != null) {
        emit(LocalCartSuccessState(data: user['data'], priceData: {
          "subPrice": user['subPrice'],
          "mrpPrice": user['mrpPrice'],
          "shipPrice": user['shipPrice']
        }));
      }
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  // ! Delete for LocalCart AND WISHLIST
  void _localCartDeleteMethod(LocalCartItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      dynamic us = shoping.deleteItem(event.id);
        // print('delete data $us');
      dynamic user =  shoping.refreshItems();

      // print('cart dtaa $user');
         


      if (user != null) {
        // print('local cond   $user');
        emit(LocalCartSuccessState(data: user['data'], priceData: {
          "subPrice": user['subPrice'],
          "mrpPrice": user['mrpPrice'],
          "shipPrice": user['shipPrice']
        }));
      } else {
        emit(LocalCartInitialState());
      }
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }
}

// ! Event for LocalCart and WishList
abstract class LocalCartEvent extends Equatable {
  LocalCartEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchLocalCartEvent extends LocalCartEvent {
  FetchLocalCartEvent();
  @override
  List<Object> get props => [];
}

// 1 LocalCart Item Add and Wishlist add
class LocalCartItemAddEvent extends LocalCartEvent {
  final Map<String, dynamic> prodData;
  final dynamic context;

  LocalCartItemAddEvent({required this.prodData, this.context});
  @override
  List<Object> get props => [];
}

//  LocalCart Item Event
class LocalCartItemPutEvent extends LocalCartEvent {
  final dynamic id;
  final int? quantity;
  final Map<String, dynamic> prodData;

  final dynamic context;
  LocalCartItemPutEvent(
      {required this.id, required this.prodData, this.quantity, this.context});
  @override
  List<Object> get props => [];
}

class LocalCartItemDelEvent extends LocalCartEvent {
  final int id;
  final dynamic context;
  LocalCartItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in LocalCart
abstract class LocalCartState extends Equatable {
  const LocalCartState();

  @override
  List<Object> get props => [];
}

class LocalCartInitialState extends LocalCartState {}

class LocalCartLoadingState extends LocalCartState {}

class LocalCartSuccessState extends LocalCartState {
  final dynamic data;
  final Map<String, dynamic>? priceData;
  LocalCartSuccessState({this.data, this.priceData});
}

class LocalCartFailedState extends LocalCartState {
  final String? message;
  LocalCartFailedState({this.message});
}
