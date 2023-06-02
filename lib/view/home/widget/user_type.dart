import 'package:capstone/core/utils/log.dart';
import 'package:capstone/view/home/widget/doctor.dart';
import 'package:capstone/view/home/widget/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../view_model/home_view_model.dart';

class UserType extends ConsumerStatefulWidget {
  const UserType({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserTypeState();
}

class _UserTypeState extends ConsumerState<UserType> {
  @override
  Widget build(BuildContext context) {
    Log.w('UserType build ${ref.watch(homeVM).type}');
    return ref.watch(homeVM).type.toLowerCase() == Constants.doctor.toLowerCase()
        ? DoctorWidget()
        : PatientWidget();
  }
}
