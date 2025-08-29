// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/src/validators.dart';

const bool _autoTextFieldValidation = false;

const String ContentValueKey = 'content';

final Map<String, TextEditingController> _AddReportViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AddReportViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddReportViewTextValidations = {
  ContentValueKey: validateEmpty,
};

mixin $AddReportView {
  TextEditingController get contentController =>
      _getFormTextEditingController(ContentValueKey);

  FocusNode get contentFocusNode => _getFormFocusNode(ContentValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddReportViewTextEditingControllers.containsKey(key)) {
      return _AddReportViewTextEditingControllers[key]!;
    }

    _AddReportViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddReportViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddReportViewFocusNodes.containsKey(key)) {
      return _AddReportViewFocusNodes[key]!;
    }
    _AddReportViewFocusNodes[key] = FocusNode();
    return _AddReportViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    contentController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    contentController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ContentValueKey: contentController.text,
        }),
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

    for (var controller in _AddReportViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddReportViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddReportViewTextEditingControllers.clear();
    _AddReportViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get contentValue => this.formValueMap[ContentValueKey] as String?;

  set contentValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ContentValueKey: value}),
    );

    if (_AddReportViewTextEditingControllers.containsKey(ContentValueKey)) {
      _AddReportViewTextEditingControllers[ContentValueKey]?.text = value ?? '';
    }
  }

  bool get hasContent =>
      this.formValueMap.containsKey(ContentValueKey) &&
      (contentValue?.isNotEmpty ?? false);

  bool get hasContentValidationMessage =>
      this.fieldsValidationMessages[ContentValueKey]?.isNotEmpty ?? false;

  String? get contentValidationMessage =>
      this.fieldsValidationMessages[ContentValueKey];
}

extension Methods on FormStateHelper {
  setContentValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ContentValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    contentValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ContentValueKey: getValidationMessage(ContentValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddReportViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddReportViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ContentValueKey: getValidationMessage(ContentValueKey),
    });
