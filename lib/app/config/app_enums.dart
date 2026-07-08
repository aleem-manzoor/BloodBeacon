enum UserRole { user, admin }

enum AvailabilityStatus { available, unavailable }

enum RequestStatus { pending, accepted, completed, cancelled }

enum ModerationStatus { pending, approved, rejected }

enum ReportStatus { pending, reviewed, ignored, actioned }

enum PlaceType { hospital, bloodBank }

enum AppNotificationType { emergency, accepted, reminder, alert, announcement }

T enumFromString<T>(List<T> values, String? value, T fallback) {
  if (value == null) return fallback;
  for (final v in values) {
    if (v.toString().split('.').last == value) return v;
  }
  return fallback;
}

extension EnumName on Enum {
  String get value => toString().split('.').last;
}
