import 'package:erad/view/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/firebase_options.dart';
import 'package:erad/routes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initailservieses();
  initializeDateFormatting('ar');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // getPages: getPages,
      home: LoginPage(),
      locale: Locale("ar"),
      theme: ThemeData(fontFamily: GoogleFonts.cairo().fontFamily),
      debugShowCheckedModeBanner: false,
    );
  }
}
