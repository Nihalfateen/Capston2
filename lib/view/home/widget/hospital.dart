import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalWidget extends ConsumerStatefulWidget {
  const HospitalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HospitalWidgetState();
}

class _HospitalWidgetState extends ConsumerState<HospitalWidget> {
  @override
  void initState() {
    _launchUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: _launchUrl,
          child: const Text("Espitalia"),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
        Uri.parse("https://www.youtube.com/@espitalia-sj1vt/videos"))) {
      throw Exception('Could not launch ');
    }
  }
}
