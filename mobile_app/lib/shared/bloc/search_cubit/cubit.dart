// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/bloc/search_cubit/states.dart';
import 'package:mobile_app/shared/network/remote/dio.dart';

class AppSearchCubit extends Cubit<SearchStates> {
  AppSearchCubit() : super(AppInitialStates());

  static AppSearchCubit get(context) => BlocProvider.of(context);

  List<dynamic> search = [];

  void getSearch(String text) {
    emit(AppSearchLoadingStates());
    DioHelper.getData(url: GETPATIENTS, query: {
      'search': text,
    }).then((value) {
      search = value.data;
      emit(AppSearchSuccessStates());
    }).catchError((error) {
      print('there are no patients');
      // print(error.toString());
      emit(AppSearchErrorStates(error.toString()));
    });
  }

  void getDoctorSearch(String text) {
    emit(AppDoctorSearchLoadingStates());
    DioHelper.getData(url: GETDoctor, query: {
      'search': text,
    }).then((value) {
      search = value.data;
      emit(AppDoctorSearchSuccessStates());
    }).catchError((error) {
      print('there are no patients');
      // print(error.toString());
      emit(AppDoctorSearchErrorStates(error.toString()));
    });
  }

  List<dynamic> patientSearch = [];

  void getPatientSearch(String text) {
    emit(AppSearchLoadingStates());
    DioHelper.getData(url: GETCHECKUP, query: {
      'search': text,
    }).then((value) {
      search = value.data;
      emit(AppSearchSuccessStates());
    }).catchError((error) {
      print('there are no patients');
      // print(error.toString());
      emit(AppSearchErrorStates(error.toString()));
    });
  }
}
