import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/home_view_model.dart';
import '../../chat/chat_view.dart';
import '../../video/call_screen.dart';

class PatientWidget extends ConsumerStatefulWidget {
  String? name;
  PatientWidget({super.key, this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientWidgetState();
}

class _PatientWidgetState extends ConsumerState<PatientWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => ref.read(homeVM).getHomeData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 8,
        shadowColor: primaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              trailing: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: "",
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(ref.watch(homeVM).doctorPatient?.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.pushNamed(context, Chat.route);
                    },
                    label: Text('Chat'),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.video_call),
                    onPressed: () {
                      Navigator.pushNamed(context, CallScreen.route);
                    },
                    label: Text('video'),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
