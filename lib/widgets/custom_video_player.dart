import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final double height;
  final double width;
  final String videoPath;
  final bool isLooping;
  final Function(VideoPlayerController)? onControllerReady;

  const CustomVideoPlayer({
    required this.height,
    required this.width,
    required this.videoPath,
    this.isLooping = true,
    this.onControllerReady,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          _controller.setLooping(widget.isLooping);
          _controller.play();
          // Expose controller to parent widget
          widget.onControllerReady?.call(_controller);
          print("🎥 Video controller initialized and exposed");
          setState(() {});
        }
      });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("🎥 VIDEO PAUSED - App backgrounded");
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      print("🎥 VIDEO RESUMED - App foregrounded");
      _controller.play();
    }
  }

  @override
  void deactivate() {
    print("🎥 VIDEO DEACTIVATE - Stopping playback");
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    print("🎥 VIDEO DISPOSED");
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : Container(color: Colors.black),
    );
  }
}