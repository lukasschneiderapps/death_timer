import 'package:death_timer/core/services/local_storage_service.dart';
import 'package:death_timer/utils/date_utils.dart';
import 'package:death_timer/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

class MainViewModel extends ChangeNotifier {
  Time timeLeftToLive;
  Instant dateOfBirth;
  Instant dateOfDeath;
  int livedPercentage;

  LocalStorageService _localStorageService;

  MainViewModel({@required LocalStorageService localStorageService})
      : assert(localStorageService != null),
        this._localStorageService = localStorageService;

  startRebuildingLoop() {
    Future.delayed(Duration(seconds: 1), () async {
      // Do calculations and update data
      DateTime dateOfBirthDateTime =
          await _localStorageService.getDateOfBirth();
      int estimatedAge = await _localStorageService.getEstimatedAge();
      Time lifeTime =
          DateUtils.calculateLifeTime(dateOfBirthDateTime, estimatedAge);

      dateOfBirth = Instant.dateTime(dateOfBirthDateTime);
      timeLeftToLive =
          DateUtils.calculateTimeLeftToLive(dateOfBirthDateTime, estimatedAge);
      dateOfDeath = DateUtils.calculateDateOfDeath(timeLeftToLive);
      livedPercentage =
          DateUtils.calculateLivedPercentage(timeLeftToLive, lifeTime);

      // Update UI
      notifyListeners();

      // Continue looping
      startRebuildingLoop();
    });
  }
}
