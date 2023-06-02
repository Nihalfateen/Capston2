class Validator {
  String? validateEmployeeID(String value) {
    if (value.isEmpty) return 'EmployeeID is required.';
    // RegExp regex = new RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid ID.';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    RegExp regex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid Email.';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Password is required.';
    RegExp regex = RegExp(r'^.{6,}$');
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  String? validateName(String value) {
    RegExp regex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    if (!regex.hasMatch(value)) {
      return 'Please enter a name.';
    } else
      return null;
  }

  String? validateNumber(String value) {
    RegExp regex = RegExp(r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a number.';
    } else {
      return null;
    }
  }
}
