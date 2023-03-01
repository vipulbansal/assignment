import 'package:flutter/material.dart';

class CustomDecorators {
  InputDecoration getInputDecoration(
    String s,
  ) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(20),
      border: getOutlineInputBorder(),
      hintText: s,
      focusedBorder: getOutlineInputBorder(),
      enabledBorder: getOutlineInputBorder(),
      errorBorder: getOutlineInputBorder(),
      disabledBorder: getOutlineInputBorder(),
    );
  }

  OutlineInputBorder getOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
  }
}
