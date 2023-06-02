import 'package:capstone/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatView extends ConsumerStatefulWidget {
  static const String route = 'chat';
  const ChatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  late final WebViewController controller;
  bool isLoading = true;
  String url =
      'http://esptailachat-001-site1.etempurl.com/damp-credit-2/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGFtcC1jcmVkaXQtMiJ9.WBTiPEp6DFhxkFw63LaDfbEnaewv4dF7x9I7WxFpumM';
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            launch(url);
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'http://esptailachat-001-site1.etempurl.com/damp-credit-2/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGFtcC1jcmVkaXQtMiJ9.WBTiPEp6DFhxkFw63LaDfbEnaewv4dF7x9I7WxFpumM')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            'http://esptailachat-001-site1.etempurl.com/damp-credit-2/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGFtcC1jcmVkaXQtMiJ9.WBTiPEp6DFhxkFw63LaDfbEnaewv4dF7x9I7WxFpumM'),
      );
  }

  @override
  Widget build(BuildContext context) {
    // final size
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.black,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
    );
  }
}
