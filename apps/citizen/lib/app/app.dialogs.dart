// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/loading/loading_dialog.dart';
import '../ui/dialogs/logout/logout_dialog.dart';
import '../ui/dialogs/send_password_reset_email/send_password_reset_email_dialog.dart';
import '../ui/dialogs/upload_media/upload_media_dialog.dart';

enum DialogType {
  logout,
  loading,
  sendPasswordResetEmail,
  uploadMedia,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.logout: (context, request, completer) =>
        LogoutDialog(request: request, completer: completer),
    DialogType.loading: (context, request, completer) =>
        LoadingDialog(request: request, completer: completer),
    DialogType.sendPasswordResetEmail: (context, request, completer) =>
        SendPasswordResetEmailDialog(request: request, completer: completer),
    DialogType.uploadMedia: (context, request, completer) =>
        UploadMediaDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
