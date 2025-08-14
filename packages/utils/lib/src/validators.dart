import 'package:email_validator/email_validator.dart';
import 'package:localization/localization.dart';


String? validateFirstName(String? name) {
  if (name != null && name.trim().isEmpty) {
    return l10n.generalEnterFirstname;
  }
  return null;
}

String? validateLastName(String? name) {
  if (name != null && name.trim().isEmpty) {
    return l10n.generalEnterLastname;
  }
  return null;
}

String? validateEmpty(String? text) {
  if (text != null && text.trim().isEmpty) {
    return l10n.generalRequired;
  }
  return null;
}

String? validateEmail(String? email) {
  if (email != null && email.trim().isEmpty) {
    return l10n.generalEnterEmail;
  }
  if (email != null && EmailValidator.validate(email.trim()) == false) {
    return l10n.generalValidEmail;
  }
  return null;
}

String? validatePassword(String? password) {
  const minLength = 8;

  if (password != null && password.isEmpty) {
    return l10n.generalEnterPassword;
  }
  if (password != null && password.length < minLength) {
    return 'Password must be at least $minLength characters long';
  }
  if (password?.trim() != password) {
    return l10n.generalValidPassword;
  }
  return null;
}
