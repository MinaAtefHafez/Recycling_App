// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/layout_screen.dart';
import 'package:recycling/view/widgets/auth_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  var appBar = AppBar(
    backgroundColor: isDark ? Colors.black : Colors.white,
    iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      'Order Details',
      style: GoogleFonts.balooBhai(
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        var mq = MediaQuery.of(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            appBar: appBar,
            body: ConditionalBuilder(
                condition: cubit.orderModel != null,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: (mq.size.height -
                                    appBar.preferredSize.height -
                                    mq.padding.top) *
                                0.3,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 100,
                                      height: constraints.maxHeight * 0.35,
                                      child: Image.asset(
                                          'assets/images/request_arrival.png')),
                                  SizedBox(
                                    height: 0.05,
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.07,
                                    child: Text(
                                      'Thank You',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.05,
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.3,
                                    alignment: AlignmentDirectional.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Text(
                                        'Your request has been successfully submitted and awaiting approval',
                                        style: GoogleFonts.balooBhai2(
                                          color: Colors.grey.shade500,
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.05,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: constraints.maxHeight * 0.005,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: (mq.size.height -
                                    appBar.preferredSize.height -
                                    mq.padding.top) *
                                0.2,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: constraints.maxHeight * 0.25,
                                    child: Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        'Request Info',
                                        style: TextStyle(
                                            color: isDark
                                                ? Colors.yellow.shade500
                                                : Colors.grey.shade900,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.7,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_city,
                                          color: isDark
                                              ? Colors.teal
                                              : Colors.grey.shade600,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Location',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.050,
                                              ),
                                              Text(
                                                cubit.orderModel!.address!,
                                                style: TextStyle(
                                                    color: isDark
                                                        ? Colors.grey.shade200
                                                        : Colors.grey.shade800,
                                                    fontSize: 15),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.01,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: constraints.maxHeight * 0.01,
                                    color: Colors.grey.shade500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: (mq.size.height -
                                    appBar.preferredSize.height -
                                    mq.padding.top) *
                                0.2,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: constraints.maxHeight * 0.7,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: isDark
                                              ? Colors.teal
                                              : Colors.grey.shade600,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                '${cubit.orderDeliveryDay}/${cubit.orderModel!.dateTime}',
                                                style: TextStyle(
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.grey.shade800,
                                                    fontSize: 15),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.3,
                                    child: AuthButton(
                                        text: 'Back to Home',
                                        color:
                                            isDark ? Colors.pink : Colors.teal,
                                        onTap: () {
                                          navigateAndFinish(
                                              context, LayoutScreen());
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/no_orders.png'),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'No Orders yet !',
                            style: GoogleFonts.balooBhai(
                              color: Colors.deepPurple,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
