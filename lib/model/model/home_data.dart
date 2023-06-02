// To parse this JSON data, do
//
//     final mainData = mainDataFromJson(jsonString);

import 'dart:convert';

MainData mainDataFromJson(String str) => MainData.fromJson(json.decode(str));

String mainDataToJson(MainData data) => json.encode(data.toJson());

class MainData {
  int? status;
  String? message;
  List<Doctort>? data;

  MainData({this.status, this.message, this.data});

  MainData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Doctort>[];
      json['data'].forEach((v) {
        data!.add(Doctort.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctort {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? apiToken;
  String? image;
  String? syndicateCardImage;
  String? specialization;
  String? description;
  List<Patients>? patients;
  String? createdAt;

  Doctort(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.apiToken,
      this.image,
      this.syndicateCardImage,
      this.specialization,
      this.description,
      this.patients,
      this.createdAt});

  Doctort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    apiToken = json['api_token'];
    image = json['image'];
    syndicateCardImage = json['syndicate_card_image'];
    specialization = json['specialization'];
    description = json['description'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add( Patients.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['api_token'] = apiToken;
    data['image'] = image;
    data['syndicate_card_image'] = syndicateCardImage;
    data['specialization'] = specialization;
    data['description'] = description;
    if (patients != null) {
      data['patients'] = patients!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Patients {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? apiToken;
  String? image;
  String? syndicateCardImage;
  String? specialization;
  String? description;
  // List<Doctor>? doctor;
   Doctor? doctor;
  String? createdAt;

  Patients(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.apiToken,
      this.image,
      this.syndicateCardImage,
      this.specialization,
      this.description,
      this.doctor,
      this.createdAt});

  Patients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    apiToken = json['api_token'];
    image = json['image'];
    syndicateCardImage = json['syndicate_card_image'];
    specialization = json['specialization'];
    description = json['description'];
    doctor = json['doctor'] != null ?  Doctor.fromJson(json['doctor']) : null;
    // if (json['doctor'] != null) {
    //   doctor = <Doctor>[];
    //   json['doctor'].forEach((v) {
    //     doctor!.add( Doctor.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['api_token'] = apiToken;
    data['image'] = image;
    data['syndicate_card_image'] = syndicateCardImage;
    data['specialization'] = specialization;
    data['description'] = description;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    // if (doctor != null) {
    //   data['patients'] = doctor.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = createdAt;
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? phone;
  String? createdAt;

  Doctor({this.id, this.name, this.phone, this.createdAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    return data;
  }
}
