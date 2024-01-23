import 'dart:developer';

import 'package:doctor_appointment_app/Services/ApiBaseServices.dart';
import 'package:doctor_appointment_app/Services/Sharedservices.dart';
import 'package:doctor_appointment_app/model/get_user_data_model.dart';
import 'package:doctor_appointment_app/model/login_model.dart';
import 'package:doctor_appointment_app/model/seen_notfication.dart';
import 'package:http/retry.dart';

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
      log("heloo");
      log(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        node = loginModelFromJson(response.body);
        SharedServices.setLoginDetails(node);
        res = true;
      }
      return res;
    } catch (e) {
      print("Exception while login ===$e");
      return false;
    }
  }

//---------------------------------------------------------------------------------------------------------
  static Future<GetUserDataModel> getuserdata() async {
    GetUserDataModel getuserDataModel = GetUserDataModel();
    try {
      final response = await ApiBaseServices.getRequestWithHeaders(
          endPoint: "/user/getUserData");
      //  log(response.statusCode.toString());
      if (response.statusCode == 200) {
        //log(response.body);
        getuserDataModel = getUserDataModelFromJson(response.body);
        return getuserDataModel;
      }
      return getuserDataModel;
    } catch (e) {
      log(e.toString());
      return getuserDataModel;
    }
  }

//---------------------------------------------------------------------------------------------
  static Future<SeenNotification> seenAllNoti() async {
    SeenNotification seen = SeenNotification();
    try {
      log("id is${SharedServices.getLoginDetails()!.user!.id}");
      final response = await ApiBaseServices.postRequestWithHeader(
          endPoint: "/user/get-all-notification",
          body: {"_id": SharedServices.getLoginDetails()!.user!.id.toString()});
      log("id is${SharedServices.getLoginDetails()!.user!.id}");
      log(response.body);
      if (response.statusCode == 200) {
        seen = seenNotificationFromJson(response.body);
        return seen;
      }
      return seen;
    } catch (e) {
      log("from log in seeennoti $e");
      return seen;
    }
  }

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

  //-----------------------------------------------------------------------------------------
//aaply doctor
  static Future<void> applyDoctor(Map<String, dynamic> data) async {
    try {
      final res = await ApiBaseServices.postRequestWithHeader(
          endPoint: "/user/apply-doctor", body: data);
      if (res.statusCode == 200) {
        log("success");
      } else {
        log("not success from else");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //delete all notificatoion-------------------------------------------------------------------------
  static Future<bool> deleteNoti() async {
    bool isSuccess = true;
    try {
      final res = await ApiBaseServices.postRequestWithoutBody(
        endPoint: "/user/delete-all-notification",
      );
      if (res.statusCode == 200) {
        log("success");
        isSuccess = false;
      } else {
        log("not success from else");
        isSuccess = true;
      }
    } catch (e) {
      log(e.toString());
      isSuccess = true;
    }
    return isSuccess;
  }
}
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------
