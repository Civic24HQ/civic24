// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/logout/logout_dialog.dart';

enum DialogType {
  logout,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.logout: (context, request, completer) =>
        LogoutDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
