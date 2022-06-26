// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/models/message_model.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';

class ChatScreen extends StatelessWidget {
  var controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        RecyclingCubit.get(context).getMessages();

        return BlocConsumer<RecyclingCubit, RecyclingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = RecyclingCubit.get(context);

            return SafeArea(
              child: Scaffold(
                backgroundColor: isDark ? Color.fromARGB(255, 11, 3, 47) : Colors.white ,
                appBar: AppBar(
                  backgroundColor: isDark ? Colors.grey.shade600 : Colors.teal,
                  iconTheme: IconThemeData(color: Colors.white),
                  elevation: 5,
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.deepPurple.withOpacity(0.5),
                        child: Text(
                          'Rec',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Recycling',
                        style: GoogleFonts.balooBhai(
                            fontSize: 19, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              MessageModel model = cubit.messages[index];

                              if (model.senderId == cubit.userModel!.uId) {
                                return myMessage(model);
                              } else {
                                return hisMessage(model);
                              }
                              return Text('');
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: cubit.messages.length),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: AuthTextFormField(
                                controller: controller,
                                hint: 'write here ...',
                                obSecure: false,
                                validator: (value) {
                                  if ( value.isEmpty ) {
                                    return 'enter message to chat !';
                                  }
                                  return null ;
                                },
                                
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          InkWell(
                              onTap: () {
                                if ( formKey.currentState!.validate() ) {
                                  cubit.sendMessage(
                                    text: controller.text,
                                    senderId: cubit.userModel!.uId!);
                                }
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.teal,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget myMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.greenAccent :  Colors.green.withOpacity(0.4),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(model.text!),
        ),
      ),
    );
  }

  Widget hisMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white : Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(model.text!),
        ),
      ),
    );
  }
}
