import 'dart:convert';
import 'package:doctor_appointment_app/Services/Preferences.dart';
import 'package:doctor_appointment_app/model/login_model.dart';
import 'package:flutter/material.dart';

//**************************************************************************** *//
//EMPORTANT                 //EMPORTANT                    //EMPORTANT

//%%%%%%%%%%%$$$$$$$$$$$$$###############@@@@@@@@@@@@@@@@@@@@@@@@@

//write this two line in main function

//------>>>     WidgetsFlutterBinding.ensureInitialized();
//---->>>     preferences = await SharedPreferences.getInstance();

//%%%%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$########################

class SharedServices {
  // //set// token//-------------------------------------------
  // static void setToken({required String token}) {
  //   preferences!.setString("token", token);
  // }

  // //get token==================================================
  // static String getToken() {
  //   final String token = preferences!.getString('token') ?? '';
  //   return token;
  // }

//set all the login details-----------------------------------
  static Future<void> setLoginDetails(LoginModel? usermodel) async {
    if (usermodel != null) {
      preferences!.setString("login_details", jsonEncode(usermodel.toJson()));
    }
  }

// get the login details------------------------------------
  static LoginModel? getLoginDetails() {
    String? jsonDetails = preferences!.getString("login_details");
    if (jsonDetails != null) {
      return LoginModel.fromJson(jsonDecode(jsonDetails));
    }
    return null;
  }

//for login check//----------------------------------------
  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

//for logout//--------------------------------------------
  static Future<bool> logout(BuildContext context) async {
    await preferences!.clear();
    return true;
  }
}
