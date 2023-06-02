import 'package:capstone/view/home/chat_page.dart';
import 'package:capstone/view/home/widget/chatter_screen.dart';
import 'package:capstone/view/splash.dart';
import 'package:flutter/material.dart';

import '../../view/chat/chat_view.dart';
import '../../view/home/home_view.dart';
import '../../view/login_view.dart';
import '../../view/video/call_screen.dart';
import '../../view/video/video_view.dart';

Map<String, Widget Function(BuildContext)> appRoutes(context) {
  return {
    LoginScreen.route: (_) => LoginScreen(),
    HomeView.route: (_) => HomeView(),
    SplashView.route: (_) => SplashView(),
    ChatView.route: (_) => ChatView(),
    VideoView.route: (_) => VideoView(),
    CallScreen.route: (_) => CallScreen(),
    ChatterScreen.route: (_) => ChatterScreen(),
  };
}
