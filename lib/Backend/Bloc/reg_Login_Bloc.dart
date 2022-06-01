import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Screen/bottomNav.dart';
import '../../utils/common.dart';
import '../Resp/reg_login_resp.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  RegLoginResp userRespository = RegLoginResp();

  AuthBloc() : super(AuthInitialState()) {
    on<LoginBtnEvent>(_loginMethod);
    on<SignUpBtnEvent>(_registerMethod);
  }
  void _loginMethod(LoginBtnEvent event, Emitter emit) async {
    // print(event);
    emit(AuthLoadingState());
    try {
      var user = await userRespository.loginResp(
          email: event.email, password: event.password);
      // print('user data $user');
      if (user == true) {
        emit(AuthSuccessState());
      }
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailedState());
    }
  }

  // ! SignUp
  void _registerMethod(SignUpBtnEvent event, Emitter emit) async {
    // print(event);
    emit(AuthLoadingState());
    try {
      var user = await userRespository.registerResp(
          email: event.email,
          password: event.password,
          username: event.username);
      // print('user data $user');
      if (user == true) {
        emit(AuthSuccessState());
      }
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailedState());
    }
  }
}

// ! Event For Signup
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpBtnEvent extends AuthEvent {
  dynamic password, username;
  dynamic email;
  dynamic context;
  SignUpBtnEvent({this.email, this.password, this.username, this.context});
}

class LoginBtnEvent extends AuthEvent {
  dynamic password;
  dynamic email;
  LoginBtnEvent({this.email, this.password});
}

// ! 3. STATE FOR Auth
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String? message;
  AuthFailedState({this.message});
}
