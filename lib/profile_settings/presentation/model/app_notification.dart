class AppNotification {
  final String time;
  final String title;
  final String body;
  final bool unread;

  const AppNotification({
    required this.time,
    required this.title,
    required this.body,
    required this.unread,
  });
}