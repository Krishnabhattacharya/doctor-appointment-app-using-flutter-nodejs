import 'package:doctor_appointment_app/Screens/dashbord_screen.dart';
import 'package:doctor_appointment_app/Screens/login_screen.dart';
import 'package:doctor_appointment_app/Services/Preferences.dart';
import 'package:doctor_appointment_app/Services/Sharedservices.dart';
import 'package:doctor_appointment_app/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SharedServices.isLoggedIn() ? DashBordScreen() : LoginScreen(),
    );
  }
}
