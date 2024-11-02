import 'package:form_validator/form_validator.dart';

class Validators {
  Validators._();

  static final nameValidator = ValidationBuilder()
      .regExp(RegExp(r"^[a-zA-Z\s]"), "Provide your real names.")
      .required("Cannot be blank.")
      .minLength(2)
      .maxLength(150)
      .build();
  static final emailValidator = ValidationBuilder()
      .email("Provide a valid email address.")
      .required("Cannot be blank.")
      .maxLength(150)
      .build();
  static final passwordValidator = ValidationBuilder()
      .regExp(
          RegExp(
              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$'),
          'Password must be at least 8 characters long, include a number, a special character, and an uppercase letter.')
      .required("Cannot be blank.")
      .maxLength(24)
      .build();
}
