class Validations {
  static bool emailValidator(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
  }

  static bool passwordValidator(String password) {
    return password.length >= 6; 
  }

  static bool isEmpty(String value) {
    return value.trim().isEmpty;
  }

  static bool isValidLength(String value, int minLength) {
    return value.trim().length >= minLength;
  }
}