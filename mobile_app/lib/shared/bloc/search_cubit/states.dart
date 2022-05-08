abstract class SearchStates {}

class AppInitialStates extends SearchStates {}

// // ______________________________________get Doctor States ______________________________________________________

class AppSearchLoadingStates extends SearchStates {}

class AppSearchSuccessStates extends SearchStates {}

class AppSearchErrorStates extends SearchStates {
  final String error;

  AppSearchErrorStates(this.error);
}
