// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/states.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppDoctorCubit extends Cubit<GetDoctorStates> {
  AppDoctorCubit() : super(AppInitialStates());
  GetDoctorModel? getDoctor;

  static AppDoctorCubit get(context) => BlocProvider.of(context);
// ______________________________________get Doctor Cubit ______________________________________________________

  void getDoctorData() {
    emit(AppGetDoctorLoadingStates());
    DioHelper.getData(
      url: DOCTORDATA,
    ).then((value) {
      getDoctor = GetDoctorModel.fromJson(value.data);
      if (value.statusCode == 200) {
        print(value.data);
      } else {
        print('${value.statusCode}');
      }
      emit(AppGetDoctorSuccessStates());
    }).catchError((error) {
      // print(error.toString());
      emit(AppGetDoctorErrorStates(error.toString()));
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

