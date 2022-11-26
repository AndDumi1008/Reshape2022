import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reshape/client/appwrite_client.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/pages/home_page.dart';
import 'package:reshape/widgets/rs_button.dart';
import 'package:reshape/widgets/rs_checkbox.dart';
import 'package:reshape/widgets/rs_text_form_field.dart';
import 'package:appwrite/appwrite.dart';

import '../../constants/rs_urls.dart';
import '../../widgets/rs_snackbar.dart';
import '../../widgets/web_view_page.dart';
import 'auth_validation.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final Client client;
  const RegisterPage({Key? key, required this.client}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isCheckboxChecked = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RsColors.backgroundAuthColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  RsMargins.standardPadding, 80, RsMargins.standardPadding, 0),
              child: Text(
                'Set up your account',
                style: RsTextStyle.bold.copyWith(fontSize: 24),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(RsMargins.standardPadding),
                    child: RsTextFormField(
                        textFieldType: TextFieldType.email,
                        hintName: 'Email',
                        controller: _email,
                        validatorInfo: (email) =>
                            AuthValidation.emailValidation(email, context),
                        errorMessage: 'Invalid email'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: RsMargins.standardPadding),
                    child: RsTextFormField(
                        textFieldType: TextFieldType.name,
                        hintName: 'Full name',
                        controller: _name,
                        validatorInfo: (name) =>
                            AuthValidation.nameValidation(name, context),
                        errorMessage: 'Invalid name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      RsMargins.standardPadding,
                    ),
                    child: RsTextFormField(
                        textFieldType: TextFieldType.password,
                        hintName: 'Password',
                        controller: _password,
                        validatorInfo: (password) =>
                            AuthValidation.passwordValidation(
                                password, context),
                        errorMessage: 'Invalid password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: RsMargins.standardPadding,
                      right: RsMargins.standardPadding,
                      bottom: RsMargins.mediumPadding,
                    ),
                    child: RsTextFormField(
                        textFieldType: TextFieldType.password,
                        hintName: 'Confirm password',
                        controller: _confirmPassword,
                        validatorInfo: (password) =>
                            AuthValidation.passwordConfirmation(
                                _password.text, password, context),
                        errorMessage: 'Passwords don\'t match'),
                  ),
                ],
              ),
            ),
            RsCheckbox(
              text: Text.rich(
                TextSpan(
                  text: 'I have read and I agree with ',
                  style: RsTextStyle.regular,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const WebViewPage(url: termsAndConditionsUrl),
                            ),
                          );
                        },
                      text: 'Terms and Conditions ',
                      style: RsTextStyle.bold,
                      children: [
                        TextSpan(
                          text: 'and ',
                          style: RsTextStyle.regular,
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WebViewPage(url: privacyUrl),
                                    ),
                                  );
                                },
                              text: 'Data Privacy',
                              style: RsTextStyle.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isChecked: (bool isChecked) {
                setState(() {
                  _isCheckboxChecked = isChecked;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: RsMargins.standardPadding),
              child: RsButton(
                  text: 'Sign up',
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (_isPasswordValid(_password.text.trim())) {
                      if (_isFormValid()) {
                        if (_isCheckboxChecked == true) {
                          String authMessage = await AppWriteClient.signUpUser(
                              _email.text.trim(),
                              _password.text.trim(),
                              _name.text.trim(),
                              widget.client);
                          if (authMessage == 'success') {
                            if (mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                              showRsSnackbar(context, 'Successful sign up',
                                  isError: false);
                            }
                          } else {
                            if (mounted) {
                              showRsSnackbar(context, authMessage);
                            }
                          }
                        } else {
                          showRsSnackbar(context,
                              'Please agree with the terms and conditions and data privacy if you want to continue');
                        }
                      }
                    } else {
                      showRsSnackbar(context,
                          'Password must contain 8 or more characters, a digit, a special character, a lower case and a upper case');
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: RsMargins.standardPadding),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: RsTextStyle.regular,
                    children: [
                      TextSpan(
                          text: 'Log in',
                          style: RsTextStyle.bold,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                        client: widget.client,
                                      )));
                              _email.clear();
                              _password.clear();
                              _confirmPassword.clear();
                              _name.clear();
                            })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _formKey.currentState!.validate();
  }

  bool _isPasswordValid(String password) {
    String? passwordErrorMessage =
        AuthValidation.passwordValidation(password, context);
    if (passwordErrorMessage != null) {
      return false;
    }
    return true;
  }
}
