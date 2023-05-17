class Notification {
  final String title;
  final String message;

  Notification({required this.title, required this.message});
}

List<Notification> notifications = [
  Notification(title: "Bildirim 1", message: "Bildirim 1 içeriği"),
  Notification(title: "Bildirim 2", message: "Bildirim 2 içeriği"),
  // Diğer bildirimler...
];
