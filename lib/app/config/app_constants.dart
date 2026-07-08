class FirestoreCollections {
  FirestoreCollections._();

  static const String users = 'users';
  static const String bloodRequests = 'blood_requests';
  static const String donations = 'donations';
  static const String hospitals = 'hospitals';
  static const String bloodBanks = 'blood_banks';
  static const String favorites = 'favorites';
  static const String notifications = 'notifications';
  static const String reports = 'reports';
  static const String announcements = 'announcements';
}

class AppConstants {
  AppConstants._();

  static const List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  static const List<String> genders = ['Male', 'Female', 'Other'];

  static const List<String> hospitalTypes = [
    'Hospital',
    'Blood Bank',
    'Clinic',
  ];

  static const List<String> reportReasons = [
    'Fake donor profile',
    'Inappropriate behaviour',
    'Spam or scam request',
    'Wrong information',
    'Other',
  ];

  static const int donationCooldownDays = 90;
  static const double defaultSearchRadiusKm = 10;
  static const double maxSearchRadiusKm = 50;
}
