// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/models/message_model.dart';
import 'package:recycling/models/order_model.dart';
import 'package:recycling/models/user_model.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/collector/collector_home_screen.dart';
import 'package:recycling/view/screens/user/user_home_screen.dart';

class RecyclingCubit extends Cubit<RecyclingStates> {
  RecyclingCubit() : super(RecyclingInitialState());

  static RecyclingCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userModel;
  OrderModel? orderModel;
  File? profileImage;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<MessageModel> messages = [];
  List<OrderModel> orders = [];
  List <int> dayOrders = [] ; 
  String? plasticOrderResult;
  String? steelOrderResult;
  String? paperOrderResult;
  int? orderDeliveryDay;
  

  Widget homeScreen() {
    if (userModel!.type == 'user') {
      return UserHomeScreen();
    }

    return CollectorHomeScreen();
  }

  void resetPassword(String email) {
    emit(ResetPasswordLoadingState());
    auth.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      emit(ResetPasswordErrorState(error.toString()));
    });
  }


  Future <void> changeMode () async{
       isDark = !isDark ;
       emit(ChangeModeState());
  }

  void getUserData() {
    fireStore
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      }).catchError((error) {
        emit(GetUserDataErrorState());
      });
  }

  Future<void> getProfileImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  void upLoadProfileImage({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpLoadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        updateUserData(
            name: name, email: email, phone: phone, profileImage: val);
      });
      emit(UpLoadImageSuccessState());
    }).catchError((error) {
      emit(UpLoadImageErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
    String? profileImage,
  }) {
    emit(UpdateUserDataLoadingState());

    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      address: userModel!.address,
      governorate: userModel!.governorate,
      neighborhood: userModel!.neighborhood,
      password: userModel!.password,
      profileImage: profileImage ?? userModel!.profileImage,
      type: userModel!.type,
      uId: userModel!.uId,
    );

    fireStore
        .collection('users')
        .doc(uId)
        .update(
          model.toMap(),
        )
        .then((value) {
      getUserData();
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  dynamic imageToggle() {
    if (userModel!.profileImage != null && profileImage == null) {
      return CircleAvatar(
        radius: 75,
        backgroundImage: NetworkImage(userModel!.profileImage!),
      );
    } else if (profileImage != null) {
      return CircleAvatar(
        radius: 75,
        backgroundImage: FileImage(profileImage!),
      );
    } else {
      return Image.asset('assets/images/empty_profile.png');
    }
  }

  void sendMessage({
    required String text,
    required String senderId,
  }) async {
    MessageModel model = MessageModel(
        text: text, senderId: senderId, dateTime: DateTime.now().toString());

    fireStore
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc('NxeqTnABLnZqQMaGNCsY3z83tx83')
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    MessageModel model2 = MessageModel(
        text: text, senderId: senderId, dateTime: DateTime.now().toString());

    fireStore
        .collection('users')
        .doc('NxeqTnABLnZqQMaGNCsY3z83tx83')
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model2.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void getMessages() {
    fireStore
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc('NxeqTnABLnZqQMaGNCsY3z83tx83')
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
    emit(GetMessagesSuccessState());
  }

  void sendOrder(
      {required int plasticCounter,
      required int steelCounter,
      required int paperCounter,
      required String plasticQuantity,
      required String steelQuantity,
      required String paperQuantity}) {
    emit(SendOrderLoadingState());

    if (plasticCounter == 0) {
      plasticOrderResult = '$plasticQuantity L plastic';
    } else if (plasticCounter == 1) {
      plasticOrderResult = '$plasticQuantity M plastic';
    } else if (plasticCounter == 2) {
      plasticOrderResult = '$plasticQuantity S plastic';
    } else {
      plasticOrderResult = '0';
    }

    if (steelCounter == 0) {
      steelOrderResult = '$steelQuantity L steel';
    } else if (steelCounter == 1) {
      steelOrderResult = '$steelQuantity M steel';
    } else if (steelCounter == 2) {
      steelOrderResult = '$steelQuantity S steel';
    } else {
      steelOrderResult = '0';
    }

    if (paperCounter == 0) {
      paperOrderResult = '$paperQuantity L paper';
    } else if (paperCounter == 1) {
      paperOrderResult = '$paperQuantity M paper';
    } else if (paperCounter == 2) {
      paperOrderResult = '$paperQuantity S paper';
    } else {
      paperOrderResult = '0';
    }

    OrderModel model = OrderModel(
        name: userModel!.name,
        plastic: plasticOrderResult,
        steel: steelOrderResult,
        paper: paperOrderResult,
        phone: userModel!.phone,
        address:
            '${userModel!.address} , ${userModel!.neighborhood} , ${userModel!.governorate}',
        dateTime: '${DateTime.now().month}/${DateTime.now().year}',
        day: DateTime.now().day.toString(),
        dateSeconds: DateTime.now().toString(),
        governorate: userModel!.governorate,
        neighborhood: userModel!.neighborhood 
        );

    fireStore.collection('orders').doc(uId).set(model.toMap()).then((value) {
      getUserOrder();

      emit(SendOrderSuccessState());
    }).catchError((error) {
      emit(SendOrderErrorState(error.toString()));
    });
  }

  void determineOrderDate(int day) {
    if (day < 3 || day >= 27) {
      orderDeliveryDay = 3;
    } else if (day < 6 && day >= 3) {
      orderDeliveryDay = 6;
    } else if (day < 10 && day >= 6) {
      orderDeliveryDay = 10;
    } else if (day < 13 && day >= 10) {
      orderDeliveryDay = 13;
    } else if (day < 17 && day >= 13) {
      orderDeliveryDay = 17;
    } else if (day < 20 && day >= 17) {
      orderDeliveryDay = 20;
    } else if (day < 24 && day >= 20) {
      orderDeliveryDay = 24;
    } else if (day < 27 && day >= 24) {
      orderDeliveryDay = 27;
    }
  }

  void getUserOrder() {
    fireStore.collection('orders').doc(uId).get().then((value) {
      int? day;
      String dayFromJson = value.data()!['day'];
      day = int.tryParse(dayFromJson)!;
      determineOrderDate(day);
      orderModel = OrderModel.fromJson(value.data()!);
      emit(GetOrderSuccessState());
    }).catchError((error) {
      emit(GetOrderErrorState(error.toString()));
    });
  }

  void getOrders({
    required String governorate,
    required String neighborhood,
  }) {
    emit(GetOrdersLoadingState()) ;
    fireStore.collection('orders').orderBy('dateSeconds').get().then((value) {
      orders = [] ;
      value.docs.forEach((element) {
        if (governorate == element.data()['governorate'] &&
            neighborhood == element.data()['neighborhood']) {
              int day ;
              day =  int.tryParse(element.data()['day'])!;
              determineOrderDate(day);
              dayOrders.add(orderDeliveryDay!);
              orders.add( OrderModel.fromJson(element.data())) ;
        
            } 
      });
      emit(GetOrdersSuccessState()) ;
    }).catchError((error){
       emit(GetOrdersErrorState(error.toString()));
    });
  }

          
}
