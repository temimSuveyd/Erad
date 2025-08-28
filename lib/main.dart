import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Erad/core/services/app_services.dart';
import 'package:Erad/firebase_options.dart';
import 'package:Erad/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.windows);
  await initailservieses();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      locale: Locale("ar"),
      theme: ThemeData(fontFamily: GoogleFonts.cairo().fontFamily),
    );
  }
}
