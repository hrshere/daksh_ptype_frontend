

class RegexValidators {
  // static RegExp mobileNumberRegex = RegExp(StringsConstants.mobileNumberRegex);
  static String emailRegexx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp emailRegex = RegExp(emailRegexx);
// static RegExp fullNameRegex = RegExp(StringsConstants.fullNameRegex2);
}

class Validators {
  static String? Function(String?)? ssnValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return "This can't be empty";
    } else if (val.length < 11) {
      return 'Please provide valid SSN';
    } else {
      return null;
    }
  };

  static String? Function(String?)? isTouchedEmailValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return "Field cannot be blank";
    } else if (!RegexValidators.emailRegex.hasMatch(val)) {
      return 'Enter Valid E-mail';
    } else {
      return null;
    }
  };



  static String? Function(String?)? isEmptyValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return "This field can't be empty";
    } else {
      return null;
    }
  };

  static String? Function(dynamic)? dropDownIsEmptyValidator = (dynamic value) {
    if (value == null) {
      return "This field can't be empty";
    } else {
      return null;
    }
  };

  static String? Function(String?)? zipValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return 'Zip Must be entered';
    } else if (val.length != 5) {
      return "Zip should be 5 digits";
    }
    return null;
  };

  static String? Function(String?)? otpCheck = (String? value) {
    var val = value?.trim();
    if (val == null || val.isEmpty) {
      return "Enter all 4 digits of code"; // Return an error message if the field is empty
    } else if (val.length != 4) {
      return "Enter all 4 digits of code";
    } else {
      return null; // Return null if the field is not empty and meets the criteria
    }
  };

  static String? Function(String?)? inputOtpValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return 'OTP Must be entered';
    } else if (val.length < 6) {
      return 'OTP Must be entered';
    } else {
      return null;
    }
  };

  static String? Function(String?)? positionValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return "This field can't be empty";
    } else if (int.parse(val) < 1) {
      return 'The minimum no. of positions must be 1';
    } else {
      return null;
    }
  };

  static String? Function(String?)? rateValidator = (String? value) {
    var val = value?.trim();
    if (val!.contains('-')) {
      return 'Please enter valid value';
    } else {
      return null;
    }
  };

  static String? Function(String?)? isEmptyRateValidator = (String? value) {
    var val = value?.trim();
    if (val!.isEmpty) {
      return "Min Rate can't be empty";
    } else {
      return null;
    }
  };
}
