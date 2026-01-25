import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Utility mixin for proper controller cleanup
mixin ControllerDisposeMixin on GetxController {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  /// Creates and tracks a TextEditingController for automatic disposal
  TextEditingController createTextController([String? text]) {
    final controller = text != null 
        ? TextEditingController(text: text)
        : TextEditingController();
    _textControllers.add(controller);
    return controller;
  }

  /// Creates and tracks a FocusNode for automatic disposal
  FocusNode createFocusNode() {
    final focusNode = FocusNode();
    _focusNodes.add(focusNode);
    return focusNode;
  }

  @override
  void onClose() {
    // Dispose all tracked text controllers
    for (final controller in _textControllers) {
      controller.dispose();
    }
    _textControllers.clear();

    // Dispose all tracked focus nodes
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _focusNodes.clear();

    super.onClose();
  }
}

/// Extension methods for easier controller management
extension TextEditingControllerExtensions on TextEditingController {
  /// Clear and dispose the controller
  void clearAndDispose() {
    clear();
    dispose();
  }
}

extension FocusNodeExtensions on FocusNode {
  /// Unfocus and dispose the focus node
  void unfocusAndDispose() {
    unfocus();
    dispose();
  }
}

/// Performance optimization utilities
class PerformanceUtils {
  /// Debounce function calls to prevent excessive rebuilds
  static void debounce(VoidCallback callback, [Duration delay = const Duration(milliseconds: 300)]) {
    Future.delayed(delay, callback);
  }

  /// Throttle function calls to limit execution frequency
  static void throttle(VoidCallback callback, Duration duration) {
    callback();
    Future.delayed(duration);
  }
}