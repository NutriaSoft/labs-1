import 'package:flutter/material.dart';


InputDecoration messageFieldStyle(ColorScheme colors) {

  return InputDecoration(
    hintStyle: TextStyle(
      color: colors.onSurface.withOpacity(0.5),
    ),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 10.0,
    ),
    filled: true,
  );
}
