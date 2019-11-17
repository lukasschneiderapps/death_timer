class InputValidator {


  static bool isAgeInputValid(String input) {
    // Numeric
    try {
      int.parse(input);
    } catch (Exception) {
      return false;
    }

    // Positive
    if (!(int.parse(input) > 0)) return false;

    // In Range
    if (int.parse(input) > 1000) return false;

    // Valid
    return true;
  }

}