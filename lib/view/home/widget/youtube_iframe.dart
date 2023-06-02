import 'package:capstone/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerDemo extends StatefulWidget {
  YoutubePlayerDemo({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _YoutubePlayerDemoState createState() => _YoutubePlayerDemoState();
}

class _YoutubePlayerDemoState extends State<YoutubePlayerDemo> {
  YoutubePlayerController? _controller;
  var yt = YoutubeExplode();

  List<String> videosList = [
    "y77E0nNvnSk",
    "JMnO9q6wR6E",
    "y77E0nNvnSk",
    "JMnO9q6wR6E",
    "y77E0nNvnSk",
    "JMnO9q6wR6E",
    "GMfn3vcCU1g",
    "moicxyiCryo",
    "112mmPUhjxo",
    "4OUcE63ie00",
    "39KcqXQU-Ss",
    "SX2XpF3_kvY",
    "cR4q1eANK10",
    "fCL2wl3G2EY",
    "ui1tMMCzb5Q",
    "6epxCm-WPYk",
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller = YoutubePlayerController(
          params: const YoutubePlayerParams(
            showControls: true,
            mute: false,
            showFullscreenButton: true,
            loop: false,
          ),
        );

        _controller?.setFullScreenListener(
          (isFullScreen) {
            debugPrint('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
          },
        );

        _controller?.loadPlaylist(
          list: videosList,
          listType: ListType.playlist,
          startSeconds: 136,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _controller != null
                  ? YoutubePlayer(controller: _controller!)
                  : const Center(child: CircularProgressIndicator()),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: videosList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _controller?.loadVideoById(videoId: videosList[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // padding: const EdgeInsets.all(5),
                        // margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: FutureBuilder(
                            future: yt.videos.get(videosList[index]),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Image.network(snapshot
                                        .data?.thumbnails.highResUrl ??
                                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fyoutube&psig=AOvVaw2rXePw5-rpeXgVf2q9grwH&ust=1679571342019000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCIi_i_u47_0CFQAAAAAdAAAAABAE");
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
