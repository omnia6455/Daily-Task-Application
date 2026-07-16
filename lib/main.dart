import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:agenda/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'Task.dart';
late final SharedPreferences prefs;
late Database database;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  ));
  prefs = await SharedPreferences.getInstance();
database = await openDatabase(
  'database.db',
  version: 1,
  onCreate: (db, version) {
    db.execute(
        'CREATE TABLE task(id INTEGER,task TEXT, title TEXT, time TEXT, date TEXT,save INTEGER,fav INTEGER ,PRIMARY KEY("id"))');
  },
);
  flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid=const AndroidInitializationSettings('@mipmap/ic_launcher');
  InitializationSettings initializationSettings=InitializationSettings(
      android:initializationSettingsAndroid
  );
  const AndroidNotificationChannel channel=AndroidNotificationChannel('notificationChannelID','Agenda Channel',importance:Importance.max , playSound: true);
  await
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response )async{});

  await initializeService();
  startBackgroundService();
  runApp(const MyApp());
}

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}


Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );
}

  @pragma('vm:entry-point')
  void onStart(ServiceInstance service) async {
  final database  = await openDatabase(
    'database.db',
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE task(id INTEGER,task TEXT, title TEXT, time TEXT, date TEXT,save INTEGER,fav INTEGER ,PRIMARY KEY("id"))');
      },
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid=const AndroidInitializationSettings('@mipmap/ic_launcher');
  InitializationSettings initializationSettings=InitializationSettings(
      android:initializationSettingsAndroid
  );
  const AndroidNotificationChannel channel=AndroidNotificationChannel('notificationChannelID','Agenda Channel',importance:Importance.max , playSound: true);
  await
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response )async{});
    Timer.periodic(const Duration(seconds: 10), (timer) async{
      await prefs.reload();
      if(prefs.getBool('notification') ?? await Permission.notification.status.isGranted) {
        List<Task> tasks = (await database.query('task')).map(
              (e) {
            return Task(
                id: e['id'] as int,
                quests: (List<Map<String, dynamic>>.from(
                    json.decode(e['task'] as String) as List<dynamic>))
                    .map(
                      (e) => Quest.fromMap(e),
                )
                    .toList(),
                title: e['title'] as String,
                time: e['time'] as String,
                date: DateTime.parse(e['date'] as String),
                save: e['save'] as int == 1 ? true : false,
                fav: e['fav'] as int == 1 ? true : false);
          },
        ).toList();
        List<Task> approachingTasks=tasks.where((element) {
          String period = element.time.split(' ')[1];
          int hour = int.parse(element.time.split(':')[0]) +
              (period == 'PM' ? 12 : 0);
          int minute = int.parse(element.time.split(':')[1].split(' ')[0]);
          DateTime taskDate = DateTime(
              element.date.year, element.date.month, element.date.day, hour,
              minute);
          int diff = taskDate.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
          return diff < const Duration(hours: 1).inMilliseconds ;
        }).toList();
        List<Task> expiredTasks=tasks.where((element) {
          String period = element.time.split(' ')[1];
          int hour = int.parse(element.time.split(':')[0]) +
              (period == 'PM' ? 12 : 0);
          int minute = int.parse(element.time.split(':')[1].split(' ')[0]);
          DateTime taskDate = DateTime(
              element.date.year, element.date.month, element.date.day, hour,
              minute);
          int diff = taskDate.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
          return diff <=0 ;
        }).toList();
        List<String> ids = prefs.getStringList('approaching_tasks') ?? [];
        for (Task task in approachingTasks) {
          if (!ids.contains(task.id.toString())) {
            ids.add(task.id.toString());
            prefs.setStringList('approaching_tasks', ids);
            await flutterLocalNotificationsPlugin.show(
              Random().nextInt(5000),
              'HEADS UP!',
              'Task (${task.title}) is approaching to be ended ',
              const NotificationDetails(
                android: AndroidNotificationDetails(
                    'notificationChannelID',
                    'Agenda Channel',
                    importance: Importance.max,
                    playSound: true,
                    priority: Priority.high
                ),
              ),
            );
          }
        }
        List<String> id = prefs.getStringList('expired_tasks') ?? [];
        for (Task task in expiredTasks) {
          if (!id.contains(task.id.toString())) {
            id.add(task.id.toString());
            prefs.setStringList('expired_tasks', id);
            await flutterLocalNotificationsPlugin.show(
              Random().nextInt(5000),
              'FINALLY!',
              'Task (${task.title}) has expired',
              const NotificationDetails(
                android: AndroidNotificationDetails(
                    'notificationChannelID',
                    'Agenda Channel',
                    importance: Importance.max,
                    priority: Priority.high
                ),
              ),
            );
          }
        }
      }
    });
  }
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
              primaryColor:const Color(0xFFff9f74),
    textSelectionTheme:  TextSelectionThemeData(
    cursorColor: const Color(0xffda7286),
    selectionColor:  const Color(0xffda7286).withOpacity(.2),
    selectionHandleColor:  const Color(0xffda7286),
    ),
    ),
    );
  }
}
