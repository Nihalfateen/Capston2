// ignore_for_file: super_goes_last
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/log.dart';
import '../../core/utils/cache_helper.dart';
import '../../core/constants/constants.dart';
import '../core/theme/style.dart';
import 'package:flutter/material.dart';

import 'home/home_view.dart';
import 'login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  static const String route = "splash";
  const SplashView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  bool policy = false;
  Timer? timer;
  final String isLogged =
      CacheHelper.getPrefs(key: Constants.tokenPrefKey) ?? "";

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        isLogged.isNotEmpty ? HomeView.route : LoginScreen.route,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/background.jpg",
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  curve: Curves.ease,
                  duration: const Duration(seconds: 3),
                  builder:
                      (BuildContext context, double opacity, Widget? child) {
                    return Opacity(
                        opacity: opacity,
                        child: Container(
                          height: size.height / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Image.asset(
                            'assets/images/app_logo.png',
                          ),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
