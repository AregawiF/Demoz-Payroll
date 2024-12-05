class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? companyNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }
    if (value.length < 2) {
      return 'Company name must be at least 2 characters';
    }
    return null;
  }

  static String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < 5) {
      return 'Please enter a valid address';
    }
    return null;
  }

  static String? tinNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'TIN number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit TIN number';
    }
    return null;
  }

  static String? numberOfEmployeesValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of employees is required';
    }
    final number = int.tryParse(value);
    if (number == null || number < 1) {
      return 'Please enter a valid number of employees';
    }
    return null;
  }

  static String? bankAccountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank account number is required';
    }
    if (!RegExp(r'^\d{10,16}$').hasMatch(value)) {
      return 'Please enter a valid bank account number';
    }
    return null;
  }

  static String? bankNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank name is required';
    }
    if (value.length < 2) {
      return 'Please enter a valid bank name';
    }
    return null;
  }
}
