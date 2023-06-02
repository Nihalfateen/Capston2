import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/home_view_model.dart';
import '../../video/video_view.dart';

class DoctorWidget extends ConsumerStatefulWidget {
  const DoctorWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorWidgetState();
}

class _DoctorWidgetState extends ConsumerState<DoctorWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => ref.read(homeVM).getHomeData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ref.watch(homeVM).doctor.length,
      itemBuilder: (context, index) {
        final item = ref.watch(homeVM).doctor[index];
        return Card(
          elevation: 4,
          shadowColor: primaryColor,
          child: Column(
            children: [
              ListTile(
                trailing: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: item.image ?? "",
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                title: Text(item.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                subtitle: Text(
                  item.email ?? "",
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.chat),
                      onPressed: () {},
                      label: Text('Chat'),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.video_call),
                      onPressed: () {
                        Navigator.pushNamed(context, VideoView.route);
                      },
                      label: Text('video'),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
