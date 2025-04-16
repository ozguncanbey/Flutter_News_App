enum Country {
  us,
  en,
  tr,
  fr,
  es,
  it,
  de,
}

extension LanguageExtension on Country {
  String get code {
    switch (this) {
      case Country.us:
        return 'us';
      case Country.en:
        return 'en';
      case Country.tr:
        return 'tr';
      case Country.fr:
        return 'fr';
      case Country.es:
        return 'es';
      case Country.it:
        return 'it';
      case Country.de:
        return 'de';
    }
  }
}
