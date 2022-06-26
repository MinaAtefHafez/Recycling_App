// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/login_screen.dart';
import 'package:recycling/view/widgets/auth_button.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';

class ResetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          showToast(
              message: 'Check your Email to reset password',
              state: ToastState.SUCCESS).then((value) {
                navigateAndFinish(context, LoginScreen() ) ;
              });
        } else if (state is ResetPasswordErrorState) {
          showToast(
              message: 'Check your Email to reset password',
              state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'reset Password',
                style: GoogleFonts.balooBhai(color: Colors.black),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Image.asset('assets/images/forgotpass.png'),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Enter your email to reset password',
                      style: GoogleFonts.balooBhai2(color: Colors.deepPurple),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthTextFormField(
                        controller: emailController,
                        hint: 'email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.teal,
                        ),
                        obSecure: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please , enter your email !';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    ConditionalBuilder(
                        condition: state is! ResetPasswordLoadingState,
                        builder: (context) => SizedBox(
                            width: 150,
                            child: AuthButton(
                                text: 'Send',
                                color: Colors.teal,
                                onTap: () {

                                  
                                })),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator())),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
