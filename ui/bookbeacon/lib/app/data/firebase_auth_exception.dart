final List<Map<String, String>> firebaseAuthExceptions = [
  {
    'code': 'email-already-in-use',
    'message': 'The account already exist for that email.',
  },
  {
    'code': 'invalid-email',
    'message': 'The email provided is invalid.',
  },
  {
    'code': 'operation-not-allowed',
    'message':
        'The account creation with email has been disabled, please use other option.',
  },
  {
    'code': 'weak-password',
    'message': 'The password provided is too weak.',
  },
  {
    'code': 'user-disabled',
    'message':
        'The account for that email has been disabled, please contact us.',
  },
  {'code': 'user-not-found', 'message': 'No account found for that user.'},
  {
    'code': 'wrong-password',
    'message': 'Wrong password provied for that user.'
  },
  {
    'code': 'unknown',
    'message': 'An internal error has occurred, please contact us.'
  },
  {'code': 'wrong-password', 'message': 'The password provided is incorrect.'},
];
