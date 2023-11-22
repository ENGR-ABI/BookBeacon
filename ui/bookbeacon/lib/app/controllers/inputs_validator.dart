import 'package:get/get.dart';

class InputsValidator extends GetxController {
  static InputsValidator get inst => Get.find();
  final Map<String, String> errorList = {
    'email.empty': 'Email field cannot be empty',
    'email.invalid': 'Invalid email entered',
    'number.empty': 'Number field cannot be empty',
    'number.invalid': 'Invalid phone number entered',
    'name.empty': 'Name field cannot be empty',
    'name.invalid': 'Invalid name entered',
    'username.empty': 'Username field cannot be empty',
    'username.invalid': 'Username can only contain [@, -] no whitespaces',
  };

  final Map<String, RegExp> patterns = {
    'email': RegExp(r'^(\w+[\-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$'),
    'phone-number': RegExp(r'^(\d{10})+$'),
    'name': RegExp(r'^(\w+\s?\w+\s?)+$'),
    'username': RegExp(r'^(([\@]?)\w+[\-]?\w+)+$'),
  };

  String? email(
    email, {
    bool isOptional = false,
  }) {
    String? result;
    if (isOptional == false) {
      if (email.isEmpty) {
        return errorList['email.empty'];
      } else {
        final matches = patterns['email']!.allMatches(email);
        for (var match in matches) {
          result = match[0];
        }
        if (result == null || result == '') {
          return errorList['email.invalid'].toString();
        }
      }
    } else {
      final matches = patterns['email']!.allMatches(email);
      for (var match in matches) {
        result = match[0];
      }
      if (result == null || result == '') {
        return errorList['email.invalid'];
      }
    }
    return null;
  }

  String? number(
    number, {
    bool isOptional = false,
    double length = 10,
  }) {
    String? result;
    if (isOptional == false) {
      if (number.isEmpty) {
        return errorList['number.empty'];
      } else {
        final matches = patterns['phone-number']!.allMatches(number);
        for (var match in matches) {
          result = match[0];
        }
        if (result == null || result == '') {
          return errorList['number.invalid'].toString();
        }
      }
    } else {
      final matches = patterns['number']!.allMatches(number);
      for (var match in matches) {
        result = match[0];
      }
      if (result == null || result == '') {
        return errorList['number.invalid'];
      }
    }
    return null;
  }

  String? name(
    name, {
    bool isOptional = false,
  }) {
    String? result;
    if (isOptional == false) {
      if (name.isEmpty) {
        return errorList['name.empty'];
      } else {
        final matches = RegExp(r'^(\p{L}\s?\p{L}*)+$', unicode: true).allMatches(name);
        for (var match in matches) {
          result = match[0];
        }
        if (result == null || result == '') {
          return errorList['name.invalid'].toString();
        }
      }
    } else {
      final matches = patterns['name']!.allMatches(name);
      for (var match in matches) {
        result = match[0];
      }
      if (result == null || result == '') {
        return errorList['name.invalid'];
      }
    }
    return null;
  }

  String? username(String? username, {int lenght = 20}) {
    String? result;
    if (username!.length <= lenght) {
      if (username.isEmpty) {
        return errorList['username.empty'];
      } else {
        final matches = patterns['username']!.allMatches(username);
        for (var match in matches) {
          result = match[0];
        }
        if (result == null || result == '') {
          return errorList['username.invalid'].toString();
        }
      }
    } else {
      return 'Username must be not exceed $lenght characters';
    }
    return null;
  }

  String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field should not be empty';
    } else if (password.length < 6) {
      return 'Password must be atleast 6 characters';
    }
    // else {
    //   final regex = RegExp(r'(?=.*[A-Za-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])');
    //   if (!regex.hasMatch(password)) {
    //     return 'Password must have atleast one special character and one digit';
    //   }
    // }
    return null;
  }

  String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password field must not be empty.';
    } else if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }
}
