import 'package:flutter/foundation.dart';

@immutable
class Constants {
  const Constants._();
  static const String apiPath = 'http://amrsadoma-001-site1.dtempurl.com/api/';
  static const String fcmTokenPrefKey = "FCM_TOKEN";
  static const String tokenPrefKey = "TOKEN";
  static const String roleIdPrefKey = "ROLE_ID";
  static const String localePrefKey = "LOCALE";
  static const String isLoggedPrefKey = "LOGGED";
  static const String userData = "USER_DATA";
  static const String doctor = "Doctor";
  static const String type = "TYPE";
  static const String patient = "Patient";
  static const String id = "ID";
  static const String patientName = "pName";

  static const String mobileFiles = "MOBILE_FILES";
  static const String mobileNotification = "MOBILE_NOTIFICATION";
}

enum AccountStatus { autherized, pending, unautherized }
