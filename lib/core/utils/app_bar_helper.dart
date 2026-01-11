import 'package:flutter/material.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';

/// Helper function to create custom app bar with context
AppBar createCustomAppBar(String title, BuildContext context) {
  return customAppBar(title: title, context: context);
}
