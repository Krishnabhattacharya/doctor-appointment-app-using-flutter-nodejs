import 'dart:convert';

import 'package:doctor_appointment_app/Services/ApiServices.dart';
import 'package:flutter/material.dart';

class DoctorFormScreen extends StatefulWidget {
  @override
  _DoctorFormScreenState createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Doctor Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Doctor Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  // You can add more email validation logic if needed
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: specializationController,
                decoration: InputDecoration(labelText: 'Specialization'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Specialization';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(labelText: 'Experience'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Experience';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: feesController,
                decoration: InputDecoration(labelText: 'Fees'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Fees';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: startTimeController,
                decoration: InputDecoration(labelText: 'Start Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Start Time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: endTimeController,
                decoration: InputDecoration(labelText: 'End Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter End Time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Doctor doctor = Doctor(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      specialization: specializationController.text,
                      exprience: experienceController.text,
                      fees: double.parse(feesController.text),
                      timming: Timming(
                        start: startTimeController.text,
                        end: endTimeController.text,
                      ),
                    );
                    String jsonString = jsonEncode(doctor.toJson());
                    print('JSON String: $jsonString');
                    _formKey.currentState!.reset();
                    Apiservices.applyDoctor(doctor.toJson());
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Timming {
  String start = '';
  String end = '';

  Timming({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}

class Doctor {
  String name = '';
  String phone = '';
  String email = '';
  String address = '';
  String specialization = '';
  String exprience = '';
  double fees = 0.0;
  Timming timming = Timming(start: '', end: '');

  Doctor({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.specialization,
    required this.exprience,
    required this.fees,
    required this.timming,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'specialization': specialization,
      'exprience': exprience,
      'fees': fees,
      'timming': timming.toJson(),
    };
  }
}
