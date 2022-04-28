import 'package:mobile_app/models/addpatient_model.dart';

abstract class GetDoctorStates {}

class AppInitialStates extends GetDoctorStates {}

// ______________________________________get Doctor States ______________________________________________________

class AppGetDoctorLoadingStates extends GetDoctorStates {}

class AppGetDoctorSuccessStates extends GetDoctorStates {}

class AppGetDoctorErrorStates extends GetDoctorStates {
  final String error;

  AppGetDoctorErrorStates(this.error);
}
