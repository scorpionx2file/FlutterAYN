// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Traveller';

  @override
  String get next => 'Next';

  @override
  String get chooseGatesTitle => 'Choose Your Favorite Gates';

  @override
  String get chooseGatesSubtitle => 'Pick at least 3 gates to tailor your experience.';

  @override
  String get chooseGatesMin3Snack => 'Please select at least 3 gates.';
}
