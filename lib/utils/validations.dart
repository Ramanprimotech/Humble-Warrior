import 'package:email_validator/email_validator.dart';

import 'interface_validation.dart';


class Validations{
  String? handleEmail(String value) {
    if (EmailValidator.validate(value)) {
      return null;
    }
    return "Please Enter Valid Email";
  }

  String? handleFirst(String value) {
    if (value.length >= 3) {
      return null;
    }
    return "First name should be more than 3 characters";
  }

  String? handleLast(String value) {
    if (value.length >= 3) {
      return null;
    }
    return "Last name should be more than 3 characters";
  }

  String? handelPhone(String value) {
    if (RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$')
        .hasMatch(value)) {
      return null;
    }
    return "Invalid Phone";
  }

  String? handelBirthday(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return "Please enter your date of birth";
  }  String? handelCountry(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return "Please Select a country";
  }


  String? validator(FormType type , String? value){
    switch (type) {
      case FormType.firstName:
        return handleFirst(value!);
      case FormType.lastname:
        return handleLast(value!);
      case FormType.phone:
        return handelPhone(value!);
      case FormType.email:
        return handleEmail(value!);
      default:
        return "Please fill all the necessary fields";
    }
  }

}

