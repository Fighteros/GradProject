// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/login_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/login_cubit/states.dart';
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
      print('trying to request from backend $value');
      login = LoginModel.fromJson(value.data);
      print(login?.accessToken);
      statuscode = value.statusCode;
      // print(value.headers['Postman-Token']);
      // print('token is = ${login!.token}');
      emit(AppLoginSuccessStates(login!));
    }).catchError((error) {
      print(error.toString());
      print("Email is not validate");
      emit(AppLoginErrorStates(error.toString()));
    });
  }

//________________________________________________________________________________________________

}

// ______________________________________get Doctor Cubit ______________________________________________________
//   void getDoctorData() {
//     emit(AppGetDoctorLoadingStates());
//     DioHelper.getData(
//       url: DOCTORDATA,
//     ).then((value) {
//       getDoctor = GetDoctorModel.fromJson(value.data);
//       if (value.statusCode == 200) {
//         print(getDoctor?.firstName);
//         // print(getDoctor?.lastName);
//       } else {
//         print('${value.statusCode} : ${value.data.toString()}');
//       }
//       emit(AppGetDoctorSuccessStates());
//     }).catchError((error) {
//       print(error.toString());
//       emit(AppGetDoctorErrorStates(error));
//     });
//   }

// // ______________________________________get Patient cubit ______________________________________________________
//   void getPatientData() {
//     emit(AppGetPatientLoadingStates());
//     DioHelper.getData(
//       url: PATIENTDATA,
//     ).then((value) {
//       getPatient = GetPatientModel.fromJson(value.data);
//       if (value.statusCode == 200) {
//         print(value.data);
//       } else {
//         print('${value.statusCode} : ${value.data.toString()}');
//       }
//       emit(AppGetPatientSuccessStates());
//     }).catchError((error) {
//       print(error.toString());
//       emit(AppGetPatientErrorStates(error));
//     });
//   }
// }


//   void getDrugs({
//     required String drugsname,
//   }) {
//     DioHelper.getData(url: GETDRUGS, query: {
//       'drug_name': drugsname,
//     }).then((value){
//       emit()
//     });
//   }
// }

