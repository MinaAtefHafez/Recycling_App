// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling/helper/cache_helper.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/sign_cubit/sign_cubit.dart';
import 'package:recycling/logic/controllers/sign_cubit/states.dart';
import 'package:recycling/view/screens/auth/register_screen.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/reset_password_screen.dart';
import 'package:recycling/view/screens/layout_screen.dart';
import 'package:recycling/view/widgets/auth_button.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit, SignStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.value).then((value) {
            uId = CacheHelper.getData(key: 'uId');
            RecyclingCubit.get(context).getUserData();
            RecyclingCubit.get(context).getUserOrder();
            navigateAndFinish(context, LayoutScreen());
          });
        }

        if (state is LoginErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = SignCubit.get(context);

        return SafeArea(
          child: Scaffold(
            backgroundColor: isDark
                ? Colors.black
                : Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'LOG',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.pink
                                  : Colors.teal,
                            ),
                          ),
                          Text(
                            ' IN',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'login to enjoy a new experience',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 380,
                        child: Card(
                          elevation: 10.0,
                          color: isDark
                              ? Colors.black
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AuthTextFormField(
                                    controller: emailController,
                                    hint: 'Email',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: isDark ? Colors.pink :  Colors.teal,
                                    ),
                                    obSecure: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please , enter your email!';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AuthTextFormField(
                                    controller: passController,
                                    hint: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: isDark ? Colors.pink : Colors.teal,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: cubit.isVisibility
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.deepPurple,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.deepPurple,
                                            ),
                                      onPressed: () {
                                        cubit.visibility();
                                      },
                                    ),
                                    obSecure: cubit.isVisibility,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please , enter your password!';
                                      } else if (value.toString().length < 6) {
                                        return 'password must not be less than 6 char !';
                                      }
                                    },
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, ResetPasswordScreen());
                                      },
                                      child: Text(
                                        'forgot password ?',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! LoginLoadingState,
                                    builder: (context) => AuthButton(
                                        text: 'Login',
                                        color: isDark ? Colors.pink : Colors.teal,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userLogin(
                                                email: emailController.text,
                                                password: passController.text);
                                          }
                                        }),
                                    fallback: (context) => Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I don\'t have an account ?',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Register'))
                        ],
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
