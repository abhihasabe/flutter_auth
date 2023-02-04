import 'package:formz/formz.dart';

//create enum

enum NumberValidationError { invalid }

//create class to validate email address

class IsNumber extends FormzInput<String, NumberValidationError> {
  const IsNumber.pure([String value = '']) : super.pure(value);

  const IsNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numberRegExp = RegExp(
    r'(^(?:[+0]9)?[0-9]{10,12}$)',
  );

  @override
  NumberValidationError? validator(String value) {
    return _numberRegExp.hasMatch(value)
        ? null
        : value.isNotEmpty == true
            ? null
            : NumberValidationError.invalid;
  }
}

extension Explanation on NumberValidationError {
  String? get email {
    switch (this) {
      case NumberValidationError.invalid:
        return "Please enter valid number";
      default:
        return null;
    }
  }
}
