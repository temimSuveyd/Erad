import 'package:get/get.dart';

/// Input validation functions for the application
class ValidatorInput {
  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    }

    if (!GetUtils.isEmail(value)) {
      return "يرجى إدخال بريد إلكتروني صحيح";
    }

    return null;
  }

  /// Validates password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور مطلوبة";
    }

    if (value.length < 6) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    }

    return null;
  }

  /// Validates company name
  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return "اسم الشركة مطلوب";
    }

    if (value.length < 2) {
      return "اسم الشركة يجب أن يكون حرفين على الأقل";
    }

    return null;
  }

  /// Validates required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName مطلوب";
    }

    return null;
  }

  /// Validates phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "رقم الهاتف مطلوب";
    }

    if (!GetUtils.isPhoneNumber(value)) {
      return "يرجى إدخال رقم هاتف صحيح";
    }

    return null;
  }

  /// Validates numeric input
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName مطلوب";
    }

    if (!GetUtils.isNum(value)) {
      return "يرجى إدخال رقم صحيح";
    }

    return null;
  }

  /// Validates price input
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return "السعر مطلوب";
    }

    final price = double.tryParse(value);
    if (price == null || price < 0) {
      return "يرجى إدخال سعر صحيح";
    }

    return null;
  }
}
