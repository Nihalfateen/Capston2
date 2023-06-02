import 'package:capstone/view/home/chat_page.dart';
import 'package:capstone/view/home/widget/chatter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends ConsumerStatefulWidget {
  static const String route = 'chat_view';
  const Chat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChatterScreen(),
      ),
    );
  }
}
