// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';


class CollectorOrderDetailsScreen extends StatelessWidget {
  int index;
  CollectorOrderDetailsScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade200,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'Client Order Details',
              style: GoogleFonts.balooBhai(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 10.0,
                    color: Colors.teal.shade500,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.yellow.shade400,
                                size: 33,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(cubit.orders[index].name!,
                                  style: GoogleFonts.balooThambi2(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.yellow.shade400,
                                size: 33,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                    '${cubit.orders[index].address}',
                                    style: GoogleFonts.balooThambi2(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines:3 ,
                                    overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.yellow.shade400,
                                size: 33,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(cubit.orders[index].phone!,
                                  style: GoogleFonts.balooThambi2(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('plastic  :',
                                  style: GoogleFonts.balooThambi2(
                                    color: Colors.yellow.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  cubit.orders[index].plastic! ,
                                style: GoogleFonts.balooThambi2(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('steel  :',
                                  style: GoogleFonts.balooThambi2(
                                    color: Colors.yellow.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                cubit.orders[index].steel!,
                                style: GoogleFonts.balooThambi2(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('paper  :',
                                  style: GoogleFonts.balooThambi2(
                                    color: Colors.yellow.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                               cubit.orders[index].paper!,
                                style: GoogleFonts.balooThambi2(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.time_to_leave,
                                color: Colors.yellow.shade400,
                                size: 33,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                   '${cubit.dayOrders[index]}/${cubit.orders[index].dateTime}' ,
                                style: GoogleFonts.balooThambi2(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
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
}
