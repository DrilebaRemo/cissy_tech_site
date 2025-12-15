import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SimpleVideoPlayer extends StatefulWidget {
  final String assetPath;
  final bool autoPlay;

  const SimpleVideoPlayer({
    super.key, 
    required this.assetPath,
    this.autoPlay = true,
  });

  @override
  State<SimpleVideoPlayer> createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    if (widget.assetPath.startsWith('http')) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.assetPath));
    } else {
      _controller = VideoPlayerController.asset(widget.assetPath);
    }
    _controller
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        debugPrint("Video Error: $error");
        setState(() => _isError = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 40),
            SizedBox(height: 8),
            Text("Video Error", style: TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return VisibilityDetector(
      key: Key(widget.assetPath),
      onVisibilityChanged: (info) {
        if (widget.autoPlay && 
            info.visibleFraction > 0.6 && 
            !_controller.value.isPlaying && 
            _controller.value.isInitialized) {
           _controller.play();
           setState(() {}); 
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          // Play/Pause Overlay
          GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Container(
               color: _controller.value.isPlaying ? Colors.transparent : Colors.black.withOpacity(0.4),
               child: Center(
                 child: _controller.value.isPlaying 
                   ? const SizedBox.shrink()
                   : const Icon(
                       Icons.play_circle,
                       color: Colors.white,
                       size: 64,
                     ),
               ),
            ),
          ),
        ],
      ),
    );
  }
}
