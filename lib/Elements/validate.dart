validateField(String value) {
  if (value == null || value.isEmpty)
    return 'Field is Required.';
  // else if (value.length > 5)
  //   return 'Field required at most 5 character';
  // else if (value.length > 60)
  //   return 'Field required at most 60 character';
  else
    return null;
}

validateEmail(String value) {
  bool validEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (value.isEmpty)
    return 'Email is Required.';
  else if (!value.contains('@'))
     return 'Enter Valid Email.'; 
  else
    return null;
}

validateMobile(String value) {
  if (value.isEmpty)
    return 'Mobile Number is Required.';
  else if (value.length < 10)
    return 'Mobile Number required at least 10 numbers';
  else if (value.length > 11)
    return 'Mobile Number required 10 numbers';
  else
    return null;
}

validateOTP(String value) {
  if (value.isEmpty)
    return 'OTP is Required.';
  else if (value.length < 4)
    return 'OTP required at least 4 numbers';
  else if (value.length > 4)
    return 'OTP required at most 4 numbers';
  else
    return null;
}
