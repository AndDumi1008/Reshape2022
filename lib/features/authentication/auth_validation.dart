import 'package:flutter/material.dart';

class AuthValidation {
  static String? emailValidation(dynamic email, BuildContext context) {
    if (email == null ||
        email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@([a-zA-Z0-9]|([a-zA-Z0-9]+[a-zA-Z0-9-]+[a-zA-Z0-9]))+\.[a-zA-Z]+")
            .hasMatch(email)) {
      return 'Invalid Email';
    }
    return null;
  }

  static String? passwordValidation(dynamic password, BuildContext context) {
    if (password == null ||
        password.isEmpty ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password)) {
      return 'Invalid password';
    }
    return null;
  }

  static String? passwordConfirmation(
      dynamic password, dynamic passwordToCompare, BuildContext context) {
    if (password != passwordToCompare) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  static String? nameValidation(dynamic name, BuildContext context) {
    if (name == null || name.isEmpty) {
      return 'Invalid name';
    }
    return null;
  }
}
