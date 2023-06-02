import 'package:capstone/core/utils/cache_helper.dart';
import 'package:capstone/model/model/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/constants.dart';
import '../core/utils/log.dart';
import '../model/data_source/remote/profile.dart';
import '../model/model/auterization.dart';

final homeVM = ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel());

class HomeViewModel with ChangeNotifier {
  List<Doctort> doctor = [];
  List<Patients> patient = [];
  DoctorPatient? doctorPatient;
  String type = Constants.doctor;

  void getHomeData() async {
    List<Doctort> doctor = await getHomeDataService();
    final String userType = CacheHelper.getPrefs(key: Constants.type);
    final userId = CacheHelper.getPrefs(key: Constants.id);

    final userData = CacheHelper.getPrefs(key: Constants.userData);
    if (userType.toLowerCase() != Constants.doctor.toLowerCase()) {
      type = Constants.patient;
      doctorPatient = autherizationFromMap(userData).data?.doctor;
      notifyListeners();
    }

    doctor.map((doctor1) {
      if (doctor1.id == userId) {
        patient = doctor1.patients ?? [];
        Log.d('${doctor1.patients?.length}');
      }
    }).toList();
    notifyListeners();
  }
}
