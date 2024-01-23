import 'dart:developer';

import 'package:doctor_appointment_app/Screens/login_screen.dart';
import 'package:doctor_appointment_app/Services/ApiServices.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  final List<String> _list = <String>["user", "admin"];
  String _pet = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register page")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < _list.length; i++)
              ListTile(
                title: Text(
                  _list[i],
                  style: const TextStyle(fontSize: 22),
                ),
                leading: customRadioButton(_list[i], _pet, (pet) {
                  setState(() {
                    _pet = pet;
                    log(_pet);
                  });
                }),
              ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "enter name"),
              controller: t1,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "enter email"),
              controller: t2,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "enter password"),
              controller: t3,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                Apiservices.signupUser(
                    name: t1.text,
                    email: t2.text,
                    password: t3.text,
                    status: _pet);
              },
              child: const Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text("Already have an account? click here"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customRadioButton(
  String pet,
  String groupValue,
  Function(String pet) onValue,
) {
  return Radio(
    value: pet,
    groupValue: groupValue,
    onChanged: (val) {
      onValue(val!);
    },
    fillColor: MaterialStateProperty.all(Colors.red),
    overlayColor: MaterialStateProperty.all(Colors.black),
  );
}
