import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/function/handling_signin_errors.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/core/utils/controller_utils.dart';
import 'package:erad/data/data_score/remote/user_data.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';

abstract class LoginController extends GetxController {
  void login();
  void saveUserDataLocal();
  void goToHomePage();
  void saveLogin();
  void changeSaveLogin();
}

class LoginControllerImp extends LoginController with ControllerDisposeMixin {
  UserData userData = UserData();
  late final TextEditingController user_email = createTextController();
  late final TextEditingController user_password = createTextController();
  late final TextEditingController company_name = createTextController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  var isLogin = false.obs;
  final auth = FirebaseAuth.instance;

  @override
  login() async {
    var validator = formState.currentState;
    if (validator == null) return;
    
    if (validator.validate()) {
      statusreqest = Statusreqest.loading;
      update();
      
      String email = user_email.text.trim();
      String password = user_password.text.trim();
      String companyName = company_name.text.trim();
      
      // Additional validation
      if (companyName.isEmpty) {
        statusreqest = Statusreqest.success;
        update();
        custom_snackBar(null, null, "الرجاء إدخال اسم الشركة");
        return;
      }
      
      if (email.isEmpty) {
        statusreqest = Statusreqest.success;
        update();
        custom_snackBar(null, null, "الرجاء إدخال البريد الإلكتروني");
        return;
      }
      
      if (password.isEmpty) {
        statusreqest = Statusreqest.success;
        update();
        custom_snackBar(null, null, "الرجاء إدخال كلمة المرور");
        return;
      }
      
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        userData.add_user(email);
        saveUserDataLocal();
        goToHomePage();
        saveLogin();
        statusreqest = Statusreqest.success;
        update();
      } on FirebaseAuthException catch (e) {
        statusreqest = Statusreqest.success;
        update();
        return handling_sigin_errors(e);
      } catch (e) {
        statusreqest = Statusreqest.success;
        update();
        custom_snackBar(AppColors.error, "خطأ", "حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى");
      }
    } else {
      custom_snackBar(null, null, "الرجاء ملء جميع الحقول المطلوبة");
    }
  }

  @override
  saveUserDataLocal() {
    final shared = services.sharedPreferences;
    String email = user_email.text;
    String password = user_password.text;
    String company = company_name.text;
    shared.setString(AppShared.userID, email);
    shared.setString(AppShared.user_password, password);
    shared.setString(AppShared.company_name, company);
  }

  @override
  goToHomePage() {
    Get.toNamed(AppRoutes.home_page);
  }

  @override
  saveLogin() {
    if (isLogin.value == true) {
      services.sharedPreferences.setBool(AppShared.isLoging, true);
    }
  }

  @override
  changeSaveLogin() {
    if (isLogin.value == true) {
      isLogin = false.obs;
    } else {
      isLogin = true.obs;
    }
    update();
  }
}
