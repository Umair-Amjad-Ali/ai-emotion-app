import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final double height;
  final double width;
  final String videoPath;
  final bool isLooping;
  final Function(VideoPlayerController)? onControllerReady;

  // Parameters for manual adjustment
  final double zoom;
  final Offset offset;
  final Color backgroundColor;

  // New parameter for fade effect
  final bool enableFade;

  const CustomVideoPlayer({
    required this.height,
    required this.width,
    required this.videoPath,
    this.isLooping = true,
    this.onControllerReady,
    this.zoom = 1.0,
    this.offset = Offset.zero,
    this.backgroundColor = Colors.black,
    this.enableFade = false, // Disabled by default
    super.key,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start invisible if fade is enabled
    _opacity = widget.enableFade ? 0.0 : 1.0;
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          _controller.setLooping(widget.isLooping);
          _controller.play();

          if (widget.enableFade) {
            _controller.addListener(_fadeListener);
          }

          widget.onControllerReady?.call(_controller);
          setState(() {});
        }
      });
  }

  void _fadeListener() {
    if (!mounted) return;

    final duration = _controller.value.duration.inMilliseconds;
    final position = _controller.value.position.inMilliseconds;
    const fadeDuration = 500; // 0.5 seconds fade

    double newOpacity = 1.0;

    // Fade In at start
    if (position < fadeDuration) {
      newOpacity = position / fadeDuration;
    }
    // Fade Out at end (only relevant if looping is off or near end)
    else if (position > (duration - fadeDuration)) {
      newOpacity = (duration - position) / fadeDuration;
    }

    if ((newOpacity - _opacity).abs() > 0.01) {
      setState(() {
        _opacity = newOpacity.clamp(0.0, 1.0);
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.play();
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.removeListener(_fadeListener);
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      color: widget.backgroundColor,
      child: _controller.value.isInitialized
          ? AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _opacity,
              child: Center(
                child: Transform.translate(
                  offset: widget.offset,
                  child: Transform.scale(
                    scale: widget.zoom,
                    child: ClipRect(
                      child: SizedBox(
                        width: widget.width,
                        height: widget.height,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.expand(),
    );
  }
}
