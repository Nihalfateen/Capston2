import 'package:capstone/core/constants/constants.dart';
import 'package:capstone/core/theme/style.dart';
import 'package:capstone/core/utils/cache_helper.dart';
import 'package:capstone/view/home/widget/chatter_screen.dart';
import 'package:capstone/view/home/widget/hospital.dart';
import 'package:capstone/view/home/widget/user_type.dart';
import 'package:capstone/view/home/widget/youtube_iframe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/localization/localization.dart';
import '../../model/model/auterization.dart';
import '../../view_model/home_view_model.dart';
import '../login_view.dart';
import 'chat_page.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String route = "home";
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        ref.read(homeVM);
      }
    });
  }
  final patientName = CacheHelper.getPrefs(key: Constants.patientName);
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = [
    UserType(),
    ChatterScreen(),
    YoutubePlayerDemo(title: "video"),
    HospitalWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
            autherizationFromMap(CacheHelper.getPrefs(key: Constants.userData)).data?.name ?? ""),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            CacheHelper.clearAll();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.route,
              (route) => false,
            );
          },
        ),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: getString(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: getString(context).chat,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.video_call),
            label: getString(context).video,
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.youtube),
            label: getString(context).hospital,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
        selectedItemColor: whiteColor,
        backgroundColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
