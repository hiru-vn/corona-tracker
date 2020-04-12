class NotificationJson {
  int notificationId;
  String title;
  String description;
  int hour;
  int minute;

  NotificationJson(this.title, this.description, this.hour, this.minute);

  NotificationJson.fromJson(Map<String, dynamic> json) {
    notificationId = json['id'];
    title = json['title'];
    description = json['description'];
    hour = json['hour'];
    minute = json['minute'];
  }
}
