import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_app/models/addpatient_model.dart';
import 'package:mobile_app/models/drugs_model.dart';
import 'package:mobile_app/models/drug2_model.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/states.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppAdminCubit extends Cubit<CreateAdminStates> {
  AppAdminCubit() : super(AppInitialStates());
  AddPatientModel? adminModel;
  AddPatientModel? doctorModel;
  AddPatientModel? patientModel;
  static AppAdminCubit get(context) => BlocProvider.of(context);
  ////Admin
  void addAdmin({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) {
    emit(AppCreateAdminLoadingStates());
    DioHelper.postData(
      url: CREATEAdmin,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phone,
      },
    ).then((value) {
      adminModel = AddPatientModel.fromJson(value.data);
      print(value.data);
      emit(AppCreateAdminSuccessStates(adminModel!));
    }).catchError((error) {
      emit(AppCreateAdminErrorStates(error.toString()));
    });
  }

  void deleteAdmin({
    required String deleteID,
  }) {
    emit(AppDeleteAdminLoadingStates());
    DioHelper.deleteData(
      url: DETETEAdmin + deleteID,
    ).then((value) {
      emit(AppDeleteAdminSuccessStates());
    }).catchError((error) {
      emit(AppDeleteAdminErrorStates(error.toString()));
    });
  }

  void upDateAdmin({
    required String upDateID,
    String? firstName,
    String? lastName,
    String? gender,
    String? age,
    String? phone,
    String? email,
    String? jobTitle,
  }) {
    emit(AppUpdateAdminLoadingStates());
    DioHelper.putData(
      url: UPDATEAdmin + upDateID,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
        'age': age,
        'gender': gender,
        'job_title': jobTitle,
      },
    ).then((value) {
      // upDateAdminModel = AddPatientModel.fromJson(value.data);
      // print(upDateAdminModel);
      emit(AppUpdateAdminSuccessStates(adminModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateAdminErrorStates(error.toString()));
    });
  }

  void getAdminData({
    required String getAdminID,
  }) {
    emit(AppGetAdminLoadingStates());
    DioHelper.getData(
      url: GETAdmin + getAdminID,
    ).then((value) {
      adminModel = AddPatientModel.fromJson(value.data);
      print(adminModel);
      emit(AppGetAdminSuccessStates(adminModel!));
    }).catchError((error) {
      emit(AppGetAdminErrorStates(error.toString()));
    });
  }

  ////Doctor
  void createDoctor({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) {
    emit(AppCreateDoctorLoadingStates());
    DioHelper.postData(
      url: CREATEDoctor,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phone,
      },
    ).then((value) {
      doctorModel = AddPatientModel.fromJson(value.data);
      print(value.data);
      emit(AppCreateDoctorSuccessStates(doctorModel!));
    }).catchError((error) {
      emit(AppCreateDoctorErrorStates(error.toString()));
    });
  }

  void deleteDoctor({
    required String deleteID,
  }) {
    emit(AppDeleteDoctorLoadingStates());
    DioHelper.deleteData(
      url: DETETEDoctor + deleteID,
    ).then((value) {
      emit(AppDeleteDoctorSuccessStates());
    }).catchError((error) {
      emit(AppDeleteDoctorErrorStates(error.toString()));
    });
  }

  void upDateDoctor({
    required String upDateID,
    String? firstName,
    String? lastName,
    String? gender,
    String? age,
    String? phone,
    String? email,
    String? jobTitle,
  }) {
    emit(AppUpdateDoctorLoadingStates());
    DioHelper.putData(
      url: UPDATEDoctor + upDateID,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
        'age': age,
        'gender': gender,
        'job_title': jobTitle
      },
    ).then((value) {
      // upDateAdminModel = AddPatientModel.fromJson(value.data);
      // print(upDateAdminModel);
      emit(AppUpdateDoctorSuccessStates(doctorModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateDoctorErrorStates(error.toString()));
    });
  }

  void getDoctorData({
    required String getAdminID,
  }) {
    emit(AppGetDoctorLoadingStates());
    DioHelper.getData(
      url: GETDoctor + getAdminID,
    ).then((value) {
      doctorModel = AddPatientModel.fromJson(value.data);
      print(doctorModel);
      emit(AppGetDoctorSuccessStates(doctorModel!));
    }).catchError((error) {
      emit(AppGetDoctorErrorStates(error.toString()));
    });
  }

  ////Patient
  void createPatient({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) {
    emit(AppCreatePatientLoadingStates());
    DioHelper.postData(
      url: CREATEPatient,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phone,
      },
    ).then((value) {
      patientModel = AddPatientModel.fromJson(value.data);
      print(value.data);
      emit(AppCreatePatientSuccessStates(patientModel!));
    }).catchError((error) {
      emit(AppCreatePatientErrorStates(error.toString()));
    });
  }

  void deletePatient({
    required String deleteID,
  }) {
    emit(AppDeletePatientLoadingStates());
    DioHelper.deleteData(
      url: DETETEPatient + deleteID,
    ).then((value) {
      emit(AppDeletePatientSuccessStates());
    }).catchError((error) {
      emit(AppDeletePatientErrorStates(error.toString()));
    });
  }

  AddPatientModel? updatePatients;
  void upDatePatient({
    required String upDateID,
    String? firstName,
    String? lastName,
    String? gender,
    String? age,
    String? phone,
    String? email,
    String? jobtitle,
  }) {
    emit(AppUpdatePatientLoadingStates());
    DioHelper.putData(
      url: UPDATEPatient + upDateID,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
        'age': age,
        'gender': gender,
        'job_title': jobtitle,
      },
    ).then((value) {
      updatePatients = AddPatientModel.fromJson(value.data);
      print(updatePatients);
      emit(AppUpdatePatientSuccessStates(updatePatients!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdatePatientErrorStates(error.toString()));
    });
  }

  void getPatientData({
    required String getAdminID,
  }) {
    emit(AppGetPatientLoadingStates());
    DioHelper.getData(
      url: GETPatient + getAdminID,
    ).then((value) {
      patientModel = AddPatientModel.fromJson(value.data);
      print(patientModel);
      emit(AppGetPatientSuccessStates(patientModel!));
    }).catchError((error) {
      emit(AppGetPatientErrorStates(error.toString()));
    });
  }

//______________________________________Drugs
  CreateCheckUpDrugs? createdrugs;
  void createDrugs({
    required String name,
  }) {
    emit(AppCreateDrugsLoadingStates());
    DioHelper.postData(
      url: CREATEDrugs,
      data: {
        'drug_name': name,
      },
    ).then((value) {
      createdrugs = CreateCheckUpDrugs.fromJson(value.data);
      print(value.data);
      emit(AppCreateDrugsSuccessStates());
    }).catchError((error) {
      emit(AppCreateDrugsErrorStates(error.toString()));
    });
  }

  DrugsModel? getdrugs;
  void getDrugsData({
    required String getDrugsID,
  }) {
    emit(AppGetDrugsLoadingStates());
    DioHelper.getData(
      url: CREATEDrugs + getDrugsID,
    ).then((value) {
      getdrugs = DrugsModel.fromJson(value.data);
      print(doctorModel);
      emit(AppGetDrugsSuccessStates(getdrugs!));
    }).catchError((error) {
      emit(AppGetDrugsErrorStates(error.toString()));
    });
  }

  void deleteDrugs({
    required String deleteID,
  }) {
    emit(AppDeleteDrugsLoadingStates());
    DioHelper.deleteData(
      url: CREATEDrugs + deleteID,
    ).then((value) {
      emit(AppDeleteDrugsSuccessStates());
    }).catchError((error) {
      emit(AppDeleteDrugsErrorStates(error.toString()));
    });
  }

  CreateCheckUpDrugs? updateDrugs;
  void upDateDrugs({
    required String upDateID,
    required String name,
  }) {
    emit(AppUpdateDrugsLoadingStates());
    DioHelper.putData(
      url: CREATEDrugs + upDateID,
      data: {
        'drug_name': name,
      },
    ).then((value) {
      updateDrugs = CreateCheckUpDrugs.fromJson(value.data);
      print(updateDrugs);
      emit(AppUpdateDrugsSuccessStates(updateDrugs!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateDrugsErrorStates(error.toString()));
    });
  }
}
