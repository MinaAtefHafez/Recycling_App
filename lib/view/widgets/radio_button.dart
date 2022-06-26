// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class DefaultRadioButton extends StatelessWidget {
   
   final int value ;
   final int groupValue ;
   final Function (int? val) onChanged ;
   Color? color ;

   DefaultRadioButton ({
     required this.value ,
     required this.groupValue ,
     required this.onChanged,
     this.color ,
   });

  @override
  Widget build(BuildContext context) {
    return Radio(
       
      value: value ,
       groupValue: groupValue , 
       onChanged: onChanged , 
       activeColor: color  ,
       );
  }
}
