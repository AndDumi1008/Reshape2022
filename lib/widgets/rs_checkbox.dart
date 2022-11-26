import 'package:flutter/material.dart';


class RsCheckbox extends StatefulWidget {
  final Function(bool isChecked) isChecked;
  final Text text;

  const RsCheckbox({
    required this.text,
    required this.isChecked,
    Key? key,
  }) : super(key: key);

  @override
  State<RsCheckbox> createState() => _RsCheckboxState();
}

class _RsCheckboxState extends State<RsCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Transform.scale(
        scale: 1.2,
        child: Checkbox(
          side: const BorderSide(width: 0.5, color: Colors.black),
          fillColor: MaterialStateProperty.resolveWith(
              ((states) => Colors.black)),
          hoverColor: Colors.transparent,
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value ?? false;
              widget.isChecked(_value);
            });
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      Expanded(
        child: widget.text,
      ),
    ]);
  }
}
