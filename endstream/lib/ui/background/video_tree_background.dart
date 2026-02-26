import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Full-screen looping video background for the splash screen.
///
/// Falls back to a solid black background if [reduceMotion] is true
/// or the video fails to load.
class VideoTreeBackground extends StatefulWidget {
  const VideoTreeBackground({
    super.key,
    this.reduceMotion = false,
  });

  final bool reduceMotion;

  @override
  State<VideoTreeBackground> createState() => _VideoTreeBackgroundState();
}

class _VideoTreeBackgroundState extends State<VideoTreeBackground> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    if (!widget.reduceMotion) {
      _initVideo();
    }
  }

  Future<void> _initVideo() async {
    // Wait for the platform plugin channels to fully register.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final controller = VideoPlayerController.asset(
      'assets/video/tree_animation.mp4',
    );
    _controller = controller;

    // Listen for value changes (size becomes available after first decode).
    controller.addListener(_onControllerUpdate);

    try {
      await controller.initialize();
      if (!mounted) return;
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
    } catch (e) {
      debugPrint('VideoTreeBackground: failed to initialize video: $e');
      if (mounted) setState(() => _hasError = true);
    }
  }

  void _onControllerUpdate() {
    if (!mounted) return;
    final ctrl = _controller;
    if (ctrl == null) return;

    // Mark ready once we have a valid non-zero video size.
    final size = ctrl.value.size;
    final ready = ctrl.value.isInitialized && size.width > 0 && size.height > 0;
    if (ready != _isReady) {
      setState(() => _isReady = ready);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reduceMotion || _hasError || !_isReady) {
      return const _VideoFallback();
    }

    return _VideoFillView(controller: _controller!);
  }
}

class _VideoFillView extends StatelessWidget {
  const _VideoFillView({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final videoWidth = controller.value.size.width;
    final videoHeight = controller.value.size.height;

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: videoWidth,
          height: videoHeight,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}

class _VideoFallback extends StatelessWidget {
  const _VideoFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF0A0C10),
      child: SizedBox.expand(),
    );
  }
}
