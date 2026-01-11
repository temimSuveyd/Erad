// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AndroidCompatibility {
//   /// Check if running on Android
//   static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  
//   /// Check if running on a physical Android device (not emulator)
//   static bool get isPhysicalDevice => !kIsWeb && Platform.isAndroid;
  
//   /// Get Android API level (requires platform channel)
//   static Future<int?> getAndroidApiLevel() async {
//     if (!isAndroid) return null;
    
//     try {
//       const platform = MethodChannel('android_info');
//       final int apiLevel = await platform.invokeMethod('getApiLevel');
//       return apiLevel;
//     } catch (e) {
//       debugPrint('Error getting Android API level: $e');
//       return null;
//     }
//   }
  
//   /// Configure Android-specific settings
//   static void configureAndroidSettings() {
//     if (!isAndroid) return;
    
//     // Set preferred orientations for Android
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
    
//     // Configure system UI overlay style for Android
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//     );
//   }
  
//   /// Check if device supports hardware acceleration
//   static bool get supportsHardwareAcceleration => isAndroid;
  
//   /// Get safe area padding for Android devices
//   static EdgeInsets getSafeAreaPadding(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     return EdgeInsets.only(
//       top: mediaQuery.padding.top,
//       bottom: mediaQuery.padding.bottom,
//       left: mediaQuery.padding