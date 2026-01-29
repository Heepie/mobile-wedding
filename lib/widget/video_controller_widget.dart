import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wedding/widget/single_image.dart';
import 'package:video_player/video_player.dart';

/// Widget for controlling video playback with play/pause, seek, and volume
class VideoControllerWidget extends StatefulWidget {
  final String thumbnailPath;
  final VideoPlayerController videoPlayerController;

  const VideoControllerWidget({
    super.key,
    required this.thumbnailPath,
    required this.videoPlayerController,
  });

  @override
  State<VideoControllerWidget> createState() => _VideoControllerWidgetState();
}

class _VideoControllerWidgetState extends State<VideoControllerWidget> {
  late VideoPlayerValue _videoPlayerValue;
  bool _isControlsVisible = true;
  bool _isFirstPlay = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerValue = widget.videoPlayerController.value;
    widget.videoPlayerController.addListener(_onVideoPlayerChanged);
  }

  void _onVideoPlayerChanged() {
    if (mounted) {
      setState(() {
        _videoPlayerValue = widget.videoPlayerController.value;
      });
    }
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(_onVideoPlayerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isControlsVisible
        ? _buildVisibleControls()
        : _buildHiddenControls();
  }

  Widget _buildVisibleControls() {
    return InkWell(
      onTap: _toggleControlsVisibility,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isFirstPlay) _buildThumbnailOverlay(),
          _buildPlayPauseButton(),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildHiddenControls() {
    return GestureDetector(
      onTap: _toggleControlsVisibility,
      child: Container(color: Colors.transparent),
    );
  }

  Widget _buildThumbnailOverlay() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: Colors.black),
        AspectRatio(
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          child: SingleImage(
            path: widget.thumbnailPath,
            isRemote: true,
            isWidthBigger: widget.videoPlayerController.value.aspectRatio > 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayPauseButton() {
    return IconButton(
      onPressed: _onPlayPausePressed,
      icon: Icon(
        _videoPlayerValue.isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
      ),
      iconSize: 72,
    );
  }

  Widget _buildBottomControls() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatDuration(_videoPlayerValue.position)} / ${_formatDuration(_videoPlayerValue.duration)}',
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  onPressed: _toggleVolume,
                  icon: Icon(
                    _videoPlayerValue.volume == 0
                        ? Icons.volume_off_rounded
                        : Icons.volume_up,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 16),
            child: ProgressBar(
              progress: _videoPlayerValue.position,
              buffered: Duration(milliseconds: _getMaxBuffering()),
              total: _videoPlayerValue.duration,
              timeLabelLocation: TimeLabelLocation.none,
              onSeek: (duration) {
                widget.videoPlayerController.seekTo(duration);
              },
              thumbColor: Colors.white,
              progressBarColor: Colors.white,
              bufferedBarColor: Colors.grey[700],
              baseBarColor: Colors.grey[900],
              thumbRadius: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleControlsVisibility() {
    if (!_isFirstPlay) {
      setState(() {
        _isControlsVisible = !_isControlsVisible;
      });
    }
  }

  void _onPlayPausePressed() {
    if (_videoPlayerValue.isPlaying) {
      widget.videoPlayerController.pause();
    } else {
      widget.videoPlayerController.play();
    }

    setState(() {
      _isFirstPlay = false;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  void _toggleVolume() {
    if (_videoPlayerValue.volume != 0) {
      widget.videoPlayerController.setVolume(0);
    } else {
      widget.videoPlayerController.setVolume(1);
    }
  }

  int _getMaxBuffering() {
    int maxBuffering = 0;
    for (final DurationRange range in _videoPlayerValue.buffered) {
      final int end = range.end.inMilliseconds;
      if (end > maxBuffering) {
        maxBuffering = end;
      }
    }
    return maxBuffering;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
