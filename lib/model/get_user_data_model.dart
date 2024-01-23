// To parse this JSON data, do
//
//     final getUserDataModel = getUserDataModelFromJson(jsonString);

import 'dart:convert';

GetUserDataModel getUserDataModelFromJson(String str) =>
    GetUserDataModel.fromJson(json.decode(str));

String getUserDataModelToJson(GetUserDataModel data) =>
    json.encode(data.toJson());

class GetUserDataModel {
  bool? success;
  User? user;

  GetUserDataModel({
    this.success,
    this.user,
  });

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) =>
      GetUserDataModel(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;
  bool? isDoctor;
  List<Notification>? notifications;
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
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x))),
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
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "seenNotifications": seenNotifications == null
            ? []
            : List<dynamic>.from(seenNotifications!.map((x) => x)),
        "__v": v,
      };
}

class Notification {
  String? type;
  String? message;
  Data? data;

  Notification({
    this.type,
    this.message,
    this.data,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        type: json["type"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? doctorId;
  String? name;
  String? onClickPath;

  Data({
    this.doctorId,
    this.name,
    this.onClickPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorId: json["doctorId"],
        name: json["name"],
        onClickPath: json["onClickPath"],
      );

  Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "name": name,
        "onClickPath": onClickPath,
      };
}
