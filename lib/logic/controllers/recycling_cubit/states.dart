abstract class RecyclingStates {}

class RecyclingInitialState extends RecyclingStates {}


// change Mode

class ChangeModeState extends RecyclingStates {}

// reset password

class ResetPasswordLoadingState extends RecyclingStates {} 

class ResetPasswordSuccessState extends RecyclingStates {}

class ResetPasswordErrorState extends RecyclingStates {
  final String error;

  ResetPasswordErrorState(this.error);
} 

// getUserData

class GetUserDataSuccessState extends RecyclingStates {}

class GetUserDataErrorState extends RecyclingStates {}

// send Message

class SendMessageSuccessState extends RecyclingStates {}

class SendMessageErrorState extends RecyclingStates {}

// get Messages

class GetMessagesSuccessState extends RecyclingStates {}

// image picker

class ProfileImagePickedSuccessState extends RecyclingStates {}

class ProfileImagePickedErrorState extends RecyclingStates {}

// upLoadImage

class UpLoadImageLoadingState extends RecyclingStates {}

class UpLoadImageSuccessState extends RecyclingStates {}

class UpLoadImageErrorState extends RecyclingStates {
  final String error;

  UpLoadImageErrorState(this.error);
}

// update user date

class UpdateUserDataLoadingState extends RecyclingStates {}

class UpdateUserDataSuccessState extends RecyclingStates {}

class UpdateUserDataErrorState extends RecyclingStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}

// send Order

class SendOrderLoadingState extends RecyclingStates {}

class SendOrderSuccessState extends RecyclingStates {}

class SendOrderErrorState extends RecyclingStates {
  String error;

  SendOrderErrorState(
    this.error,
  );
}

// get Order

class GetOrderSuccessState extends RecyclingStates {}

class GetOrderErrorState extends RecyclingStates {
  String error;
  GetOrderErrorState(
    this.error,
  );
}

// get Orders

class GetOrdersLoadingState extends RecyclingStates {}

class GetOrdersSuccessState extends RecyclingStates {}

class GetOrdersErrorState extends RecyclingStates {
  final String error ;
  GetOrdersErrorState(
    this.error,
  );
}
