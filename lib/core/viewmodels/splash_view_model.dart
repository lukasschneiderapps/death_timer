import 'package:death_timer/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  LocalStorageService _localStorageService;

  SplashViewModel({@required LocalStorageService localStorageService})
      : assert(localStorageService != null),
        this._localStorageService = localStorageService;

  Future<bool> isDataSet() async {
    DateTime dateOfBirth = await _localStorageService.getDateOfBirth();
    return dateOfBirth != null;
  }

}
