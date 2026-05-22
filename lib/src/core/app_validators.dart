class AppValidators {
  AppValidators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!regex.hasMatch(value)) {
      return 'Invalid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be 6+ characters';
    }

    return null;
  }

  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }
}
