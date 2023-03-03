import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_rapida/pages/home_binding.dart';
import 'package:pizza_rapida/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        primarySwatch: Colors.blue,
      ),
      initialBinding: HomeBinding(),
      home: HomePage(),
    );
  }
}
