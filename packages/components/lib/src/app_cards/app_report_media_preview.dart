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
                      child: SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width,
                              maxHeight: MediaQuery.sizeOf(context).height,
                            ),
                            child: AppCachedImage(imageUrl: url),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Premium top overlay (gradient + controls)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withValues(alpha: 0.65), Colors.transparent],
                  ),
                ),
                child: Row(
                  children: [
                    _CircularOverlayIconButton(icon: Icons.close, onTap: () => Navigator.of(context).pop()),
                    const Spacer(),
                    _GalleryCounterPill(currentIndex: _currentIndex + 1, total: widget.media.length),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularOverlayIconButton extends StatelessWidget {
  const _CircularOverlayIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.14),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Center(child: Icon(Icons.close, color: Colors.white, size: 22)),
        ),
      ),
    );
  }
}

class _GalleryCounterPill extends StatelessWidget {
  const _GalleryCounterPill({required this.currentIndex, required this.total});

  final int currentIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Text(
        '$currentIndex / $total',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}
