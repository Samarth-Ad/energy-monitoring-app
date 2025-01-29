import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_pallet.dart';

class CompleteProfilePage extends StatefulWidget {
  final String userId; // Pass the userId after registration
  const CompleteProfilePage({super.key, required this.userId});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void saveProfile() async {
    final username = usernameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (username.isEmpty || phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("All fields are required."),
        ),
      );
      return;
    }

    if (!RegExp(r'^\+91\d{10}$').hasMatch(phoneNumber)) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Please enter a valid mobile number (+91XXXXXXXXXX)."),
        ),
      );
      return;
    }

    // Save to Firestore
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
        'username': username,
        'phoneNumber': phoneNumber,
      });
      Navigator.pop(context); // Navigate back or to the login page
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      appBar: AppBar(
        title: const Text("Complete Profile"),
        backgroundColor: AppPalette.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person, color: AppPalette.secondaryColor),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: "Mobile Number (+91)",
                prefixIcon: Icon(Icons.phone, color: AppPalette.secondaryColor),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "SAVE PROFILE",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
