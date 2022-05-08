// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/states.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppDoctorCubit extends Cubit<GetDoctorStates> {
  AppDoctorCubit() : super(AppInitialStates());

  static AppDoctorCubit get(context) => BlocProvider.of(context);
  // GetDoctorModel? uploadImages;

// ______________________________________get Doctor Cubit ______________________________________________________
  void getDoctorData() {
    emit(AppGetDoctorLoadingStates());
    DioHelper.getData(
      url: DOCTORDATA,
    ).then((value) {
      getDoctor = GetDoctorModel.fromJson(value.data);
      emit(AppGetDoctorSuccessStates(getDoctor!));
    }).catchError((error) {
      // print(error.toString());
      emit(AppGetDoctorErrorStates(error.toString()));
    });
  }

  List<dynamic> getCheckUp = [];
  void getCheckUpForDoctor() {
    emit(AppGetCheckUpForDoctorLoadingStates());
    DioHelper.getData(
      url: GETCHECKUP,
    ).then((value) {
      getCheckUp = value.data;
      print(getCheckUp);
      emit(AppGetCheckUpForDoctorSuccessStates());
    }).catchError((e) {
      print(e.toString());
      emit(AppGetCheckUpForDoctorErrorStates(e.toString()));
    });
  }

  String? nameOfDoctor = '';
  String? urlImage = '';
  int? checkUpLength = 0;
  void ChangeData({
    String? nameDoctor,
    String? url,
    int? numOfChecks,
  }) {
    nameOfDoctor = nameOfDoctor;
    urlImage = url;
    checkUpLength = numOfChecks;
    emit(ChangeDataStates());
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

