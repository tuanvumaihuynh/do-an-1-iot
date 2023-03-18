import 'package:form_field_validator/form_field_validator.dart';

class AppValidators {
  static final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Password is required'),
      MinLengthValidator(8,
          errorText: 'Password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'Password must have at least one special character')
    ],
  );

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Use a valid email!"),
  ]);
}
