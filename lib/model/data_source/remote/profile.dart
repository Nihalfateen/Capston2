import 'dart:convert';
import 'dart:io';

import 'package:capstone/model/model/auterization.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/constants.dart';
import '../../../core/constants/status.dart';
import '../../../core/utils/cache_helper.dart';
import '../../../core/utils/log.dart';
import '../../model/home_data.dart';

Future<LoginStatus> loginService(String phone, String password) async {
  try {
    final http.Response response = await http.post(
      Uri.parse("${Constants.apiPath}login"),
      body: json.encode({
        "phone": phone,
        "password": password,
        // "dev_type?": "android|ios",
        // "dev_type": "ios",
        // "dev_token": "ssssssss"
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Api-Lang': 'ar'},
    );

    if (response.statusCode == 200) {
      final data = autherizationFromMap(response.body);
      if (data.status == 1) {
        Log.w(response.body);
        CacheHelper.savePrefs(
            key: Constants.tokenPrefKey, value: data.data?.apiToken.toString() ?? "");
        CacheHelper.savePrefs(
          key: Constants.type,
          value: autherizationFromMap(response.body).data?.type?.toLowerCase() ?? Constants.doctor,
        );
        CacheHelper.savePrefs(key: Constants.userData, value: response.body);
        CacheHelper.savePrefs(
            key: Constants.id, value: autherizationFromMap(response.body).data?.id);
        CacheHelper.savePrefs(
            key: Constants.patientName, value: autherizationFromMap(response.body).data?.name);

        return LoginStatus.success;
      } else {
        return LoginStatus.failed;
      }
    } else {
      return LoginStatus.failed;
    }
  } catch (e) {
    Log.e(e.toString());
    return LoginStatus.failed;
  }
}

Future<LoginStatus> registerService(
  String userType,
  String name,
  String email,
  String phone,
  String specialization,
  String password,
) async {
  try {
    final http.Response response = await http.post(
      Uri.parse("${Constants.apiPath}register"),
      body: json.encode({
        "user_type?": "patient|doctor",
        "user_type": userType,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": password,
        "image": "",
        "syndicate_card_image": "",
        "specialization": specialization,
        "description": ""
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Api-Lang': 'ar'},
    );
    Log.w(response.statusCode.toString());
    Log.w(response.body.toString());
    if (response.statusCode == 200) {
      return LoginStatus.success;
    } else {
      return LoginStatus.failed;
    }
  } catch (e) {
    Log.e(e.toString());
    return LoginStatus.failed;
  }
}

Future<List<Doctort>> getHomeDataService() async {
  try {
    final response = await http.get(Uri.parse('${Constants.apiPath}homeapp'));

    if (response.statusCode == HttpStatus.ok) {
      return mainDataFromJson(response.body).data ?? [];
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}
