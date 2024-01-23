import 'dart:developer';

import 'package:doctor_appointment_app/Screens/dashbord_screen.dart';
import 'package:doctor_appointment_app/Screens/register_screen.dart';
import 'package:doctor_appointment_app/Services/ApiServices.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login page")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(hintText: "Enter email"),
              controller: emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(hintText: "Enter password"),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;
                Apiservices.loginUser(email: email, password: password)
                    .then((value) {
                  if (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashBordScreen()));
                  }
                });
                log('Email: $email, Password: $password');
                // Add your login logic here
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
