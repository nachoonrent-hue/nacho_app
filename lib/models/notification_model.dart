class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final bool isRead;
  final String type; // booking, payment, checkin, review, event
  final String? targetId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    this.isRead = false,
    required this.type,
    this.targetId,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      timeAgo: timeAgo,
      isRead: isRead ?? this.isRead,
      type: type,
      targetId: targetId,
    );
  }
}
