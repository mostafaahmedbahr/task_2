import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:task_2/core/sh.dart';
import 'package:task_2/firebase_options.dart';
import 'package:task_2/screens/home/cubit/home_cubit.dart';
import 'package:task_2/screens/layout/cubit/layout_cubit.dart';
import 'package:task_2/screens/login/cubit/login_cubit.dart';
import 'package:task_2/screens/register/cubit/register_cubit.dart';
import 'package:task_2/screens/search/cubit/search_cubit.dart';
import 'package:task_2/screens/splash/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.init();
  // if (Platform.isIOS) {
  //   await Firebase.initializeApp();
  // } else if(Platform.isAndroid) {
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log("0"*30);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => LayoutCubit() ),
        BlocProvider(create: (context) => RegisterCubit() ),
        BlocProvider(create: (context) => HomeCubit()..getAllBooksDataInHome() ),
        BlocProvider(create: (context) => LoginCubit() ),
        BlocProvider(create: (context) => SearchCubit()..getAllBooksData()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
      ),
    );
  }
}