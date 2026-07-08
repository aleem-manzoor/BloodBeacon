class AnnouncementModel {
  final String? id;
  final String? title;
  final String? message;
  final String? type;
  final String? createdBy;
  final String? createdAt;

  AnnouncementModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.createdBy,
    this.createdAt,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      id: map['id'] as String?,
      title: map['title'] as String?,
      message: map['message'] as String?,
      type: map['type'] as String?,
      createdBy: map['createdBy'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'message': message,
      'type': type,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
