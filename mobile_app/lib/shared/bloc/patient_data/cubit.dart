// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/analysis_model.dart';
import 'package:mobile_app/models/drugs_model.dart';
import 'package:mobile_app/models/getcheckup_model.dart';
import 'package:mobile_app/models/getpatient_model.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/components/components.dart';
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
      emit(AppGetPatientSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPatientErrorStates(error));
    });
  }

  List<dynamic> getPatientFormData = [];

  void getPatients() {
    emit(AppGetPatientsLoadingStates());
    DioHelper.getData(
      url: GETPATIENTS,
    ).then((value) {
      getPatientFormData = value.data;
      print(getPatientFormData);
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
      print(checkUpModel);
      emit(AppCreateCheckUpSuccessStates());
    }).catchError((e) {
      print(e.toString());
      emit(AppCreateCheckUpErrorStates(e.toString()));
    });
  }

  CreateCheckUpDrugs? createDrugs;
  void createCheckUpDrugs({
    required String quantity,
    required String timePerDay,
    required String checkUpId,
    required String checkUpDrugsId,
  }) {
    emit(AppDrugsLoadingStates());
    DioHelper.postData(url: CREATECheckUpDrugs, data: {
      'quantity': quantity,
      'times_per_day': timePerDay,
      'checkup_id': checkUpId,
      'drug_id': checkUpDrugsId,
    }).then((value) {
      createDrugs = CreateCheckUpDrugs.fromJson(value.data);
      emit(AppDrugsSuccessStates());
    }).catchError((e) {
      emit(AppDrugsErrorStates(e.toString()));
    });
  }

//__________________________________________________

  // void createAnalysis({
  //   required String checkUpId,
  //   required String analysisId,
  // }) {
  //   emit(AppDrugsLoadingStates());
  //   DioHelper.postData(url: UPLOADAnalysis, data: {
  //     'checkup_id': checkUpId,
  //     'analysis_id': analysisId,
  //   }).then((value) {
  //     createDrugs = CreateCheckUpDrugs.fromJson(value.data);
  //     emit(AppDrugsSuccessStates());
  //   }).catchError((e) {
  //     emit(AppDrugsErrorStates(e.toString()));
  //   });
  //"img": await MultipartFile.fromFile(
  //     analysisImages!.path,
  //   )
  // }

  AnalysisModel? uploadAnalysisImages;
  void upLoadAnalysis({
    required String checkUpId,
    required String analysisId,
  }) {
    emit(AppUpoaldAnalysisLoadingStates());
    DioHelper.uploadAnalysis(
      analysis: analysisId,
      checkup: checkUpId,
    ).then((value) {
      uploadAnalysisImages = AnalysisModel.fromJson(value.data);
      print(value.data);
      emit(AppUpoaldAnalysisSuccessStates());
    }).catchError((e) {
      emit(AppUpoaldAnalysisErrorStates());
    });
  }
}
