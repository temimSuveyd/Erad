import "package:get/get.dart";

validatorInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "لا يمكن أن تكون فارغة";
  }
  if (val.length < min) {
    return "لا يمكن أن يكون أقل بعد ذلك $min";
  }

  if (val.length > max) {
    return "لا يمكن أن يكون أكبر بعد ذلك $max";
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "البريد الإلكتروني غير صالح";
    }
  }
  if (type == "int") {
    if (!GetUtils.isNum(val)) {
      return "لا تكتب أي شيء آخر غير الأرقام";
    }
  }
    if (type == "text") {
    if (!GetUtils.isTxt(val)) {
      return "لا تدخل شيئًا آخر غير النص";
    }
  }
}
