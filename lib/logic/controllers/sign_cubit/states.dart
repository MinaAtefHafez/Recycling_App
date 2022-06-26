abstract class SignStates {}

class SignInitialState extends SignStates {}

// Login

class ChangePasswordVisibilityState extends SignStates {}

class LoginLoadingState extends SignStates {}

class LoginSuccessState extends SignStates {
  final String value;

  LoginSuccessState(this.value);
}

class LoginErrorState extends SignStates {
  final String error;

  LoginErrorState(this.error);
}

// DropDownMenu

class DropdownMenu extends SignStates {}

// Register

class RegisterLoadingState extends SignStates {}

class RegisterSuccessState extends SignStates {}

class RegisterErrorState extends SignStates {
  final String error;

  RegisterErrorState(this.error);
}

class UserCreateLoadingState extends SignStates {}

class UserCreateSuccessState extends SignStates {}

class UserCreateErrorState extends SignStates {
  final String error;

  UserCreateErrorState(this.error);
}


