import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCheck extends StatefulWidget {
  @override
  _VideoCheckState createState() => _VideoCheckState();
}

class _VideoCheckState extends State<VideoCheck> {
  VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();

    /// Need an mp4 address
    _playerController = VideoPlayerController.network(
        "http://image.tlpara.cn/dev/video/56e05a475ea14092821a6ff8df28464b.mp4")
      ..initialize().then((_) {
        setState(() {});
      });

    _playerController.addListener(() {
      print(_playerController?.value?.isPlaying);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("video player"),
      ),
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: _playerController?.value?.aspectRatio,
                      child: VideoPlayer(_playerController),
                    ),
                  ),
                  onTap: () {
                    if (_playerController.value.isPlaying) {
                      _playerController.pause();
                    } else {
                      _playerController.play();
                    }
                  },
                ),
              ],
            ),
          ),
          TextButton(
            child: Text("play"),
            onPressed: () {
              _playerController.play();
            },
          ),
          TextButton(
            child: Text("pause"),
            onPressed: () {
              _playerController.pause();
            },
          ),
          TextButton(
            child: Text("reset play"),
            onPressed: () {
              _playerController.seekTo(Duration.zero);
              _playerController.play();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }
}
