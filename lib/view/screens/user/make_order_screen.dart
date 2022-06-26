// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/user/order_details_screen.dart';
import 'package:recycling/view/widgets/auth_button.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';
import 'package:recycling/view/widgets/radio_button.dart';

class MakeOrderScreen extends StatefulWidget {
  @override
  State<MakeOrderScreen> createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  var formKey = GlobalKey<FormState>();
  var plasticController = TextEditingController();
  var steelController = TextEditingController();
  var paperController = TextEditingController();
  int plasticRadioSelected = 10;  
  int steelRadioSelected = 10;
  int paperRadioSelected = 10;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {
        if (state is SendOrderSuccessState) {
          showToast(
              message: 'The Order has been sent successfully',
              state: ToastState.SUCCESS).then((value) {
                navigateAndFinish(context, OrderDetailsScreen() ) ;
              });
        } else if (state is SendOrderErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }else if ( state is GetOrderErrorState ) {
          showToast(message: state.error , state: ToastState.ERROR );
        }
      },
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: isDark ? Colors.grey.shade600 :Colors.white ,
            appBar: AppBar(
              backgroundColor: isDark ? Colors.grey.shade600 :Colors.white  ,
              iconTheme: IconThemeData(color: isDark ? Colors.white :Colors.black ),
              centerTitle: true,
              elevation: 0.0,
              title: Text(
                'Make Order',
                style: GoogleFonts.balooBhai(color: isDark ? Colors.white : Colors.black),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose your order',
                          style: GoogleFonts.balooBhai(
                              color: Colors.deepPurple, fontSize: 27),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Plastic',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.teal,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text('L'),
                                DefaultRadioButton(
                                    color: Colors.teal,
                                    value: 0,
                                    groupValue: plasticRadioSelected,
                                    onChanged: (val) {
                                      setState(() {
                                        plasticRadioSelected = val!;
                                      });
                                    }),
                              ],
                            ),
                            Column(
                              children: [
                                Text('M'),
                                DefaultRadioButton(
                                    color: Colors.teal,
                                    value: 1,
                                    groupValue: plasticRadioSelected,
                                    onChanged: (val) {
                                      setState(() {
                                        plasticRadioSelected = val!;
                                      });
                                    }),
                              ],
                            ),
                            Column(
                              children: [
                                Text('S'),
                                DefaultRadioButton(
                                    color: Colors.teal,
                                    value: 2,
                                    groupValue: plasticRadioSelected,
                                    onChanged: (val) {
                                      setState(() {
                                        plasticRadioSelected = val!;
                                      });
                                    }),
                              ],
                            ),
                            Expanded(
                              child: AuthTextFormField(
                                smallHint: true,
                                controller: plasticController,
                                hint: 'number',
                                keyboardType: TextInputType.number,
                                obSecure: false,
                                validator: (value) {
                                  if (plasticRadioSelected != 10 && value.isEmpty) {
                                    return 'enter number';
                                  } else if (value.toString().length > 2) {
                                    return 'number must not more than 2';
                                  }else if ( plasticRadioSelected == 10 && steelRadioSelected == 10 && paperRadioSelected == 10  ){
                                    return 'enter number' ;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Steel',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.deepPurple,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DefaultRadioButton(
                                value: 0,
                                color: Colors.deepPurple,
                                groupValue: steelRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    steelRadioSelected = val!;
                                  });
                                }),
                            DefaultRadioButton(
                                color: Colors.deepPurple,
                                value: 1,
                                groupValue: steelRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    steelRadioSelected = val!;
                                  });
                                }),
                            DefaultRadioButton(
                                color: Colors.deepPurple,
                                value: 2,
                                groupValue: steelRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    steelRadioSelected = val!;
                                  });
                                }),
                            Expanded(
                              child: AuthTextFormField(
                                smallHint: true,
                                controller: steelController,
                                hint: 'number',
                                keyboardType: TextInputType.number,
                                obSecure: false,
                                validator: (value) {
                                    if ( steelRadioSelected != 10 && value.isEmpty ){
                                       return 'enter number' ;
                                    } else if (value.toString().length > 2) {
                                    return 'number must not more than 2';
                                  } else if ( plasticRadioSelected == 10 && steelRadioSelected == 10 && paperRadioSelected == 10 ) {
                                    return 'enter number' ;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Paper',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.deepOrange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DefaultRadioButton(
                                value: 0,
                                color: Colors.deepOrange,
                                groupValue: paperRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    paperRadioSelected = val!;
                                  });
                                }),
                            DefaultRadioButton(
                                color: Colors.deepOrange,
                                value: 1,
                                groupValue: paperRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    paperRadioSelected = val!;
                                  });
                                }),
                            DefaultRadioButton(
                                color: Colors.deepOrange,
                                value: 2,
                                groupValue: paperRadioSelected,
                                onChanged: (val) {
                                  setState(() {
                                    paperRadioSelected = val!;
                                  });
                                }),
                            Expanded(
                              child: AuthTextFormField(
                                smallHint: true,
                                controller: paperController,
                                hint: 'number',
                                keyboardType: TextInputType.number,
                                obSecure: false,
                                validator: (value) {

                                  if ( paperRadioSelected != 10 && value.isEmpty ) {
                                    return 'enter number' ;
                                  }else if (value.toString().length > 2) {
                                    return 'number must not more than 2';
                                  }else if (plasticRadioSelected == 10 && steelRadioSelected == 10 && paperRadioSelected == 10){
                                    return 'enter number' ;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        ConditionalBuilder(
                            condition: state is! SendOrderLoadingState ,
                            builder: (context) => Container(
                          width: 150,
                          child: AuthButton(
                              text: 'Send Order',
                              color: Colors.teal,
                              onTap: () {
                                if ( formKey.currentState!.validate() ) {
                                  cubit.sendOrder(
                                    plasticCounter: plasticRadioSelected , 
                                    steelCounter: steelRadioSelected ,
                                     paperCounter: paperRadioSelected , 
                                     plasticQuantity: plasticController.text ,
                                      steelQuantity: steelController.text , 
                                      paperQuantity: paperController.text ,
                                      );
                                }
                              }),
                        ), 
                            fallback: (context) => Center(child: CircularProgressIndicator()) 
                            ),
                      ],
                    ),
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
