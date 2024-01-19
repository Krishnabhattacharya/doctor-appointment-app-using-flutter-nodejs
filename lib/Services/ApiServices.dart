import 'dart:developer';

import 'package:doctor_appointment_app/Services/ApiBaseServices.dart';
import 'package:doctor_appointment_app/Services/Sharedservices.dart';
import 'package:doctor_appointment_app/model/login_model.dart';

class Apiservices {
  static Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    bool res = false;
    LoginModel node = LoginModel();
    try {
      final response = await ApiBaseServices.loginUser(
        Exturl: "/user/login",
        email: email,
        password: password,
      );
      log(response.body);
      node = loginModelFromJson(response.body);
      SharedServices.setLoginDetails(node);
      res = true;

      return res;
    } catch (e) {
      print("Exception while login ===$e");
      return false;
    }
  }

//---------------------------------------------------------------------------------------------------------
  // static Future<List> fetchData() async {
  //   List<dynamic> usermodel = [];
  //   try {
  //     final response = await ApiBaseServices.getRequest(endPoint: '/tasks');
  //     if (response.statusCode == 200) {
  //       usermodel = userModelFromJson(response.body);
  //     } else {
  //       usermodel = [];
  //     }
  //   } catch (e) {
  //     usermodel = [];
  //     print('Error while fetching data: $e');
  //   }
  //   return usermodel;
  // }

//---------------------------------------------------------------------------------------------------------
  static Future<bool> signupUser({
    required String name,
    required String email,
    required String password,
    required String status,
  }) async {
    bool isSign = false;
    try {
      final res = await ApiBaseServices.postRequest(
          endPoint: "/user/register",
          body: {
            "name": name,
            "email": email,
            "password": password,
            "role": status
          });
      if (res.statusCode == 201) {
        isSign = true;
      }
    } catch (e) {
      isSign = false;
    }
    return isSign;
  }
}
