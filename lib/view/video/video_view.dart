import 'package:capstone/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoView extends ConsumerStatefulWidget {
  static const String route = 'video';
  const VideoView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoViewState();
}

class _VideoViewState extends ConsumerState<VideoView> {
  // late final WebViewController controller;
  // bool isLoading = true;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           // Update loading bar.
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         },
  //         onWebResourceError: (WebResourceError error) {},
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url
  //               .startsWith('https://ibrahimcrespo.github.io/video/')) {
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(
  //       Uri.parse('https://ibrahimcrespo.github.io/video/'),
  //     );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   // final size
  //   return Scaffold(
  //     body: isLoading
  //         ? Center(
  //             child: CircularProgressIndicator(),
  //           )
  //         : Container(
  //             color: Colors.black,
  //             child: WebViewWidget(
  //               controller: controller,
  //             ),
  //           ),
  //   );
  // }
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;

  @override
  void initState() {
    super.initState();
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    _initialize();
  }

  Future<void> _initialize() async {
    await _createPeerConnection();
    await _getUserMedia();
  }

  Future<void> _createPeerConnection() async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(configuration);
    _peerConnection.onAddStream = (stream) {
      setState(() {
        _remoteRenderer.srcObject = stream;
      });
    };
  }

  Future<void> _getUserMedia() async {
    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': true,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localStream;

    _peerConnection.addStream(_localStream);
  }

  @override
  void dispose() {
    _peerConnection.dispose();
    _localStream.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Row(
          children: [
            _buildLocalVideo(),
            _buildRemoteVideo(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalVideo() {
    return Container(
      width: 160,
      height: 120,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(180),
        child: RTCVideoView(_localRenderer),
      ),
    );
  }

  Widget _buildRemoteVideo() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: RTCVideoView(_remoteRenderer),
      ),
    );
  }
}
