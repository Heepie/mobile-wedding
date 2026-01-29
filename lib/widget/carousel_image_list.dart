import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/widget/single_image.dart';

/// Widget for displaying a carousel of media items
class CarouselImageList extends StatefulWidget {
  final List<MediaContent> mediaList;
  final void Function(int index)? onItemTap;

  const CarouselImageList({super.key, required this.mediaList, this.onItemTap});

  @override
  State<CarouselImageList> createState() => _CarouselImageListState();
}

class _CarouselImageListState extends State<CarouselImageList> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CarouselSlider(
              carouselController: _controller,
              items:
                  widget.mediaList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final mediaContent = entry.value;
                    return _buildCarouselItem(context, index, mediaContent);
                  }).toList(),
              options: CarouselOptions(
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                autoPlay: false,
                scrollDirection: Axis.horizontal,
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text("↑사진 클릭↑"),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(
    BuildContext context,
    int index,
    MediaContent mediaContent,
  ) {
    final String path;
    final bool isVideoThumbnail;

    if (mediaContent is VideoContent) {
      path = mediaContent.thumbnailPath;
      isVideoThumbnail = true;
    } else {
      path = mediaContent.path;
      isVideoThumbnail = false;
    }

    return GestureDetector(
      onTap: () => widget.onItemTap?.call(index),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: SingleImage(
          path: path,
          isRemote: mediaContent is! LocalImageContent,
          isWidthBigger: mediaContent.isWidthBigger,
          alignment: mediaContent.alignment,
          isVideoThumbnail: isVideoThumbnail,
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
          onPressed: () => _controller.previousPage(),
        ),
        _buildNavButton(
          icon: Icons.arrow_right,
          onPressed: () => _controller.nextPage(),
        ),
      ],
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white60,
        ),
        child: IconButton(
          iconSize: 36,
          color: Colors.black,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
