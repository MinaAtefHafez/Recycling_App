// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling/helper/cache_helper.dart';
import 'package:recycling/logic/controllers/recycling_cubit/cubit.dart';
import 'package:recycling/logic/controllers/recycling_cubit/states.dart';
import 'package:recycling/logic/controllers/sign_cubit/sign_cubit.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/login_screen.dart';
import 'package:recycling/view/screens/layout_screen.dart';
import 'package:recycling/view/screens/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  if (onBoarding != null) {
    if (uId != null) {
      widget = LayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return RecyclingCubit()
              ..getUserData()
              ..getUserOrder();
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return SignCubit();
          },
        ),
      ],
      child: BlocConsumer<RecyclingCubit, RecyclingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                elevation: 0.0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
