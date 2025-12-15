import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:async';

class YouTubeEmbed extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;

  const YouTubeEmbed({
    super.key, 
    required this.videoUrl,
    this.autoPlay = false,
  });

  @override
  State<YouTubeEmbed> createState() => _YouTubeEmbedState();
}

class _YouTubeEmbedState extends State<YouTubeEmbed> {
  late YoutubePlayerController _controller;
  bool _showOverlay = true;
  Timer? _hoverTimer;

  @override
  void initState() {
    super.initState();
    
    // 1. Get the ID (e.g., "abc12345" from "youtube.com/watch?v=abc12345")
    final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '';

    // 2. Setup the Controller
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: widget.autoPlay,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        loop: true,
        color: 'white',
        strictRelatedVideos: true, 
        mute: false,
        showVideoAnnotations: false,
      ),
    );
  }

  @override
  void dispose() {
    _hoverTimer?.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: MouseRegion(
        onEnter: (_) {
          // Start timer to hide overlay after hovering for 500ms
          _hoverTimer?.cancel();
          _hoverTimer = Timer(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() => _showOverlay = false);
            }
          });
        },
        onExit: (_) {
          // Cancel timer and show overlay when mouse leaves
          _hoverTimer?.cancel();
          if (mounted) {
            setState(() => _showOverlay = true);
          }
        },
        child: Stack(
          children: [
            YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
            // Overlay that blocks iframe interaction (allows scrolling)
            if (_showOverlay)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.01), // Nearly transparent
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Hover to interact',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}