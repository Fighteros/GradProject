import 'package:mobile_app/models/addpatient_model.dart';

abstract class AddPatientStates {}

class AppInitialStates extends AddPatientStates {}

// ______________________________________get patient States ______________________________________________________
class AppAddPatientLoadingStates extends AddPatientStates {}

class AppAddPatientSuccessStates extends AddPatientStates {
  final AddPatientModel addPatientModel;
  AppAddPatientSuccessStates(
    this.addPatientModel,
  );
}

class AppAddPatientErrorStates extends AddPatientStates {
  final String error;

  AppAddPatientErrorStates(this.error);
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
