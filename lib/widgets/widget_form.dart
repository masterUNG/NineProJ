// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.suffixWidget,
    this.obsecu,
    this.textEditingController,
    this.labelWidget,
  }) : super(key: key);

  final String? hint;
  final Widget? suffixWidget;
  final bool? obsecu;
  final TextEditingController? textEditingController;
  final Widget? labelWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(
            label: labelWidget,
            suffixIcon: suffixWidget,
            hintText: hint,
            filled: true,
            border: OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
      ),
    );
  }
}
