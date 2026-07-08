class NotificationModel {
  final String? id;
  final String? title;
  final String? body;
  final String? type;
  final bool read;
  final String? userId;
  final Map<String, dynamic>? data;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.read = false,
    this.userId,
    this.data,
    this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String?,
      title: map['title'] as String?,
      body: map['body'] as String?,
      type: map['type'] as String?,
      read: map['read'] as bool? ?? false,
      userId: map['userId'] as String?,
      data: (map['data'] as Map?)?.cast<String, dynamic>(),
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'read': read,
      'userId': userId,
      'data': data,
      'createdAt': createdAt,
    };
  }
}
