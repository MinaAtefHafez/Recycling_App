// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycling/helper/cache_helper.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/login_screen.dart';
import 'package:recycling/view/screens/user/chat_screen.dart';
import 'package:recycling/view/screens/user/make_order_screen.dart';
import 'package:recycling/view/screens/user/order_details_screen.dart';
import 'package:recycling/view/screens/user/setting_screen.dart';
import 'package:recycling/view/widgets/home_item.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclingCubit, RecyclingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecyclingCubit.get(context);
        var mq = MediaQuery.of(context);
        return SafeArea(
          child: ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => Scaffold(
              backgroundColor: Colors.grey.shade100, 
              appBar: AppBar(
                backgroundColor: Colors.grey.shade100,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'Home',
                  style: GoogleFonts.balooBhai(color: Colors.black ,fontSize: mq.size.width > 600 ? 30 : 20  ),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: 50),
                    alignment: Alignment.center,
                    child: Text(
                      'Ps :  0',
                      style: TextStyle(
                          color: isDark
                              ? Color.fromARGB(255, 22, 139, 165)
                              : Color.fromARGB(255, 214, 195, 25),
                          fontWeight: FontWeight.bold,
                          fontSize: mq.size.width > 600 ? 25 : 18),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                backgroundColor: isDark
                    ? Color.fromARGB(255, 11, 3, 47)
                    : Colors.teal.shade900,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DrawerHeader(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              child: RecyclingCubit.get(context).imageToggle(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                RecyclingCubit.get(context).userModel!.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.balooBhai(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(
                          Icons.accessibility_new_outlined,
                          size: 30,
                        ),
                        title: Text(
                          'About us',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(
                          Icons.chat,
                          size: 30,
                        ),
                        title: Text(
                          'Contact us',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          navigateTo(context, ChatScreen());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Switch(
                          value: isDark,
                          onChanged: (value) {
                            RecyclingCubit.get(context)
                                .changeMode()
                                .then((val) {
                              CacheHelper.saveData(
                                  key: 'isDark', value: isDark);
                            });
                          },
                        ),
                        title: Text(
                          'dark mode',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(
                          Icons.share,
                          size: 30,
                        ),
                        title: Text(
                          'Share App',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        title: Text(
                          'Setting',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          navigateTo(context, SettingScreen());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(
                          Icons.arrow_circle_left,
                          size: 30,
                        ),
                        title: Text(
                          'Sign Out',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          CacheHelper.removeData(key: 'uId').then((value) {
                            navigateAndFinish(context, LoginScreen());
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Color.fromARGB(255, 11, 3, 47)
                                : Colors.teal,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: mq.size.width > 600 ? 90 :  60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Recycling',
                                      style: GoogleFonts.balooBhai(
                                        color:
                                            isDark ? Colors.pink : Colors.teal,
                                        fontSize: mq.size.width > 600 ? 30 : 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HomeItem(
                                  onTap: () {
                                    navigateTo(context, MakeOrderScreen());
                                  },
                                  text: 'Make Order',
                                  urlImage: 'assets/images/make_order.png',
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                HomeItem(
                                  onTap: () {
                                    navigateTo(context, OrderDetailsScreen());
                                  },
                                  text: 'Order Details',
                                  urlImage: 'assets/images/order_details.png',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
              ),
            ),
          ),
        );
      },
    );
  }
}
