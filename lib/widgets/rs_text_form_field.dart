import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';

import '../constants/rs_text_style.dart';
import '../features/authentication/auth_validation.dart';

enum TextFieldType { email, password, name }

class RsTextFormField extends StatefulWidget {
  final TextFieldType textFieldType;
  final String hintName;
  final TextEditingController controller;
  final FormFieldValidator? validatorInfo;
  final String? errorMessage;

  const RsTextFormField({
    required this.textFieldType,
    required this.hintName,
    required this.controller,
    this.validatorInfo,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  State<RsTextFormField> createState() => _RsTextFormFieldState();
}

class _RsTextFormFieldState extends State<RsTextFormField> {
  late bool _isObscure;
  final FocusNode _focusNode = FocusNode();
  bool _hasInputError = false;

  @override
  void initState() {
    _isObscure = widget.textFieldType == TextFieldType.password;
    _focusNode.addListener(() {
      switch (widget.textFieldType) {
        case TextFieldType.email:
          if (!_focusNode.hasFocus) {
            if (AuthValidation.emailValidation(
                    widget.controller.text, context) ==
                null) {
              setState(() {
                _hasInputError = false;
              });
            } else {
              setState(() {
                _hasInputError = true;
              });
            }
          }
          break;
        case TextFieldType.password:
          if (!_focusNode.hasPrimaryFocus) {
            if (AuthValidation.passwordValidation(
                    widget.controller.text, context) ==
                null) {
              setState(() {
                _hasInputError = false;
              });
            } else {
              setState(() {
                _hasInputError = true;
              });
            }
          }
          break;
        case TextFieldType.name:
          if (!_focusNode.hasFocus) {
            if (AuthValidation.nameValidation(
                    widget.controller.text, context) ==
                null) {
              setState(() {
                _hasInputError = false;
              });
            } else {
              setState(() {
                _hasInputError = true;
              });
            }
          }
          break;
        default:
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textFieldType == TextFieldType.email
          ? TextInputType.emailAddress
          : null,
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validatorInfo,
      obscureText: _isObscure,
      decoration: InputDecoration(
        errorStyle: RsTextStyle.textFieldErrorStyle,
        errorText: _hasInputError ? widget.errorMessage : null,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.hintName,
        floatingLabelStyle: RsTextStyle.regular.copyWith(
          color: RsColors.primaryColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(RsMargins.standardRadius)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(RsMargins.standardRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(RsMargins.standardRadius),
        ),
      ),
    );
  }
}
