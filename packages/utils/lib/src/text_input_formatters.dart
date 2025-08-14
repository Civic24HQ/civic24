import 'package:flutter/services.dart';

/// A formatter that doesn't allow spaces
final TextInputFormatter noSpacesFormatter = FilteringTextInputFormatter.deny(' ');

/// A formatter that allows only Alphabets
final TextInputFormatter alphabetsOnlyFormatter = FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'));

/// A formatter that allows Alphabet and spacing
final TextInputFormatter alphabetsWithSpaceFormatter = FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'));

/// A formatter that allows only numbers
final TextInputFormatter numbersOnlyFormatter = FilteringTextInputFormatter.digitsOnly;

/// A formatter that limits the number of characters
/// that can be entered in the text field
TextInputFormatter maxLengthFormatter(int maxLength) => LengthLimitingTextInputFormatter(maxLength);
