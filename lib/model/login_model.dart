// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  User? user;
  String? token;

  LoginModel({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;
  bool? isDoctor;
  List<dynamic>? notifications;
  List<dynamic>? seenNotifications;
  int? v;

  User({
    this.id,
    this.name,
    this.email,
    this.isAdmin,
    this.isDoctor,
    this.notifications,
    this.seenNotifications,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isDoctor: json["isDoctor"],
        notifications: json["notifications"] == null
            ? []
            : List<dynamic>.from(json["notifications"]!.map((x) => x)),
        seenNotifications: json["seenNotifications"] == null
            ? []
            : List<dynamic>.from(json["seenNotifications"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "isAdmin": isAdmin,
        "isDoctor": isDoctor,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x)),
        "seenNotifications": seenNotifications == null
            ? []
            : List<dynamic>.from(seenNotifications!.map((x) => x)),
        "__v": v,
      };
}
