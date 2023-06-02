import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/status.dart';
import '../model/data_source/remote/profile.dart';

final userProfileProvider =
    ChangeNotifierProvider((ref) => UserProfileProvider());

class UserProfileProvider with ChangeNotifier {
  Future<LoginStatus> userLogin(
      String email, String password, String fcmToken) async {
    return await loginService(email, password);
  }
}
