import 'package:electricity_app_home/Theme/theme.dart';
import 'package:electricity_app_home/Theme/theme_provider.dart';
import 'package:electricity_app_home/pages/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    child:  MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner:false ,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}