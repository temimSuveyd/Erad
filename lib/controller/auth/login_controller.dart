import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/handling_signin_errors.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/data/data_score/remote/user_data.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';

abstract class LoginController extends GetxController {
  login();
  saveUserDataLocal();
  goToHomePage();
}

class LoginControllerImp extends LoginController {
  UserData userData = UserData();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  final auth = FirebaseAuth.instance;
  @override
  login() async {
    var validator = formState.currentState;
    if (validator!.validate()) {
      statusreqest = Statusreqest.loading;
      update();
      String email = user_email.text.trim();
      String password = user_password.text.trim();
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        userData.add_user(email);
        saveUserDataLocal();
        goToHomePage();
        statusreqest = Statusreqest.success;
        update();
      } on FirebaseAuthException catch (e) {
        statusreqest = Statusreqest.success;
        update();
        return handling_sigin_errors(e);
      }
    } else {
      custom_snackBar();
    }
  }

  @override
  saveUserDataLocal() {
    String email = user_email.text;
    String password = user_password.text;
    final shared = services.sharedPreferences;
    shared.setString(AppShared.userID, email);
    shared.setString(AppShared.user_password, password);
  }

  @override
  goToHomePage() {
    Get.toNamed(AppRoutes.home_page);
  }
}
