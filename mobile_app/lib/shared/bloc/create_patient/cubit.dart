import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/addpatient_model.dart';
import 'package:mobile_app/shared/bloc/create_patient/states.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppAddPatientCubit extends Cubit<AddPatientStates> {
  AppAddPatientCubit() : super(AppInitialStates());

  AddPatientModel? patient;
  // GetDoctorModel? getDoctor;

  // int? statuscode;

  static AppAddPatientCubit get(context) => BlocProvider.of(context);

  void addPatient({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNum,
  }) {
    emit(AppAddPatientLoadingStates());
    DioHelper.postData(
      url: AddPATIENTS,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phoneNum,
      },
    ).then((value) {
      patient = AddPatientModel.fromJson(value.data);
      print(value.data);
      emit(AppAddPatientSuccessStates(patient!));
    }).catchError((error) {
      print(error.toString());
      emit(AppAddPatientErrorStates(error.toString()));
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

