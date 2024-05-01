import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {


  String label;
  bool obscureText;
  TextInputType keyboard;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  TextEditingController? controller;

  CustomFormField(
      {super.key, required this.label,required this.controller,this.validator, this.suffixIcon, this.obscureText = false, required this.keyboard});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: "*",
      controller:controller,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.bold),
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
