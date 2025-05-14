String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email required';
  }

  String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regex = RegExp(emailPattern);

  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password required';
  }

  List<String> errors = [];

  // Check for at least one lowercase letter
  // if (!RegExp(r'[a-z]').hasMatch(value)) {
  //   errors.add('Password must contain at least one lowercase letter.');
  // }

  // // Check for at least one uppercase letter
  // if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //   errors.add('Password must contain at least one uppercase letter.');
  // }

  // // Check for at least one special character
  // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
  //   errors.add('Password must contain at least one special character.');
  // }

  // Combine all errors into a single string
  if (errors.isNotEmpty) {
    return errors.join(' ');
  }

  return null; // No errors
}

String? validateCurrentPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'current password required';
  }

  List<String> errors = [];

  // Check for at least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    errors.add('Password must contain at least one lowercase letter.');
  }

  // Check for at least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    errors.add('Password must contain at least one uppercase letter.');
  }

  // Check for at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    errors.add('Password must contain at least one special character.');
  }

  // Combine all errors into a single string
  if (errors.isNotEmpty) {
    return errors.join(' ');
  }

  return null; // No errors
}

String? validatenewpassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'new password required';
  }

  List<String> errors = [];

  // Check for at least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    errors.add('Password must contain at least one lowercase letter.');
  }

  // Check for at least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    errors.add('Password must contain at least one uppercase letter.');
  }

  // Check for at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    errors.add('Password must contain at least one special character.');
  }

  // Combine all errors into a single string
  if (errors.isNotEmpty) {
    return errors.join(' ');
  }

  return null; // No errors
}

String? validaterytypepassword(String? value) {
  if (value == null || value.isEmpty) {
    return 're type password required';
  }

  List<String> errors = [];

  // Check for at least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    errors.add('Password must contain at least one lowercase letter.');
  }

  // Check for at least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    errors.add('Password must contain at least one uppercase letter.');
  }

  // Check for at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    errors.add('Password must contain at least one special character.');
  }

  // Combine all errors into a single string
  if (errors.isNotEmpty) {
    return errors.join(' ');
  }

  return null; // No errors
}

String? validateotp(String? value) {
  if (value == null || value.isEmpty) {
    return 'Otp required';
  }

  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}

String? validateConnectorid(String? value) {
  if (value == null || value.isEmpty) {
    return 'Connector Id required';
  }

  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}
String? enterserialnumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter serial number';
  }

  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}


String? validateamount(String? value, String pendingAmountStr) {
  if (value == null || value.trim().isEmpty) {
    return null; // No validation for empty input
  }

  final enteredAmount = double.tryParse(value.trim());
  final pendingAmount = double.tryParse(pendingAmountStr);

  // Skip validation if parsing fails
  if (enteredAmount == null || pendingAmount == null) {
    return null;
  }

  if (enteredAmount > pendingAmount) {
    final formattedPending = pendingAmount % 1 == 0
        ? pendingAmount.toInt().toString()
        : pendingAmount.toString();
    return 'Amount cannot exceed $formattedPending';
  }

  return null;
}




double totalAmountreceived = 900; // Example total amount; this should be dynamic in your actual case

String? validatedropAmount(String? value, String pendingAmountStr, String receivedAmountStr) {
  if (value == null || value.trim().isEmpty) {
    return null; // No validation for empty input
  }

  final enteredAmount = double.tryParse(value.trim());
  final pendingAmount = double.tryParse(pendingAmountStr);
  final receivedAmount = double.tryParse(receivedAmountStr);

  // Skip validation if parsing fails
  if (enteredAmount == null || pendingAmount == null || receivedAmount == null) {
    return null;
  }

  final allowableAmount = pendingAmount - receivedAmount;

  if (enteredAmount > allowableAmount) {
    final formattedAllowable = allowableAmount % 1 == 0
        ? allowableAmount.toInt().toString()
        : allowableAmount.toString();

    return 'Amount cannot exceed $formattedAllowable';
  }

  return null;
}


String? timerequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'time required';
  }

  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}

String? enteramount(String? value) {
  if (value == null || value.isEmpty) {
    return 'amount required';
  }

  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}

String? validaterepeatPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Confirm password required';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  // if (value.length < 8) {
  //   return 'Password must be at least 8 characters long';
  // }

  return null;
}

String? validatename(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name required';
  }

  return null;
}

String? validateusername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username required';
  }

  return null;
}

String? validatedob(String? value) {
  if (value == null || value.isEmpty) {
    return 'date of birth required';
  }

  return null;
}

String? validatecountry(String? value) {
  if (value == null || value.isEmpty) {
    return 'country required';
  }

  return null;
}

String? validatecity(String? value) {
  if (value == null || value.isEmpty) {
    return 'city required';
  }

  return null;
}

String? validatestate(String? value) {
  if (value == null || value.isEmpty) {
    return 'state required';
  }

  return null;
}

String? validateaddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'address required';
  }

  return null;
}

String? validatepostalcode(String? value) {
  if (value == null || value.isEmpty) {
    return 'postalcode required';
  }

  return null;
}

String? validatephonenumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'phonenumber required';
  }

  return null;
}

String? validatetitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'title required';
  }

  return null;
}

String? validatedescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'description required';
  }

  return null;
}
