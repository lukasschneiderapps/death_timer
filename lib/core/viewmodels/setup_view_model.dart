import 'package:death_timer/core/services/local_storage_service.dart';
import 'package:death_timer/utils/input_validator.dart';
import 'package:flutter/material.dart';

class SetupViewModel extends ChangeNotifier {
  LocalStorageService _localStorageService;

  DateTime selectedDateOfBirth;

  SetupViewModel({@required LocalStorageService localStorageService})
      : assert(localStorageService != null),
        this._localStorageService = localStorageService;

  Future saveDataToPreferences(DateTime dateOfBirth, int estimatedAge) async {
    _localStorageService.saveDataToPreferences(dateOfBirth, estimatedAge);
  }

  bool isInputValid(String ageText) {
    return selectedDateOfBirth != null &&
        InputValidator.isAgeInputValid(ageText);
  }

}
