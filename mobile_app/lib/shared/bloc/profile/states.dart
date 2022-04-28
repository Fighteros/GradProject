import 'package:mobile_app/models/login_model.dart';

abstract class GetDoctorProfileStates {}

class AppInitialStates extends GetDoctorProfileStates {}

class AppProfileImageSuccessStates extends GetDoctorProfileStates {}

class AppProfileImageErrorStates extends GetDoctorProfileStates {}

class AppUploadProfileImageLoadingStates extends GetDoctorProfileStates {}

class AppUploadProfileImageSuccessStates extends GetDoctorProfileStates {}

class AppUploadProfileImageErrorStates extends GetDoctorProfileStates {}
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
