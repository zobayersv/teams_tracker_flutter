import 'package:intl/intl.dart';

class InputValidator {
  // Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Confirm Validate Password
  static String? validateConfirmPassword({
    String? value,
    required String password,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validate Username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 2) {
      return 'Username must be at least 3 characters long';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 3) {
      return 'full name must be at least 4 characters long';
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    if (value.length < 2) {
      return 'City name must be at least 3 characters long';
    }
    return null;
  }

  static String? validatenumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Phone';
    }
    if (value.length <= 7) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateaddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  static String? validatefiled(String? value) {
    if (value == null || value.isEmpty) {
      return 'Filed Are Required';
    }
    return null;
  }

  static String? validateBirthday(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your birthday';
    }
    try {
      final birthday = DateFormat('dd/MM/yyyy').parseStrict(value);
      final today = DateTime.now();
      if (birthday.isAfter(today)) {
        return 'Birthday cannot be in the future';
      }
      final age = today.year - birthday.year;
      if (age > 120) {
        return 'Please enter a valid birth year';
      }
    } catch (e) {
      return 'Please enter a valid date (DD/MM/YYYY)';
    }
    return null;
  }
}
