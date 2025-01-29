import 'package:energy_app/features/Auth/Screens/loginPage.dart';
import 'package:energy_app/features/Auth/Screens/sign_up.dart';

import 'package:flutter/material.dart';

class Loginorregisterpage extends StatefulWidget {
  const Loginorregisterpage({super.key});

  @override
  State<Loginorregisterpage> createState() => _LoginorregisterpageState();
}

class _LoginorregisterpageState extends State<Loginorregisterpage> {
  bool showLoginPage = true;

  // ignore: non_constant_identifier_names
  void TogglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: TogglePages,);
    } else {
      return SignUpPage(onTap: TogglePages,);
    }
  }
}