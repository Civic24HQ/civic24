import 'package:components/src/app_cards/app_cached_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays a preview of report media (images/videos) in a grid layout.
/// Supports up to 4 media items with an overlay for additional items.
///
/// [media]: List of media URLs to display.
/// [height]: Height of the preview widget.
/// [borderRadius]: Border radius for the media tiles.
/// [heroTagPrefix]: A unique prefix for Hero animations to avoid collisions.
/// [onOpenGallery]: Optional callback to handle gallery opening logic. If null, the default fullscreen viewer is used.
class AppReportMediaPreview extends StatelessWidget {
  const AppReportMediaPreview({
    required this.media,
    required this.height,
    required this.borderRadius,
    required this.heroTagPrefix,
    super.key,
    this.onOpenGallery,
  });

  final List<String> media;
  final double height;
  final BorderRadius borderRadius;
  final String heroTagPrefix;
  final void Function(BuildContext context, int initialIndex)? onOpenGallery;

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ClipRRect(borderRadius: borderRadius, child: _buildLayout(context)),
    );
  }

  Widget _buildLayout(BuildContext context) {
    final count = media.length;

    if (count == 1) return _tile(context, index: 0);

    if (count == 2) {
      return Row(
        children: [
          Expanded(child: _tile(context, index: 0, rightGap: 2)),
          Expanded(child: _tile(context, index: 1)),
        ],
      );
    }

    if (count == 3) {
      return Row(
        children: [
          Expanded(flex: 2, child: _tile(context, index: 0, rightGap: 2)),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _tile(context, index: 1, bottomGap: 2)),
                Expanded(child: _tile(context, index: 2)),
              ],
            ),
          ),
        ],
      );
    }

    final extraCount = count - 4;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: _tile(context, index: 0, rightGap: 2, bottomGap: 2)),
              Expanded(child: _tile(context, index: 1, bottomGap: 2)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _tile(context, index: 2, rightGap: 2)),
              Expanded(child: _tile(context, index: 3, overlayText: extraCount > 0 ? '+$extraCount' : null)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required int index,
    double rightGap = 0,
    double bottomGap = 0,
    String? overlayText,
  }) {
    final url = media[index];

    return Padding(
      padding: EdgeInsets.only(right: rightGap, bottom: bottomGap),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final open = onOpenGallery ?? _openDefaultGallery;
            open(context, index);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: _heroTag(index),
                child: AppCachedImage(imageUrl: url),
              ),
              if (overlayText != null) _OverlayCountLabel(text: overlayText),
            ],
          ),
        ),
      ),
    );
  }

  String _heroTag(int index) => '$heroTagPrefix-media-$index';

  void _openDefaultGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReportGalleryViewer(media: media, initialIndex: initialIndex, heroTagPrefix: heroTagPrefix),
      ),
    );
  }
}

class _OverlayCountLabel extends StatelessWidget {
  const _OverlayCountLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// A fullscreen viewer for report media that supports swiping between images/videos.
/// [media]: List of media URLs to display.
/// [initialIndex]: The index of the media item to display first.
/// [heroTagPrefix]: A unique prefix for Hero animations to avoid collisions.
class ReportGalleryViewer extends StatefulWidget {
  const ReportGalleryViewer({required this.media, required this.initialIndex, required this.heroTagPrefix, super.key});
  final List<String> media;
  final int initialIndex;
  final String heroTagPrefix;

  @override
  State<ReportGalleryViewer> createState() => _ReportGalleryViewerState();
}

class _ReportGalleryViewerState extends State<ReportGalleryViewer> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    final safeInitialIndex = widget.initialIndex.clamp(0, widget.media.length - 1);
    _currentIndex = safeInitialIndex;

    _controller = PageController(initialPage: safeInitialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _heroTag(int index) => '${widget.heroTagPrefix}-media-$index';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.media.length,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, index) {
                final url = widget.media[index];

                return Center(
                  child: Hero(
                    tag: _heroTag(index),
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: SizedBox.expand(
                        child: FittedBox(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height,
                            child: AppCachedImage(imageUrl: url),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    '${_currentIndex + 1}/${widget.media.length}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
