import 'package:mobile_app/models/getdoctor_model.dart';

abstract class GetDoctorStates {}

class AppInitialStates extends GetDoctorStates {}

// ______________________________________get Doctor States ______________________________________________________

//  CheckUpForDoctor

class AppGetCheckUpForDoctorLoadingStates extends GetDoctorStates {}

class AppGetCheckUpForDoctorSuccessStates extends GetDoctorStates {}

class AppGetCheckUpForDoctorErrorStates extends GetDoctorStates {
  final String error;

  AppGetCheckUpForDoctorErrorStates(this.error);
}

class AppGetDoctorLoadingStates extends GetDoctorStates {}

class AppGetDoctorSuccessStates extends GetDoctorStates {
  final GetDoctorModel getDoctorModel;
  AppGetDoctorSuccessStates(
    this.getDoctorModel,
  );
}

class AppGetDoctorErrorStates extends GetDoctorStates {
  final String error;

  AppGetDoctorErrorStates(this.error);
}
