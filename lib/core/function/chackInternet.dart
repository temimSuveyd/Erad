import 'dart:io';

import 'package:Erad/core/class/handling_data.dart';

// ignore: non_constant_identifier_names
 check_internet() async {
  try {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty) {
      return Statusreqest.success;
    }
  } on SocketException catch (_) {
    return Statusreqest.noInternet;
  }
}
