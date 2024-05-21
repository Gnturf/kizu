enum PasswordCheck {
  missing8Character,
  missingAtleastOneUppercase,
  missingLowercase,
  missingASymbol,
  missingANumber,
  hasAll
}

PasswordCheck passwordCheck(String password) {
  // Check if the password has at least 8 characters
  if (password.length < 8) {
    return PasswordCheck.missing8Character;
  }

  // Check if the password has at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return PasswordCheck.missingAtleastOneUppercase;
  }

  // Check if the password has at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    return PasswordCheck.missingLowercase;
  }

  // Check if the password has at least one symbol
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return PasswordCheck.missingASymbol;
  }

  // Check if the password has at least one number
  if (!password.contains(RegExp(r'[0-9]'))) {
    return PasswordCheck.missingANumber;
  }

  // If all conditions are met, return true
  return PasswordCheck.hasAll;
}
