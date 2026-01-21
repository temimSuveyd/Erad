import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

void handleSupabaseAuthError(AuthException e) {
  String errorMessage;
  switch (e.message.toLowerCase()) {
    case 'invalid login credentials':
    case 'email not confirmed':
      errorMessage =
          'بيانات اعتماد المصادقة المقدمة غير صحيحة أو مشوهة أو انتهت صلاحيتها';
      break;
    case 'user not found':
      errorMessage = 'لم يتم العثور على مستخدم مع عنوان البريد الإلكتروني هذا';
      break;
    case 'invalid email':
      errorMessage = 'عنوان البريد الإلكتروني غير صالح';
      break;
    case 'user disabled':
      errorMessage = 'تم تعطيل هذا الحساب';
      break;
    case 'too many requests':
      errorMessage = 'الكثير من المحاولات ، يرجى المحاولة مرة أخرى لاحقًا';
      break;
    case 'signup disabled':
      errorMessage =
          'لم يتم تمكين تسجيل الدخول عبر البريد الإلكتروني/كلمة المرور';
      break;
    default:
      errorMessage = 'خطأ في تسجيل الدخول: ${e.message}';
  }

  Get.defaultDialog(
    title: "خطأ",
    middleText: errorMessage,
    backgroundColor: AppColors.background,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      Get.back();
    },
    buttonColor: AppColors.primary,
  );
}

void handleSupabaseError(PostgrestException e) {
  String errorMessage;
  switch (e.code) {
    case '23505': // Unique violation
      errorMessage = 'البيانات موجودة بالفعل';
      break;
    case '23503': // Foreign key violation
      errorMessage = 'لا يمكن حذف هذا العنصر لأنه مرتبط ببيانات أخرى';
      break;
    case '42501': // Insufficient privilege
      errorMessage = 'ليس لديك صلاحية للوصول إلى هذه البيانات';
      break;
    default:
      errorMessage = 'حدث خطأ في قاعدة البيانات: ${e.message}';
  }

  Get.defaultDialog(
    title: "خطأ",
    middleText: errorMessage,
    backgroundColor: AppColors.background,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      Get.back();
    },
    buttonColor: AppColors.primary,
  );
}
