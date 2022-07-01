// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/profile/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppDoctorProfileCubit extends Cubit<GetDoctorProfileStates> {
  AppDoctorProfileCubit() : super(AppInitialStates());
  // LoginModel? login;
  // GetPatientModel? getPatient;
  GetDoctorModel? uploadImages;

  // int? statuscode;

  static AppDoctorProfileCubit get(context) => BlocProvider.of(context);
// ______________________________________get Profile Cubit ______________________________________________________

  void upLoadImageProfile() {
    emit(AppUploadProfileImageLoadingStates());
    DioHelper.uploadImage().then((value) {
      uploadImages = GetDoctorModel.fromJson(value.data);
      print(value.data);
      emit(AppUploadProfileImageSuccessStates());
    }).catchError((e) {
      emit(AppUploadProfileImageErrorStates());
    });
  }

  void updateDoctorData({
    String? id,
    String? firstName,
    String? lastName,
    String? gender,
    String? age,
    String? phone,
    String? email,
    String? jobTitle,
  }) {
    print("DOCTORDATA: ${DOCTORDATA + id!}");
    emit(AppUpdatDoctorLoadingStates());
    DioHelper.putData(url: DOCTORDATA + id, data: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phone,
      "age": age,
      "gender": gender,
      "job_title": jobTitle,
    }).then((value) {
      getDoctor = GetDoctorModel.fromJson(value.data);
      emit(AppUpdatDoctorSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdatDoctorErrorStates(error.toString()));
    });
  }
}
