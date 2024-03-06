import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

//ignore:depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

//ignore:depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app/domain/models/items_model/item_model.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
  }

  showBasicNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        '2',
        'basic notification',
        importance: Importance.max,
        priority: Priority.high,
       playSound: true,
       onlyAlertOnce: true,
       sound: RawResourceAndroidNotificationSound("notification"),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      0, 'Basic Notification', 'body', details,
      // payload: "Payload Data"
    );
  }

  showPreodicNotification() async {
    flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      'Titile1',
      'Body 1',
      RepeatInterval.everyMinute,
      androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      const NotificationDetails(
          android: AndroidNotificationDetails('2', 'basic notification',
              playSound: true,
              priority: Priority.high,
              ticker: 'ticker',
              importance: Importance.max)),
    );
  }

  showScheduledTime(DateTime dateTime,ItemModel itemModel) async {
    print('itemmodel ${itemModel.startDate}, ${itemModel.alert}');
    final DateFormat format=DateFormat("yyyy-MM-dd HH:mm:ss");

    final DateTime dateTime1=format.parse('${itemModel.startDate!} ${itemModel.alert!}');
    flutterLocalNotificationsPlugin.zonedSchedule(
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        itemModel.id,
        'zone title',
        itemModel.context,
        tz.TZDateTime.from(
            DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              dateTime.hour,
              dateTime.minute,
              0,
            ),
            tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails('2', 'basic notification',
                playSound: true,
                priority: Priority.high,
                ticker: 'ticker',
                importance: Importance.max)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  cancelIdNotific(int id)async{
    await flutterLocalNotificationsPlugin.cancel(id);

  }
}
