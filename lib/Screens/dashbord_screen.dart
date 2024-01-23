import 'dart:developer';

import 'package:doctor_appointment_app/Screens/apply_doctor_screen.dart';
import 'package:doctor_appointment_app/Screens/login_screen.dart';
import 'package:doctor_appointment_app/Screens/seen_notification.dart';
import 'package:doctor_appointment_app/Services/ApiServices.dart';
import 'package:doctor_appointment_app/Services/Sharedservices.dart';
import 'package:doctor_appointment_app/model/login_model.dart';
import 'package:flutter/material.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({super.key});

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  @override
  Widget build(BuildContext context) {
    LoginModel? loginDetails = SharedServices.getLoginDetails();
    bool? role;

    if (loginDetails != null && loginDetails.user != null) {
      role = loginDetails.user!.isAdmin;
    }
    if (role == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please log in to access the dashboard."),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        backgroundColor: Colors.grey,
      ),
      body: !role
          ? Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 120,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Color.fromARGB(255, 116, 116, 116))
                              ]),
                          child: Center(child: Text("Home")),
                        ),
                        Container(
                          height: 120,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Color.fromARGB(255, 116, 116, 116))
                              ]),
                          child: Center(child: Text("Appointments")),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorFormScreen()));
                          },
                          child: Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: const Center(child: Text("Apply Doctors")),
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Color.fromARGB(255, 116, 116, 116))
                              ]),
                          child: Center(child: Text("Profile")),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 120,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Color.fromARGB(255, 116, 116, 116))
                              ]),
                          child: const Center(child: Text("Notifications")),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await SharedServices.logout(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (Context) => LoginScreen()));
                          },
                          child: Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text("Logout")),
                          ),
                        ),
                      ],
                    ),
                  ]),
            )
          : Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FutureBuilder(
                                future: Apiservices.getuserdata(),
                                builder: (context, snapshot) {
                                  final notificationLength = snapshot
                                          .data?.user!.notifications!.length
                                          .toString() ??
                                      "";
                                  log(notificationLength.toString());
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SeenNotiScreen()));
                                    },
                                    child: Stack(
                                      children: [
                                        const Icon(
                                          Icons.notifications_outlined,
                                          size: 40,
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: Text(
                                              notificationLength,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text("Home")),
                          ),
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text("Notification")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text(" Doctors")),
                          ),
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text("users")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 15,
                                      color: Color.fromARGB(255, 116, 116, 116))
                                ]),
                            child: Center(child: Text("profile")),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await SharedServices.logout(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (Context) => LoginScreen()));
                            },
                            child: Container(
                              height: 120,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color:
                                            Color.fromARGB(255, 116, 116, 116))
                                  ]),
                              child: Center(child: Text("Logout")),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ) ??
              Container(
                child: Text("opps"),
              ),
    );
  }
}
