// To parse this JSON data, do
//
//     final autherization = autherizationFromMap(jsonString);

import 'dart:convert';

Autherization autherizationFromMap(String str) =>
    Autherization.fromJson(json.decode(str));

String autherizationToMap(Autherization data) => json.encode(data.toJson());

class Autherization {
  int? status;
  String? message;
  Data? data;

  Autherization({this.status, this.message, this.data});

  Autherization.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  late int id;
  String? name;
  String? email;
  String? phone;
  bool? isAccept;
  String? type;
  String? apiToken;
  String? image;
  String? createdAt;

  Data(
      {required this.id,
      this.name,
      this.email,
      this.phone,
      this.isAccept,
      this.type,
      this.apiToken,
      this.image,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isAccept = json['is_accept'];
    type = json['type'];
    apiToken = json['api_token'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['is_accept'] = isAccept;
    data['type'] = type;
    data['api_token'] = apiToken;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
