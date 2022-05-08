import 'package:mobile_app/models/login_model.dart';

abstract class GetPatientStates {}

class AppInitialStates extends GetPatientStates {}

// ______________________________________get patient States ______________________________________________________
class AppGetPatientLoadingStates extends GetPatientStates {}

class AppGetPatientSuccessStates extends GetPatientStates {}

class AppGetPatientErrorStates extends GetPatientStates {
  final String error;

  AppGetPatientErrorStates(this.error);
}

class AppGetPatientsLoadingStates extends GetPatientStates {}

class AppGetPatientsSuccessStates extends GetPatientStates {}

class AppGetPatientsErrorStates extends GetPatientStates {
  final String error;

  AppGetPatientsErrorStates(this.error);
}

class AppCreateCheckUpLoadingStates extends GetPatientStates {}

class AppCreateCheckUpSuccessStates extends GetPatientStates {}

class AppCreateCheckUpErrorStates extends GetPatientStates {
  final String error;

  AppCreateCheckUpErrorStates(this.error);
}
//__________________________________________________________________________________________________________________

// class AppCreatePatientLoadingStates extends DoctorLoginStates {}

// class AppCreatePatientSuccessStates extends DoctorLoginStates {}

// class AppCreatePatientErrorStates extends DoctorLoginStates {
//   final String error;

//   AppCreatePatientErrorStates(this.error);
// }

// class AppDrugsLoadingStates extends DoctorLoginStates {}

// class AppDrugsSuccessStates extends DoctorLoginStates {
//   final LoginModel loginModel;
//   AppDrugsSuccessStates(
//     this.loginModel,
//   );
// }

// class AppDrugsErrorStates extends DoctorLoginStates {
//   final String error;

//   AppDrugsErrorStates(this.error);
// }
