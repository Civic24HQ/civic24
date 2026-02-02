// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/src/validators.dart';

const bool _autoTextFieldValidation = false;

const String EmailValueKey = 'email';

final Map<String, TextEditingController>
_UpdatePasswordViewTextEditingControllers = {};

final Map<String, FocusNode> _UpdatePasswordViewFocusNodes = {};

final Map<String, String? Function(String?)?>
_UpdatePasswordViewTextValidations = {EmailValueKey: Validator.validateEmail};

mixin $UpdatePasswordView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);

  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_UpdatePasswordViewTextEditingControllers.containsKey(key)) {
      return _UpdatePasswordViewTextEditingControllers[key]!;
    }

    _UpdatePasswordViewTextEditingControllers[key] = TextEditingController(
      text: initialValue,
    );
    return _UpdatePasswordViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_UpdatePasswordViewFocusNodes.containsKey(key)) {
      return _UpdatePasswordViewFocusNodes[key]!;
    }
    _UpdatePasswordViewFocusNodes[key] = FocusNode();
    return _UpdatePasswordViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    emailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap..addAll({EmailValueKey: emailController.text}),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _UpdatePasswordViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _UpdatePasswordViewFocusNodes.values) {
      focusNode.dispose();
    }

    _UpdatePasswordViewTextEditingControllers.clear();
    _UpdatePasswordViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this.fieldsValidationMessages.values.any(
    (validation) => validation != null,
  );

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get emailValue => this.formValueMap[EmailValueKey] as String?;

  set emailValue(String? value) {
    this.setData(this.formValueMap..addAll({EmailValueKey: value}));

    if (_UpdatePasswordViewTextEditingControllers.containsKey(EmailValueKey)) {
      _UpdatePasswordViewTextEditingControllers[EmailValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
}

extension Methods on FormStateHelper {
  void setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _UpdatePasswordViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _UpdatePasswordViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) => model.setValidationMessages(
  {EmailValueKey: getValidationMessage(EmailValueKey)},
);
