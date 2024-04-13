
class MyValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return "LocaleKeys.nameValidate.tr()";
    }
    if (displayName.length < 3) {
      return "LocaleKeys.nameValidate.tr()";
    }

    return null; // Return null if display name is valid
  }

  static String? displayMessageValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return " LocaleKeys.messageValidate.tr()";
    }
    if (displayName.length < 3) {
      return " LocaleKeys.messageValidate.tr()";
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "LocaleKeys.emailValidate.tr()";
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return "LocaleKeys.emailValidate2.tr()";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "LocaleKeys.passwordValidate.tr()";
    }
    if (value.length < 8) {
      return "LocaleKeys.passwordValidate2.tr()";
    }
    return null;
  }

  static String? urlValidator(String? value,{bool isRequired=false}) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if(isRequired){
      if (value?.isEmpty ?? true) {
        return 'يرجى ادخال رابط صحيح';
      }
    }

    if (value?.isEmpty ?? true) {
      return null;
    } else if (!regExp.hasMatch(value!)) {
      return 'يرجى ادخال رابط صحيح';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'كبمة المرورغير متطابقه';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return  "LocaleKeys.phoneValidate.tr()";
    }
    if (value.length < 6) {
      return  "LocaleKeys.phoneValidate2.tr()";
    }
    return null;
  }
}