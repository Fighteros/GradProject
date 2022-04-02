abstract class AppLoginStates {}

class AppInitialStates extends AppLoginStates {}

class AppLoginLoadingStates extends AppLoginStates {}

class AppLoginSuccessStates extends AppLoginStates {}

class AppLoginErrorStates extends AppLoginStates {
  final String error;

  AppLoginErrorStates(this.error);
}

class InVisiblePass extends AppLoginStates {}
