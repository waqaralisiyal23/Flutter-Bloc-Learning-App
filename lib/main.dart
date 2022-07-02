import 'package:bloclearning/vandad11hours/json_files/persons_bloc.dart';
import 'package:bloclearning/vandad11hours/vandad_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonsBloc(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Bloc',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          // home: const CodexHomeScreen(),
          home: const VandadHomeScreen()
          // home: BlocProvider(
          //   create: (context) => PersonsBloc(),
          //   child: ,
          // ),
          ),
    );
  }
}
