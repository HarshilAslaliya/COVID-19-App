import 'package:covid_19_app/views/screens/homepage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff539d91),
        secondary: const Color(0xff539d91),
      )),
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>const HomePage(),
      },
    );
  }
}
