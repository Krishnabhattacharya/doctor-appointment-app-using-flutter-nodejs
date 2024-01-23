import 'dart:convert';

SeenNotification seenNotificationFromJson(String str) =>
    SeenNotification.fromJson(json.decode(str));

String seenNotificationToJson(SeenNotification data) =>
    json.encode(data.toJson());

class SeenNotification {
  bool? success;
  String? message;
  Data? data;

  SeenNotification({
    this.success,
    this.message,
    this.data,
  });

  factory SeenNotification.fromJson(Map<String, dynamic> json) {
    try {
      return SeenNotification(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
    } catch (e) {
      print("Error decoding SeenNotification: $e");
      return SeenNotification();
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;
  bool? isDoctor;
  List<dynamic>? notifications;
  List<SeenNotificationElement>? seenNotifications;
  int? v;

  Data({
    this.id,
    this.name,
    this.email,
    this.isAdmin,
    this.isDoctor,
    this.notifications,
    this.seenNotifications,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
            : List<SeenNotificationElement>.from(json["seenNotifications"]!
                .map((x) => SeenNotificationElement.fromJson(x))),
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
            : List<dynamic>.from(seenNotifications!.map((x) => x.toJson())),
        "__v": v,
      };
}

class SeenNotificationElement {
  String? type;
  String? message;
  SeenData? data;

  SeenNotificationElement({
    this.type,
    this.message,
    this.data,
  });

  factory SeenNotificationElement.fromJson(Map<String, dynamic> json) =>
      SeenNotificationElement(
        type: json["type"],
        message: json["message"],
        data: json["data"] == null ? null : SeenData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "data": data?.toJson(),
      };
}

class SeenData {
  String? doctorId;
  String? name;
  String? onClickPath;

  SeenData({
    this.doctorId,
    this.name,
    this.onClickPath,
  });

  factory SeenData.fromJson(Map<String, dynamic> json) => SeenData(
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
