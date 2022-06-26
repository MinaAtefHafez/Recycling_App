
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  
  final TextEditingController controller ; 
  final String hint ;
  final TextInputType? keyboardType ;
  final bool obSecure ;
  final bool? smallHint  ;
  final Widget? prefixIcon ;
  final Widget? suffixIcon ;
  final Function validator ;
  
  
  
  AuthTextFormField ({
    required this.controller , 
    required this.hint ,
     this.prefixIcon ,
    this.suffixIcon ,
    this.keyboardType ,
    this.smallHint ,
    required this.obSecure ,
     required this.validator ,
     
  }) ;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ,
      cursorColor: Colors.black,
       decoration: InputDecoration(
       hintText: '${hint}' ,
       hintStyle: TextStyle( color: Colors.grey.withOpacity(0.9) , 
       fontSize:smallHint != null ?  12 : 16  ,fontWeight: FontWeight.w600 ) ,
      prefixIcon: prefixIcon ,
      suffixIcon: suffixIcon,
      fillColor:Colors.grey.shade200 ,
      filled: true ,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ) , 
        borderRadius: BorderRadius.circular(10.0) ,
        ) ,
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ) , 
        borderRadius: BorderRadius.circular(10.0) ,
        ) ,
        errorBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ) , 
        borderRadius: BorderRadius.circular(10.0) ,
        ) ,
        focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ) , 
        borderRadius: BorderRadius.circular(10.0) ,
        ) ,  
        ),
          keyboardType: keyboardType ,
         validator: (value) => validator(value) ,
         
         obscureText: obSecure,
    );
  }
}
