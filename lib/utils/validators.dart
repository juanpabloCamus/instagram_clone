String? usernameValidator(String value) {
  if (value.isEmpty) {
    return 'Username cannot be empty';
  }
  if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }
  return null;
}

String? emailValidator(String value) {
  if (value.isEmpty) {
    return 'Email cannot be empty';
  }

  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Invalid email format';
  }

  return null;
}

String? passwordValidator(String value) {
  if (value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
