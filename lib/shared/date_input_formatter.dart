// File: date_input_formatter.dart

import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (newText.length > 10) {
      // If the new text is longer than the pattern, don't allow the change
      return oldValue;
    }
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    final newTextLength = newText.length;
    final newString = StringBuffer();
    if (newTextLength >= 3) {
      newString.write(newText.substring(0, usedSubstringIndex = 2) + '/');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 6) {
      newString.write(newText.substring(3, usedSubstringIndex = 5) + '/');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newTextLength > usedSubstringIndex) {
      newString.write(newText.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
