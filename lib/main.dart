import 'package:energy_app/features/Auth/Screens/sign_up.dart';
import 'package:energy_app/firebase_options.dart';
import 'package:energy_app/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/Auth/Screens/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // initialRoute: '/signup', // You might want to adjust this based on your app's flow
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login_with_state': (context) => const LoginPage(),
        // '/home': (context) => const HomePage(), // Added route for HomePage
        // '/calculations': (context) => const calculationPage(), // Added route for CalculationsPage
      },
      home: MainPage(), // Or set your desired initial screen here
    );
  }
}
