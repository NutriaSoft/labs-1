import 'package:flutter/material.dart';

dynamic ifDarkMode(BuildContext context, light, dark) {
  return Theme.of(context).brightness == Brightness.dark ? dark : light;
}
