// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/models/login_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/login_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppCubit extends Cubit<DoctorLoginStates> {
  AppCubit() : super(AppInitialStates());
  LoginModel? login;
  // GetPatientModel? getPatient;
  // GetDoctorModel? getDoctor;

  int? statuscode;

  static AppCubit get(context) => BlocProvider.of(context);

  void doctorLogin({
    required String username,
    required String password,
  }) {
    emit(AppLoginLoadingStates());
    DioHelper.postbody(
      url: LOGIN,
      body: {
        'username': username,
        'password': password,
      },
    ).then((value) {
      login = LoginModel.fromJson(value.data);
      // if (value.statusCode == 422) {
      //   print('Email or password not validiate');
      // }
      emit(AppLoginSuccessStates(login!));
    }).catchError((error) {
      print('Email or password not validiate');
      emit(AppLoginErrorStates(error.toString()));
    });
  }

//________________________________________________________________________________________________

}
