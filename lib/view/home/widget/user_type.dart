import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/core/theme/style.dart';
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
    return ref.watch(homeVM).type == Constants.doctor
        ? DoctorWidget()
        : PatientWidget();
  }
}
