import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/router/app_router.dart';
import 'package:mobile_wedding/widget/video_controller_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

/// Full-screen image/video viewer with carousel navigation
class ImageViewerScreen extends StatefulWidget {
  final ImageViewerParams? params;

  const ImageViewerScreen({super.key, this.params});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late ImageViewerParams _params;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final Map<VideoContent, VideoPlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    // Hide system UI for full-screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _params =
        widget.params ??
        const ImageViewerParams(
          initialIndex: 0,
          mediaList: [],
          enableInfiniteScroll: true,
        );

    // Initialize video controllers for all video content
    for (final media in _params.mediaList) {
      if (media is VideoContent) {
        _videoControllers[media] = VideoPlayerController.networkUrl(
          Uri.parse(media.path),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose all video controllers
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }

    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_params.mediaList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pop();
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildCarousel(),
              _buildCloseButton(),
              if (_params.mediaList.length > 1) _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return PhotoViewGestureDetectorScope(
      axis: Axis.horizontal,
      child: CarouselSlider(
        carouselController: _carouselController,
        items:
            _params.mediaList.map((media) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _buildMediaWidget(media),
              );
            }).toList(),
        options: CarouselOptions(
          aspectRatio: 9 / 16,
          initialPage: _params.initialIndex,
          viewportFraction: 1.0,
          enableInfiniteScroll: _params.enableInfiniteScroll,
          onPageChanged: _onPageChanged,
        ),
      ),
    );
  }

  void _onPageChanged(int page, CarouselPageChangedReason reason) {
    // Pause and reset adjacent video players
    _pauseAndResetVideo(_getAdjacentIndex(page, 1));
    _pauseAndResetVideo(_getAdjacentIndex(page, -1));
  }

  int _getAdjacentIndex(int currentPage, int offset) {
    final length = _params.mediaList.length;
    return (currentPage + offset + length) % length;
  }

  void _pauseAndResetVideo(int index) {
    final media = _params.mediaList[index];
    if (media is VideoContent) {
      final controller = _videoControllers[media];
      controller?.pause();
      controller?.seekTo(Duration.zero);
    }
  }

  Widget _buildMediaWidget(MediaContent media) {
    return switch (media) {
      VideoContent() => _buildVideoPlayer(media),
      RemoteImageContent() => _buildPhotoView(
        imageProvider:
            Image.network(
              media.path,
              fit: media.isWidthBigger ? BoxFit.fitWidth : BoxFit.fitHeight,
            ).image,
      ),
      LocalImageContent() => _buildPhotoView(
        imageProvider:
            Image.asset(
              media.path,
              fit: media.isWidthBigger ? BoxFit.fitWidth : BoxFit.fitHeight,
            ).image,
      ),
    };
  }

  Widget _buildPhotoView({required ImageProvider imageProvider}) {
    return PhotoView(
      imageProvider: imageProvider,
      minScale: PhotoViewComputedScale.contained * 1.0,
      maxScale: PhotoViewComputedScale.contained * 2.5,
      initialScale: PhotoViewComputedScale.contained,
      filterQuality: FilterQuality.low,
      strictScale: true,
    );
  }

  Widget _buildVideoPlayer(VideoContent video) {
    final controller = _videoControllers[video]!;

    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),
                VideoControllerWidget(
                  thumbnailPath: video.thumbnailPath,
                  videoPlayerController: controller,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white24,
          ),
          child: IconButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNavButton(
          icon: Icons.arrow_left,
          onPressed: () => _carouselController.previousPage(),
        ),
        _buildNavButton(
          icon: Icons.arrow_right,
          onPressed: () => _carouselController.nextPage(),
        ),
      ],
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white60,
        ),
        child: IconButton(
          iconSize: 40,
          color: Colors.black,
          onPressed: onPressed,
          icon: Icon(icon, size: 32),
        ),
      ),
    );
  }
}
