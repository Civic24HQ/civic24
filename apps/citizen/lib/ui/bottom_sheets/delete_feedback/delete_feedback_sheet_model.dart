import 'dart:async';

import 'package:citizen/app/app.dialogs.dart';
import 'package:citizen/app/app.locator.dart';
import 'package:constants/constants.dart';
import 'package:services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:utils/utils.dart';

class DeleteFeedbackSheetModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _analyticsService = locator<AnalyticsService>();
  final _userService = locator<UserService>();
  final _log = getLogger('DeleteFeedbackSheetModel');

  List<DeleteFeedbackReason> get feedbacks => citizenFeedbackReasons;

  final List<DeleteFeedbackReason> _selectedFeedbacks = [];
  List<DeleteFeedbackReason> get selectedFeedbacks => _selectedFeedbacks;

  String? _otherFeedback;
  String? get otherFeedback => _otherFeedback;

  bool get isOtherFeedbackValid => _otherFeedback != null && _otherFeedback!.isNotEmpty;

  bool get canSubmitFeedback =>
      _selectedFeedbacks.isNotEmpty &&
      (!_selectedFeedbacks.contains(DeleteFeedbackReason.other) || isOtherFeedbackValid);

  void onSelectFeedback(DeleteFeedbackReason? value) {
    if (value == null) {
      return;
    }
    if (_selectedFeedbacks.contains(value)) {
      _selectedFeedbacks.remove(value);
    } else {
      _selectedFeedbacks.add(value);
    }
    rebuildUi();
  }

  void onOtherFeedbackChanged(String? value) {
    _otherFeedback = value;
    rebuildUi();
  }

  Future<void> onSkipFeedback() async {
    unawaited(_dialogService.showCustomDialog(variant: DialogType.loading, title: 'Deleting Account...'));
    await _userService.updateUser(
      _userService.user!.copyWith(account: _userService.user!.account.copyWith(isDeleted: true)),
    );
    _dialogService.completeDialog(DialogResponse());
    _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
  }

  Future<void> onSubmitFeedback() async {
    unawaited(_dialogService.showCustomDialog(variant: DialogType.loading, title: 'Submitting Feedback...'));

    _analyticsService.logButtonClick(kAnalyticButtonSubmitFeedback);
    try {
      final feedbackReason = _selectedFeedbacks
          .map((e) {
            if (e == DeleteFeedbackReason.other) {
              return _otherFeedback != null && _otherFeedback!.isNotEmpty ? 'Other: $_otherFeedback' : 'Other';
            }
            return e.toString().split('.').last;
          })
          .join(', ');
      _log.i('Submitting account deletion feedback: $feedbackReason');
      await _userService.updateUser(
        _userService.user!.copyWith(
          account: _userService.user!.account.copyWith(deleteReason: feedbackReason, isDeleted: true),
        ),
      );
      _dialogService.completeDialog(DialogResponse());
      _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
    } catch (e) {
      _log.e('Error sending password reset email, error: $e');
    }
  }
}
