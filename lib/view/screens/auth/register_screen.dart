// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/sign_cubit/sign_cubit.dart';
import 'package:recycling/logic/controllers/sign_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/login_screen.dart';
import 'package:recycling/view/widgets/auth_button.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  List<String> typePerson = [
    'user',
    'buyer',
    'collector',
  ];
  List<String> governorate = [
    'october',
  ];

  List<String> neighborhoods = [
    'neighborhood 1',
    'neighborhood 2',
    'neighborhood 3',
    'neighborhood 4',
    'neighborhood 5',
    'neighborhood 6',
    'neighborhood 7',
    'neighborhood 8',
    'neighborhood 9',
    'neighborhood 10',
    'neighborhood 11',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit, SignStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }

        if (state is RegisterErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = SignCubit.get(context);

        return Scaffold(
          backgroundColor: isDark? Colors.black : Colors.white  ,
          appBar: AppBar(
            backgroundColor: isDark ? Colors.black : Colors.white ,
            iconTheme: IconThemeData(
                color: isDark
                    ? Colors.white
                    : Colors.black),
            title: Text(
              'Register',
              style: TextStyle(
                color: isDark 
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Sign ',
                            style: TextStyle(
                                color: isDark ? Colors.pink : Colors.teal,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Up',
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'Register to enjoy a new experience',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      AuthTextFormField(
                        controller: nameController,
                        hint: 'User Name',
                        prefixIcon: Icon(
                          Icons.account_box,
                          color: isDark ? Colors.pink : Colors.teal,
                        ),
                        obSecure: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please , enter your email!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AuthTextFormField(
                        controller: emailController,
                        hint: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: isDark?Colors.pink : Colors.teal,
                        ),
                        obSecure: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please , enter your email!';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
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
                      SizedBox(
                        height: 10,
                      ),
                      AuthTextFormField(
                        controller: phoneController,
                        hint: 'Phone',
                        prefixIcon: Icon(
                          Icons.phone,
                          color:  isDark ? Colors.pink : Colors.teal,
                        ),
                        obSecure: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please , enter your email!';
                          } else if (value.toString().length < 11) {
                            return 'phone Number must not be less than 11 number !';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'المحافظة',
                                  style: TextStyle(fontSize: 14 ,
                                  color: isDark ? Colors.white : Colors.black 
                                  
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.grey.shade200,
                                      elevation: 15,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      value: cubit.governorateItem,
                                      items: governorate.map((item) {
                                        return DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: Colors.black ,
                                                  fontSize: 13 , 
                                                  ),
                                            ),
                                          ),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (item) {
                                        cubit.changeGovernorateMenuItem(
                                            item: item!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'الحى',
                                  style: TextStyle(fontSize: 14 , 
                                  color: isDark ? Colors.white : Colors.black ,   
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.grey.shade200,
                                      elevation: 15,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          ),
                                      value: cubit.neighborhoodItem,
                                      items: neighborhoods.map((item) {
                                        return DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                   fontSize: 13 
                                                  ),
                                            ),
                                          ),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (item) {
                                        cubit.changeNeighborhoodMenuItem(
                                            item: item!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextFormField(
                              controller: addressController,
                              smallHint: true,
                              hint:
                                  'street name / building number / Apartment number',
                              prefixIcon: Icon(
                                Icons.location_city,
                                color:  isDark ? Colors.pink : Colors.teal,
                              ),
                              obSecure: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'please , enter your email!';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButton<String>(
                              dropdownColor: isDark ? Colors.pink : Colors.deepPurple,
                              elevation: 15,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              value: cubit.typeItem,
                              items: typePerson.map((item) {
                                return DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (item) {
                                cubit.changeMenuItem(item: item!);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Center(
                          child: AuthButton(
                            color: isDark ? Colors.pink : Colors.teal,
                            text: 'SignUp',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passController.text,
                                  phone: phoneController.text.trim(),
                                  governorate: cubit.governorateItem,
                                  neighborhood: cubit.neighborhoodItem,
                                  address: addressController.text,
                                  type: cubit.typeItem,
                                );
                              }
                            },
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
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
