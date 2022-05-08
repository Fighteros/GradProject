// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getcheckup_model.dart';
import 'package:mobile_app/models/getpatient_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppPatientCubit extends Cubit<GetPatientStates> {
  AppPatientCubit() : super(AppInitialStates());
  GetPatientModel? getPatient;
  GetCheckUpModel? checkUpModel;

  static AppPatientCubit get(context) => BlocProvider.of(context);

// ______________________________________get Patient cubit ______________________________________________________
  void getPatientData() {
    emit(AppGetPatientLoadingStates());
    DioHelper.getData(
      url: PATIENTDATA,
    ).then((value) {
      getPatient = GetPatientModel.fromJson(value.data);
      // if (value.statusCode == 200) {
      //   print(value.data);
      // } else {
      //   print('${value.statusCode} : ${value.data.toString()}');
      // }
      emit(AppGetPatientSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPatientErrorStates(error));
    });
  }
// get list of patients

  List data = [];
  void getPatients() {
    List<dynamic> getPatientFormData = [];
    emit(AppGetPatientsLoadingStates());
    DioHelper.getData(
      url: GETPATIENTS,
    ).then((value) {
      getPatientFormData = value.data;
      for (int i = 0; i < getPatientFormData.length; i++) {
        data = getPatientFormData[i]['first_name'];
      }
      for (int j = 0; j < getPatientFormData.length; j++) {
        print(data[j]);
      }
      // data = getPatientFormData[1]['first_name'];
      // print(data);
      emit(AppGetPatientsSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPatientsErrorStates(error.toString()));
    });
  }

  void createCheckUp({
    required String patientId,
    required String doctorId,
    required String description,
  }) {
    emit(AppCreateCheckUpLoadingStates());
    DioHelper.postData(url: CREATECHEACKUP, data: {
      'patient_id': patientId,
      'doctor_id': doctorId,
      'description': description,
    }).then((value) {
      checkUpModel = GetCheckUpModel.fromJson(value.data);
      emit(AppCreateCheckUpSuccessStates());
    }).catchError((e) {
      print(e.toString());
      emit(AppCreateCheckUpErrorStates(e.toString()));
    });
  }
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
