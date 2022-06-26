// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling/logic/controllers/sign_cubit/states.dart';
import 'package:recycling/models/user_model.dart';


class SignCubit extends Cubit<SignStates> {
  SignCubit() : super(SignInitialState());

  static SignCubit get(context) => BlocProvider.of(context);


  bool isVisibility = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  String typeItem = 'user';
  String governorateItem = 'october';
  String neighborhoodItem = 'neighborhood 1';

  void visibility() {
    isVisibility = !isVisibility;

    emit(ChangePasswordVisibilityState());
  }

   // Login
 
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit((LoginLoadingState()));

    try {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      emit(LoginSuccessState(user.user!.uid));
    } on FirebaseAuthException catch (error) {
      emit(LoginErrorState(error.message.toString()));
    }
  }

  void changeMenuItem({required String item}) {
    typeItem = item;

    emit(DropdownMenu());
  }

  void changeGovernorateMenuItem({required String item}) {
    governorateItem = item;

    emit(DropdownMenu());
  }

  void changeNeighborhoodMenuItem({required String item}) {
    neighborhoodItem = item;

    emit(DropdownMenu());
  }

 

  // Register

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String governorate,
    required String neighborhood,
    required String address,
    required String type,
  }) async {
    emit((RegisterLoadingState()));

    try {
      var user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCreate(
        name: name,
        email: email,
        password: password,
        phone: phone,
        governorate: governorate,
        neighborhood: neighborhood,
        address: address,
        type: type,
        uId: user.user!.uid,
      );

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (error) {
      emit(RegisterErrorState(error.message.toString()));
    }
  }

  void userCreate(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String governorate,
      required String neighborhood,
      required String address,
      required String type,
      required String uId}) {
    emit(UserCreateLoadingState());

    UserModel model = UserModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      governorate: governorate,
      neighborhood: neighborhood,
      address: address,
      type: type,
      uId: uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState(error.toString()));
    });
  }
}
