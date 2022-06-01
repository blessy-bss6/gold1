import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Screen/OrderSuccess.dart';
import '../../utils/common.dart';
import '../../utils/shared_helper.dart';
import '../Resp/orderResp.dart';
import 'reg_Login_Bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ShopC shoping = ShopC();
  OrderRespo orderResp = OrderRespo();
  SharedHelper sharedHelper = SharedHelper();
  OrderBloc() : super(OrderInitialState()) {
    on<FetchOrderEvent>(_orderMethod);

    // ====================ADD==========================
    on<OrderItemAddEvent>(_orderAddMethod);

    // // ! Update Order and Wishlist
    on<OrderItemUpdateEvent>(_orderUpdateMethod);
    on<OrderShowEvent>(_orderShowMethod);

    // ! Delete Order and Wishlist
    on<OrderItemDelEvent>(_orderDeleteMethod);
  }

  //  ! Order Data Get

  void _orderMethod(FetchOrderEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      dynamic user = await shoping.refreshItems();

      if (user != null) {
        emit(OrderSuccessState(data: user['data'], priceData: {
          "subPrice": user['subPrice'],
          "mrpPrice": user['mrpPrice'],
          "shipPrice": user['shipPrice']
        }));
      }
      // emit(OrderInitialState());
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  // ! Order Show Method
  _orderShowMethod(OrderShowEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      SharedHelper sharedHelper = SharedHelper();
      dynamic id = await sharedHelper.getUserTypeScr('userIdType');

      // print(id);
      dynamic user = await orderResp.orderGetDataResp(customer: id);

      if (user != null) {
        emit(OrderSuccessState(data: user));
      }
      // emit(OrderInitialState());
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  //  ============ Order AND WISHLIST PRODUCT ADD ======================
  _orderAddMethod(OrderItemAddEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      dynamic user = await orderResp.orderPostResp(
          lineItem: event.orderData,
          userId: event.userId,
          billing: event.billing,
          shipping: event.shipping,
          payMode: event.payMode, transcationId: event.transcationId,
          payTitle: event.payTitle);
      // print(user);
      if (user != false) {
        emit(OrderCompleteState(data: user));

        // navigationPush(event.context, OrderCompleteScreen(email:event.billing['email']));
      } else {
        // snackBar(event.context, user['msg'] ?? '');
        emit(OrderInitialState());
      }
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  _orderUpdateMethod(OrderItemUpdateEvent event, Emitter emit) async {
    // print(event);
    dynamic userIds = await sharedHelper.getUserTypeScr('userIdType');
    emit(OrderLoadingState());
    try {
      dynamic user = await orderResp.orderUpdateResp(
          customerId: userIds, orderId: event.orderId);
      // print(user);
      if (user != false) {
        emit(OrderCompleteState());
        
      } else {
        // snackBar(event.context, user['msg'] ?? '');
        emit(OrderInitialState());
      }
    } catch (e) {
      emit(OrderFailedState());
    }
  }

  // ! Delete for Order AND WISHLIST
  void _orderDeleteMethod(OrderItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(OrderLoadingState());
    try {
      dynamic user =
          await orderResp.orderDeleteResp(id: event.id, ammount: event.ammount);

          SharedHelper sharedHelper = SharedHelper();
      dynamic id = await sharedHelper.getUserTypeScr('userIdType');

      // print(id);
      dynamic usr = await orderResp.orderGetDataResp(customer: id);

      if (usr != null) {
        emit(OrderDelSuccessState(
          data: usr,
        ));
      } else {
        emit(OrderInitialState());
      }
    } catch (e) {
      emit(OrderFailedState());
    }
  }
}

// ! Event for Order and WishList
abstract class OrderEvent extends Equatable {
  OrderEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchOrderEvent extends OrderEvent {
  FetchOrderEvent();
  @override
  List<Object> get props => [];
}

// 1 Order Item Add and Wishlist add
class OrderItemAddEvent extends OrderEvent {
  final dynamic orderData;
  final dynamic payMode;
  final dynamic billing;
  final dynamic shipping;
  final dynamic payTitle;
  final dynamic userId;
  final dynamic context;
  dynamic transcationId;

  OrderItemAddEvent(
      {required this.orderData,
      this.billing,
      this.shipping,
      this.payMode,
      this.payTitle,
      this.transcationId,
      this.userId,
      this.context});
  @override
  List<Object> get props => [];
}

class OrderShowEvent extends OrderEvent {
  dynamic customer;

  dynamic context;

  OrderShowEvent({this.customer, this.context});
  @override
  List<Object> get props => [];
}

class OrderItemUpdateEvent extends OrderEvent {
  dynamic customerId;
  dynamic context;
  dynamic orderId;
  OrderItemUpdateEvent({this.customerId, this.orderId, this.context});
  @override
  List<Object> get props => [];
}

class OrderItemDelEvent extends OrderEvent {
  final dynamic id;
  dynamic ammount;
  final dynamic context;
  OrderItemDelEvent({required this.id, this.context, this.ammount});
  @override
  List<Object> get props => [];
}

// / ! State in Order
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  final dynamic data;
  final Map<String, dynamic>? priceData;
  OrderSuccessState({this.data, this.priceData});
}

class OrderDelSuccessState extends OrderState {
  final dynamic data;
  final Map<String, dynamic>? priceData;
  OrderDelSuccessState({this.data, this.priceData});
}

class OrderCompleteState extends OrderState {
  final dynamic data;
  OrderCompleteState({this.data});
}

class OrderFailedState extends OrderState {
  final String? message;
  OrderFailedState({this.message});
}
