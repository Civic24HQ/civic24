part of 'app_text_field.dart';

class _BaseTextField extends StatefulWidget {
  const _BaseTextField({
    this.onTap,
    this.controller,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.focusNode,
    this.suffixIcon,
    this.readOnly = false,
    this.showRequiredIndicator = false,
    this.prefixIcon,
    this.initialValue,
    this.label,
    this.errorText,
    this.helperText,
    this.hintText,
    this.enabledBorder,
    this.filled,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.maxLines,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final String? label;
  final String? errorText;
  final String? helperText;
  final String? hintText;
  final Color? enabledBorder;
  final bool? filled;
  final bool showRequiredIndicator;
  final bool readOnly;
  final Color? fillColor;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  final int? maxLines;

  @override
  State<_BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<_BaseTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text.rich(
            style: context.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            TextSpan(
              text: widget.label,
              children: [
                if (widget.showRequiredIndicator)
                  TextSpan(
                    text: ' *',
                    style: context.bodySmall?.copyWith(color: context.error),
                  ),
              ],
            ),
          ),
          AppSpacing.small,
        ],
        TextFormField(
          onTap: widget.onTap,
          controller: _controller,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          style: context.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          validator: widget.validator,
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          onEditingComplete: widget.onEditingComplete,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: widget.filled,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppDimensions.padding16),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            errorText: widget.errorText,
            helperText: widget.helperText,
            helperMaxLines: 3,
            hintText: widget.hintText,
            errorStyle: context.bodyMedium?.copyWith(color: context.colorScheme.onErrorContainer),
            helperStyle: context.bodyMedium?.copyWith(
              color: widget.enabled ? context.colorScheme.onSurfaceVariant : context.neutralHigh,
            ),
            hintStyle: context.bodySmall?.copyWith(color: context.neutralHigh),
            hintMaxLines: 1,
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: widget.enabledBorder ?? context.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: widget.enabledBorder ?? context.colorScheme.outlineVariant),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: widget.enabledBorder ?? context.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }
}
