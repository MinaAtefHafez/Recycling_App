

// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  
  
  final String text ;
  final Color color ;
  final Function() onTap ;

  AuthButton({
    
    required this.text ,
    required this.color ,
    required this.onTap ,
  }); 

  @override
  Widget build(BuildContext context) { 
    return  InkWell(
      onTap:  onTap,
      child: Container( 
              width: double.infinity ,
                 height: 45,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(6) ,
                       color:  color  ,  
                   ),
                    child: Center(
                   child: Text(
                      '${text}' ,
                       style: TextStyle(
                        color: Colors.white  ,
                        fontSize: 18.0 ,
                        fontWeight: FontWeight.w400
                     ) , 
                  ) , 
              ) , 
          ),
    );
  }
}