// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/login_model.dart';
import 'package:mobile_app/shared/bloc/states.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class LoginCubit extends Cubit<AppLoginStates> {
  LoginCubit() : super(AppInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingStates());
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      // print(value.data['message']);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data.token);

      emit(AppLoginSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorStates(error.toString()));
    });
  }
}
