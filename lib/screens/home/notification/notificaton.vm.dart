import 'package:gate_pass/screens/base-vm.dart';
import 'package:intl/intl.dart';

class NotificationViewModel extends BaseViewModel{

  NotificationViewModel(){
    grouped = groupByDate(notifications);
  }

  Map<String, List<NotificationModel>> grouped = {};

  // Group notifications by date (e.g. "Fri 27th May, 2020")
  Map<String, List<NotificationModel>> groupByDate(List<NotificationModel> notifications) {
    Map<String, List<NotificationModel>> grouped = {};
    for (var notification in notifications) {
      final key = DateFormat('EEE d\'th\' MMM, y').format(notification.createdAt);
      grouped.putIfAbsent(key, () => []).add(notification);
    }
    return grouped;
  }

// Format relative time (e.g. 1hr ago, 3hr ago)
  String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    return '${difference.inHours}hr ago';
  }



  List<NotificationModel> notifications = [
    NotificationModel(
      message: "You’ve been accepted into the Lekki Phase 1, as a residence of this community.",
      topic: "Join Community",
      createdAt: DateTime(2025, 04, DateTime.now().day, 20, 38),
      isUrgent: true
    ),
    NotificationModel(
      message: "Temidayo Ubah, has been passed at the entrance to pay you a visit.",
      topic: "New Visitor",
      createdAt: DateTime(2025, 04, DateTime.now().day, 19, 20),
      isUrgent: true
    ),
    NotificationModel(
      message: "Hello Victoria, this is to inform you about the new development in the lekki phase 1 community, the security uniform has been changed to blue.",
      topic: "Community Admin",
      createdAt: DateTime(2025, 04, DateTime.now().day, 15, 57),
      isUrgent: false
    ),
    NotificationModel(
      message: "You’ve been accepted into the Lekki Phase 1, as a residence of this community.",
      topic: "Join Community",
      createdAt: DateTime(2025, 04, DateTime.now().day-1, 20, 38),
      isUrgent: true
    ),
    NotificationModel(
      message: "Temidayo Ubah, has been passed at the entrance to pay you a visit.",
      topic: "New Visitor",
      createdAt: DateTime(2025, 04, DateTime.now().day-1, 19, 20),
      isUrgent: true
    ),
    NotificationModel(
      message: "Hello Victoria, this is to inform you about the new development in the lekki phase 1 community, the security uniform has been changed to blue.",
      topic: "Community Admin",
      createdAt: DateTime(2025, 04, DateTime.now().day-1, 15, 57),
      isUrgent: false
    ),

  ];

}

class NotificationModel {
  DateTime createdAt;
  String topic;
  String message;
  bool isUrgent;

  NotificationModel({
    required this.message,
    required this.topic,
    required this.createdAt,
    required this.isUrgent,
  });
}