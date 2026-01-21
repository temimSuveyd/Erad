import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/core/constans/sharedPreferences.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/function/handling_supabase_errors.dart';
import 'package:erad/core/services/app_services.dart';
import 'package:erad/core/config/supabase_config.dart';
import 'package:erad/data/data_score/remote/user_data.dart';
import 'package:erad/view/custom_widgets/custom_snackbar.dart';

abstract class LoginController extends GetxController {
  void login();
  void saveUserDataLocal(String userId);
  void goToHomePage();
  void saveLogin();
  void changeSaveLogin();
}

class LoginControllerImp extends LoginController {
  UserData userData = UserData();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController companyName = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Statusreqest statusreqest = Statusreqest.success;
  Services services = Get.find();
  var isLogin = false.obs;

  @override
  login() async {
    var validator = formState.currentState;
    if (validator!.validate()) {
      statusreqest = Statusreqest.loading;
      update();
      String email = userEmail.text.trim();
      String password = userPassword.text.trim();
      String company = companyName.text.trim();
      try {
        final response = await SupabaseConfig.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (response.user != null) {
          // Kullanıcıyı veritabanına ekle
          try {
            final userId = await userData.addUser(email, company);
            saveUserDataLocal(userId);
            goToHomePage();
            saveLogin();
          } catch (e) {
            statusreqest = Statusreqest.success;
            update();
            Get.defaultDialog(
              title: "خطأ",
              middleText: "حدث خطأ غير متوقع: $e",
              backgroundColor: AppColors.background,
              onCancel: () => Get.back(),
              onConfirm: () => Get.back(),
              buttonColor: AppColors.primary,
            );
          }
        }
        statusreqest = Statusreqest.success;
        update();
      } on AuthException catch (e) {
        statusreqest = Statusreqest.success;
        update();
        return handleSupabaseAuthError(e);
      } catch (e) {
        statusreqest = Statusreqest.success;
        update();
        Get.defaultDialog(
          title: "خطأ",
          middleText: "حدث خطأ غير متوقع: $e",
          backgroundColor: AppColors.background,
          onCancel: () => Get.back(),
          onConfirm: () => Get.back(),
          buttonColor: AppColors.primary,
        );
      }
    } else {
      custom_snackBar();
    }
  }

  @override
  saveUserDataLocal(String userId) {
    final shared = services.sharedPreferences;
    String password = userPassword.text;
    String company = companyName.text;

    // Kullanıcı bilgilerini kaydet
    shared.setString(AppShared.userID, userId);
    shared.setString(AppShared.user_password, password);
    shared.setString(AppShared.company_name, company);

    // Supabase kullanıcı ID'sini de kaydet
    final currentUser = SupabaseConfig.auth.currentUser;
    if (currentUser != null) {
      shared.setString(AppShared.userUuid, currentUser.id);
    }
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
