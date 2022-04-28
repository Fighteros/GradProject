// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getpatient_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppPatientCubit extends Cubit<GetPatientStates> {
  AppPatientCubit() : super(AppInitialStates());
  // LoginModel? login;
  GetPatientModel? getPatient;
  // GetPatientModel? patients;
  // GetDoctorModel? getDoctor;

  // int? statuscode;

  static AppPatientCubit get(context) => BlocProvider.of(context);

// ______________________________________get Patient cubit ______________________________________________________
  void getPatientData() {
    emit(AppGetPatientLoadingStates());
    DioHelper.getData(
      url: PATIENTDATA,
    ).then((value) {
      getPatient = GetPatientModel.fromJson(value.data);
      if (value.statusCode == 200) {
        print(value.data);
      } else {
        print('${value.statusCode} : ${value.data.toString()}');
      }
      emit(AppGetPatientSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPatientErrorStates(error));
    });
  }

  // void getPatients() {
  //   emit(AppGetPatientLoadingStates());
  //   DioHelper.getData(
  //     url: GETPATIENTS,
  //   ).then((value) {
  //     patients = GetPatientModel.fromJson(value.data);
  //     if (value.statusCode == 200) {
  //       print(value.data);
  //     } else {
  //       print('${value.statusCode} : ${value.data.toString()}');
  //     }
  //     emit(AppGetPatientSuccessStates());
  //   }).catchError((error) {
  //     // print(error.toString());
  //     emit(AppGetPatientErrorStates(error));
  //   });
  // }
}


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

