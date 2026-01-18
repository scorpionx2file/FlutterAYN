// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Traveller';

  @override
  String get next => 'التالي';

  @override
  String get chooseGatesTitle => 'اختر البوابات المفضلة';

  @override
  String get chooseGatesSubtitle => 'اختر 3 بوابات على الأقل لتخصيص تجربتك.';

  @override
  String get chooseGatesMin3Snack => 'من فضلك اختر 3 بوابات على الأقل.';
}
