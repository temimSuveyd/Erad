import 'dart:io';

import 'package:erad/core/class/handling_data.dart';

// ignore: non_constant_identifier_names
Future<Statusreqest> check_internet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty) {
      return Statusreqest.success;
    } else {
      return Statusreqest.noInternet;
    }
  } on SocketException catch (_) {
    return Statusreqest.noInternet;
  }
}
