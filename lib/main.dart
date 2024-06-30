import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_palmcode/page/home/home_page.dart';
import 'package:test_palmcode/routes/pages_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: PagesRoute.pages,
      home: HomePage(),
    );
  }
}
