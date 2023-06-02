import 'package:capstone/core/constants/status.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../core/constants/constants.dart';
import '../model/data_source/remote/profile.dart';

final registerVM = ChangeNotifierProvider((ref) {
  return RegisterViewModel();
});

class RegisterViewModel with ChangeNotifier {
  Future<LoginStatus?> register(
    String userType,
    String name,
    String email,
    String phone,
    String specialization,
    String password,
  ) async {
    final accountStatus = await registerService(
      userType,
      name,
      email,
      phone,
      specialization,
      password,
    );
    return accountStatus;
  }
}
