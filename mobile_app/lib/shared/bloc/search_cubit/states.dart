abstract class SearchStates {}

class AppInitialStates extends SearchStates {}

// // ______________________________________get Doctor States ______________________________________________________

class AppSearchLoadingStates extends SearchStates {}

class AppSearchSuccessStates extends SearchStates {}

class AppSearchErrorStates extends SearchStates {
  final String error;

  AppSearchErrorStates(this.error);
}

class AppDoctorSearchLoadingStates extends SearchStates {}

class AppDoctorSearchSuccessStates extends SearchStates {}

class AppDoctorSearchErrorStates extends SearchStates {
  final String error;

  AppDoctorSearchErrorStates(this.error);
}
