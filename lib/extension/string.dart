extension RegExpStringExtension on String {
  bool isValidEmail() =>
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
          .hasMatch(this);

  bool containsNumber() => RegExp('[0-9]').hasMatch(this);

  bool containsUppercase() => RegExp('[A-Z]').hasMatch(this);

  bool containsLowercase() => RegExp('[a-z]').hasMatch(this);
}
