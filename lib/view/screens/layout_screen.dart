// ignore_for_file: use_key_in_widget_constructors, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';


class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context) ;
        return ConditionalBuilder(
          condition: cubit.userModel != null , 
          builder: (context) => cubit.homeScreen() ,
           fallback: (context) => Center(child: CircularProgressIndicator()) ,
           ) ;
      },
    );
  }
}
