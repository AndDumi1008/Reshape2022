import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reshape/client/appwrite_client.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/features/authentication/register_page.dart';
import 'package:reshape/pages/home_page.dart';
import 'package:reshape/widgets/rs_button.dart';
import 'package:reshape/widgets/rs_text_form_field.dart';
import 'package:appwrite/appwrite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/rs_snackbar.dart';
import 'auth_validation.dart';

class LoginPage extends StatefulWidget {
  final Client client;
  const LoginPage({Key? key, required this.client}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
                'Log in',
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
                    padding: const EdgeInsets.only(
                      left: RsMargins.standardPadding,
                      right: RsMargins.standardPadding,
                      bottom: RsMargins.standardPadding,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: RsMargins.standardPadding),
              child: RsButton(
                text: 'Log in',
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (_isFormValid()) {
                    String authMessage = await AppWriteClient.logInUser(
                        _email.text.trim(),
                        _password.text.trim(),
                        widget.client);
                    final prefs = await SharedPreferences.getInstance();
                    if (authMessage == 'success') {
                      if (mounted) {
                        prefs.setBool('logInState', true);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      client: widget.client,
                                    )),
                            (route) => false);
                        showRsSnackbar(context, 'Successful log in',
                            isError: false);
                      }
                    } else {
                      if (mounted) {
                        showRsSnackbar(context, authMessage);
                      }
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: RsMargins.standardPadding),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: RsTextStyle.regular,
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          style: RsTextStyle.bold,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                        client: widget.client,
                                      )));
                              _email.clear();
                              _password.clear();
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
}
