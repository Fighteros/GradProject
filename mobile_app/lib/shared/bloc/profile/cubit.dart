// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/shared/bloc/profile/states.dart';
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
  // void upLoadProfileImage(File? image) {
  //   emit(AppUploadProfileImageLoadingStates());
  //   DioHelper.postbody(
  //     body: {
  //       'img': image,
  //     },
  //     url: UPLOADPROFILE,
  //   ).then((value) {
  //     uploadImages = GetDoctorModel.fromJson(value.data);
  //     print(value.data);
  //     emit(AppUploadProfileImageSuccessStates());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(AppUploadProfileImageErrorStates());
  //   });
  // }
  // void upLoadProfileImage(
  //   File? profileImage,
  // ) {
  //   emit(AppUploadProfileImageLoadingStates());
  //   DioHelper.postbody(
  //     url: UPLOADPROFILE,
  //     body: {
  //       'img': profileImage,
  //     },
  //   ).then((value) {
  //     GetDoctorModel.fromJson(value.data);
  //     print(value.data['image']);
  //     emit(AppUploadProfileImageSuccessStates());
  //   }).catchError((onError) {
  //     emit(AppUploadProfileImageErrorStates());
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

