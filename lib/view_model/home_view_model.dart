
import 'package:capstone/core/utils/cache_helper.dart';
import 'package:capstone/model/model/home_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/constants.dart';
import '../model/data_source/remote/profile.dart';

final homeVM = ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel());

class HomeViewModel with ChangeNotifier {
  List<Doctort> doctor = [];
  List<Patients> patient = [];
  String type = Constants.doctor;

  void getHomeData() async {
    final List<Doctort> doctor = await getHomeDataService();
    final userType = CacheHelper.getPrefs(key: Constants.userData);
    final userId = CacheHelper.getPrefs(key: Constants.id);
    if (userType != Constants.doctor) {
      type = Constants.patient;

    }
    doctor.map((doctor1) {
      if (doctor1.id== userId) {
        patient = doctor1.patients??[];
        print('${doctor1.patients }');
      }
    }
    ).toList();
    notifyListeners();
  }
}
