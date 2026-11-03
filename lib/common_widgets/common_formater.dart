import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

String formatNumber(double value) {
  final formatted = value == value.truncateToDouble()
      ? NumberFormat('#,##0').format(value.toInt())
      : NumberFormat('#,##0.##').format(value);
  return formatted;
}

class TextFieldNumberFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    String number = newValue.text.replaceAll(',', '');

    final int value = int.parse(number);
    final String newText = _formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

String getNameFirstLetter(String name) {
  List<String> parts = name.trim().split(' ');

  if (parts.length == 1) {
    return parts[0][0].toUpperCase();
  } else {
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

String formatIntNumber(num number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(number % 1000000000 == 0 ? 0 : 1)}B';
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(number % 1000000 == 0 ? 0 : 1)}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
  }
  return number.toString();
}
