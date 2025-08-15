import 'dart:async';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class AppSearchableDropdownTextField<T> extends StatefulWidget {
  const AppSearchableDropdownTextField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    super.key,
    this.leading,
    this.maxMenuHeight = 300,
    this.autofocusSearch = false,
    this.fillColor,
    this.errorText,
    this.isEnabled = true,
    this.isDense = true,
  });

  final String label;
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  final Widget Function(T)? leading;

  final double maxMenuHeight;
  final bool autofocusSearch;
  final bool isDense;

  final Color? fillColor;
  final String? errorText;
  final bool isEnabled;

  @override
  State<AppSearchableDropdownTextField<T>> createState() => _AppSearchableDropdownTextFieldState<T>();
}

class _AppSearchableDropdownTextFieldState<T> extends State<AppSearchableDropdownTextField<T>> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final GlobalKey _fieldKey = GlobalKey();

  Timer? _debounce;
  OverlayEntry? _entry;
  bool _isOpen = false;

  late List<T> _filtered;
  StateSetter? _overlaySetState;

  @override
  void initState() {
    super.initState();
    _filtered = List<T>.from(widget.items);
    _searchCtrl.addListener(() {
      _overlaySetState?.call(() {});
    });
  }

  @override
  void didUpdateWidget(covariant AppSearchableDropdownTextField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filtered = _applyFilter(_searchCtrl.text);
      _overlaySetState?.call(() {});
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchCtrl.dispose();
    _searchFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  List<T> _applyFilter(String q) {
    final lower = q.toLowerCase();
    return widget.items.where((e) => widget.itemLabel(e).toLowerCase().contains(lower)).toList();
  }

  void _open() {
    if (_isOpen) return;
    _searchCtrl.clear();
    _filtered = List<T>.from(widget.items);

    _entry = _buildOverlayEntry();
    Overlay.of(context).insert(_entry!);
    setState(() => _isOpen = true);

    if (widget.autofocusSearch) {
      Future.microtask(_searchFocus.requestFocus);
    }
  }

  void _close() {
    if (!_isOpen) return;
    _removeOverlay();
    setState(() => _isOpen = false);
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
    _overlaySetState = null;
  }

  InputDecoration _fieldDecoration(BuildContext context) {
    final hasError = widget.errorText != null;
    return InputDecoration(
      labelStyle: context.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
      fillColor: widget.fillColor,
      filled: widget.fillColor != null,
      isDense: widget.isDense,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppDimensions.padding16),
      hintText: widget.hintText,
      hintStyle: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
      border: OutlineInputBorder(
        borderRadius: AppBorderRadius.radius8,
        borderSide: BorderSide(color: hasError ? context.error : context.neutralLow),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.radius8,
        borderSide: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.radius8,
        borderSide: BorderSide(color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.radius8,
        borderSide: BorderSide(color: context.primaryColor),
      ),
      errorText: widget.errorText,
      enabled: widget.isEnabled,
      suffixIcon: Icon(
        _isOpen ? SolarIconsOutline.altArrowUp : SolarIconsOutline.altArrowDown,
        color: context.neutralHigh,
        size: AppDimensions.size24,
      ),
    );
  }

  OverlayEntry _buildOverlayEntry() {
    final box = _fieldKey.currentContext!.findRenderObject()! as RenderBox;
    final fieldSize = box.size;

    return OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _close,
            child: Stack(
              children: [
                CompositedTransformFollower(
                  link: _layerLink,
                  offset: Offset(0, fieldSize.height - AppDimensions.size16),
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 2,
                    color: context.colorScheme.surface,
                    shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius8),
                    clipBehavior: Clip.antiAlias,
                    child: StatefulBuilder(
                      builder: (context, setOverlayState) {
                        _overlaySetState = setOverlayState;
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: fieldSize.width, maxHeight: widget.maxMenuHeight),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(AppDimensions.padding8),
                                child: TextField(
                                  controller: _searchCtrl,
                                  focusNode: _searchFocus,
                                  style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
                                  decoration: InputDecoration(
                                    isDense: widget.isDense,
                                    prefixIcon: const Icon(SolarIconsOutline.magnifier),
                                    hintText: l10n.generalSearch,
                                    hintStyle: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
                                    border: OutlineInputBorder(
                                      borderRadius: AppBorderRadius.radius8,
                                      borderSide: BorderSide(color: context.neutralLow),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: AppBorderRadius.radius8,
                                      borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: AppBorderRadius.radius8,
                                      borderSide: BorderSide(
                                        color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: AppBorderRadius.radius8,
                                      borderSide: BorderSide(color: context.primaryColor),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.padding16,
                                      vertical: AppDimensions.padding4,
                                    ),
                                  ),
                                  onChanged: (q) {
                                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                                    _debounce = Timer(const Duration(milliseconds: 200), () {
                                      _overlaySetState?.call(() {
                                        _filtered = _applyFilter(q);
                                      });
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: _filtered.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(AppDimensions.size16),
                                        child: Text(l10n.generalNoResults, style: context.bodyMedium),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: _filtered.length,
                                        itemBuilder: (context, index) {
                                          final item = _filtered[index];
                                          return InkWell(
                                            onTap: () {
                                              widget.onChanged(item);
                                              _close();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: AppDimensions.padding12,
                                                vertical: AppDimensions.padding12,
                                              ),
                                              child: Row(
                                                children: [
                                                  if (widget.leading != null) ...[
                                                    widget.leading!(item),
                                                    const SizedBox(width: AppDimensions.size8),
                                                  ],
                                                  Expanded(
                                                    child: Text(
                                                      widget.itemLabel(item),
                                                      style: context.bodyMedium?.copyWith(
                                                        color: context.colorScheme.onSurface,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.value != null;
    final display = hasValue ? widget.itemLabel(widget.value as T) : null;

    final closedChild = hasValue
        ? Row(
            children: [
              if (widget.leading != null) ...[
                widget.leading!(widget.value as T),
                const SizedBox(width: AppDimensions.size12),
              ],
              Expanded(
                child: Text(
                  display ?? '',
                  style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : Text(
            widget.hintText,
            style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    return Column(
      key: _fieldKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        AppSpacing.small,
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: widget.isEnabled ? (_isOpen ? _close : _open) : null,
            child: InputDecorator(decoration: _fieldDecoration(context), isEmpty: !hasValue, child: closedChild),
          ),
        ),
      ],
    );
  }
}
