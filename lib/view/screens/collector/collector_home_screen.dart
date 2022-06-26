// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/collector/collector_order_Details_screen.dart';
import 'package:recycling/view/widgets/auth_text_form_field.dart';
import 'package:recycling/view/widgets/flutter_toast.dart';

class CollectorHomeScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var governorateController = TextEditingController();
  var neighborhoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {
        if (state is GetOrdersErrorState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Orders',
                style: GoogleFonts.balooBhai(
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: AuthTextFormField(
                                    controller: governorateController,
                                    smallHint: true,
                                    hint: ' governorate',
                                    obSecure: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'enter governorate name';
                                      }
                                      return null;
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 40,
                                child: AuthTextFormField(
                                    controller: neighborhoodController,
                                    smallHint: true,
                                    hint: ' neighborhood',
                                    obSecure: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'enter neighborhood name';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.getOrders(
                                  governorate:
                                      governorateController.text.trim(),
                                  neighborhood:
                                      neighborhoodController.text.trim());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is GetOrdersLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                  if (state is GetOrdersSuccessState)
                    ConditionalBuilder(
                      condition: cubit.orders.length > 0,
                      fallback: (context) => Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'No Orders Yet !',
                            style: GoogleFonts.balooBhai(
                              color: Colors.deepPurple,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildOrderItem( cubit , context ,  index),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: cubit.orders.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderItem( RecyclingCubit cubit , context , int index) {
    return InkWell(
      onTap: () {
        navigateTo(context, CollectorOrderDetailsScreen(index) ) ;
      },
      child: Container(
        width: double.infinity,
        height: 120,
        child: Card(
          color: Colors.teal.shade300,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    cubit.orders[index].name!,
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 18 ,
                    fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: double.infinity,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          cubit.orders[index].address!,
                          style: TextStyle(color: Colors.yellowAccent),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${cubit.dayOrders[index]}/${cubit.orders[index].dateTime}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
