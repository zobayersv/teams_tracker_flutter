import 'textfield_validation.dart';
export 'textfield_validation.dart';

/// Centralized validator utility conforming to the architecture standard.
final class Validator {
  Validator._();

  static String? validateEmail(String? value) =>
      InputValidator.validateEmail(value);

  static String? validatePassword(String? value) =>
      InputValidator.validatePassword(value);

  static String? validateConfirmPassword({
    String? value,
    required String password,
  }) =>
      InputValidator.validateConfirmPassword(value: value, password: password);

  static String? validateUsername(String? value) =>
      InputValidator.validateUsername(value);

  static String? validateFullName(String? value) =>
      InputValidator.validateFullName(value);

  static String? validateCity(String? value) =>
      InputValidator.validateCity(value);

  static String? validateNumber(String? value) =>
      InputValidator.validatenumber(value);

  static String? validateAddress(String? value) =>
      InputValidator.validateaddress(value);

  static String? validateField(String? value) =>
      InputValidator.validatefiled(value);

  static String? validateBirthday(String? value) =>
      InputValidator.validateBirthday(value);
}
