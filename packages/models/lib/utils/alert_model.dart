sealed class AlertModel {
  const AlertModel({
    required this.title,
    required this.message,
    this.duration = const Duration(seconds: 5),
    this.canDismiss = true,
    this.overlay = false,
    this.actionButtonText,
    this.textActionText,
    this.onActionButtonPressed,
    this.onTextActionPressed,
    this.onDismissed,
  });

  final String title;
  final String message;
  final Duration duration;
  final bool canDismiss;
  final bool overlay;
  final String? actionButtonText;
  final String? textActionText;
  final void Function()? onActionButtonPressed;
  final void Function()? onTextActionPressed;
  final void Function()? onDismissed;
}

class InfoAlert extends AlertModel {
  const InfoAlert({
    required super.title,
    required super.message,
    super.duration,
    super.canDismiss,
    super.overlay,
    super.actionButtonText,
    super.onActionButtonPressed,
    super.textActionText,
    super.onTextActionPressed,
    super.onDismissed,
  });
}

class SuccessAlert extends AlertModel {
  const SuccessAlert({
    required super.title,
    required super.message,
    super.duration,
    super.canDismiss,
    super.overlay,
    super.actionButtonText,
    super.onActionButtonPressed,
    super.textActionText,
    super.onTextActionPressed,
    super.onDismissed,
  });
}

class WarningAlert extends AlertModel {
  const WarningAlert({
    required super.title,
    required super.message,
    super.duration,
    super.canDismiss,
    super.overlay,
    super.actionButtonText,
    super.onActionButtonPressed,
    super.textActionText,
    super.onTextActionPressed,
    super.onDismissed,
  });
}

class ErrorAlert extends AlertModel {
  const ErrorAlert({
    required super.title,
    required super.message,
    super.duration,
    super.canDismiss,
    super.overlay,
    super.actionButtonText,
    super.onActionButtonPressed,
    super.onDismissed,
  });
}
