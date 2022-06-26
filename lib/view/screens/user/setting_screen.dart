// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccessState) {
          showToast(
              message: 'Data has been updated successfully',
              state: ToastState.SUCCESS);
        } else if (state is UpdateUserDataErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        } else if (state is UpdateUserDataErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        nameController.text = cubit.userModel!.name!;
        emailController.text = cubit.userModel!.email!;
        phoneController.text = cubit.userModel!.phone!;
        addressController.text = cubit.userModel!.address!;
        return SafeArea(
          child: Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            appBar: AppBar(
              iconTheme:
                  IconThemeData(color: isDark ? Colors.white : Colors.black),
              backgroundColor: isDark ? Colors.black : Colors.white,
              title: Text(
                'Setting',
                style: GoogleFonts.balooBhai(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              actions: [
                if (cubit.profileImage != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.upLoadProfileImage(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: phoneController.text.trim());
                        }
                      },
                      child: Text(
                        'UpLoad',
                        style: TextStyle(
                            color: isDark ? Colors.pinkAccent : Colors.teal),
                      ),
                    ),
                  ),
                if (cubit.profileImage == null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserData(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: isDark ? Colors.pink : Colors.teal),
                      ),
                    ),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is UpLoadImageLoadingState ||
                          state is UpdateUserDataLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 75,
                              child: cubit.imageToggle(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isDark ? Colors.pink : Colors.teal,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'User Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                          isDark ? Colors.pink : Colors.teal),
                                )),
                            AuthTextFormField(
                                controller: nameController,
                                hint: 'Name',
                                obSecure: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'please , enter your name !';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                          isDark ? Colors.pink : Colors.teal),
                                )),
                            AuthTextFormField(
                                controller: emailController,
                                hint: 'Email',
                                obSecure: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'please , enter your email !';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                          isDark ? Colors.pink : Colors.teal),
                                )),
                            AuthTextFormField(
                                controller: phoneController,
                                hint: 'Phone',
                                obSecure: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'please , enter your phone !';
                                  } else if (value.toString().length < 11) {
                                    return 'the phone number must not be less than 11 digit';
                                  }
                                  return null;
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
