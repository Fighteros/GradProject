import 'package:mobile_app/models/login_model.dart';

abstract class DoctorLoginStates {}

class AppInitialStates extends DoctorLoginStates {}

class AppLoginLoadingStates extends DoctorLoginStates {}

class AppLoginSuccessStates extends DoctorLoginStates {
  final LoginModel loginModel;
  AppLoginSuccessStates(
    this.loginModel,
  );
}

class AppLoginErrorStates extends DoctorLoginStates {
  final String error;

  AppLoginErrorStates(this.error);
}



// ______________________________________get Doctor States ______________________________________________________

// class AppGetDoctorLoadingStates extends DoctorLoginStates {}

// class AppGetDoctorSuccessStates extends DoctorLoginStates {}

// class AppGetDoctorErrorStates extends DoctorLoginStates {
//   final String error;

//   AppGetDoctorErrorStates(this.error);
// }

// // ______________________________________get patient States ______________________________________________________
// class AppGetPatientLoadingStates extends DoctorLoginStates {}

// class AppGetPatientSuccessStates extends DoctorLoginStates {}

// class AppGetPatientErrorStates extends DoctorLoginStates {
//   final String error;

//   AppGetPatientErrorStates(this.error);
// }

// //__________________________________________________________________________________________________________________

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
