import 'package:flutter/material.dart';

class Constants {
  static const double kPadding = 10.0;
  static const Color purpleLight = Color(0XFF1e224c);
  static const Color purpleDark = Color(0XFF0d193e);
  static const Color orange = Colors.orange;
  static const Color red = Colors.red;
  static const Color success = Color(0xff55c09b);
  static const Color info = Color(0xff429ef7);
  static const Color warning = Color(0xfff39e88);
  static const Color danger = Color(0xffef76a3);
  static const List<Map<String, String>> firebaseAuthExceptions = [
    {
      'code': 'email-already-in-use',
      'message': 'The account already exist for that email.',
    },
    {
      'code': 'invalid-email',
      'message': 'The email provided is invalid.',
    },
    {
      'code': 'weak-password',
      'message': 'The password provided is too weak.',
    },
    {
      'code': 'user-disabled',
      'message':
          'The account for that email has been disabled, please administrator office.',
    },
    {'code': 'user-not-found', 'message': 'Invalid email/password entered.'},
    {
      'code': 'wrong-password',
      'message': 'Invalid email/password entered.',
    },
    {
      'code': 'unknown',
      'message':
          'An internal error has occurred, please contact administrator office.'
    },
  ];
}
