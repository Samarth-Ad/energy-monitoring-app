import 'package:energy_app/Helpers/warning.dart';
import 'package:energy_app/features/Auth/Screens/complete_profile.dart';
import 'package:energy_app/pages/Home_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_pallet.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // List of states in India
  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  String? _selectedState;
  bool _obscurePassword = true;

  // sign_up function
  void registerUser() async {
    // Validate user input
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty ||
        _selectedState == null) {
      Sign_up_warning("All fields are required!", context);
      return;
    }
    if (password.length < 6) {
      Sign_up_warning("Password must be at least 6 characters long.", context);
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pop(context); // Close the loading dialog

      // Navigate to the Complete Profile Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(),
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      Sign_up_warning(
          "An unexpected error occurred. Please try again.", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "SIGN UP NOW",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.secondaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon:
                      Icon(Icons.email, color: AppPalette.secondaryColor),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon:
                      Icon(Icons.lock, color: AppPalette.secondaryColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppPalette.secondaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon:
                      Icon(Icons.phone, color: AppPalette.secondaryColor),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select your state'),
                value: _selectedState,
                items: _states.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a state' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic here
                  final email = emailController.text;
                  final password = passwordController.text;
                  final phoneNumber = phoneNumberController.text;
                  final state = _selectedState;

                  registerUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context,
                      '/login_with_state'); // Assuming you have a login route
                },
                child: Text(
                  "Already have an account? LOGIN",
                  style: TextStyle(
                    color: AppPalette.secondaryColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
