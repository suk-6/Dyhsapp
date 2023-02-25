import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dyhsapp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _configureLocalNotifications();
    _configureFirebaseListeners();
  }

  // 로컬 알림 초기화
  void _configureLocalNotifications() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Firebase 이벤트 리스너 초기화
  void _configureFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 앱이 foreground 상태에서 푸시 알림을 수신하는 경우
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // 앱이 background 또는 terminated 상태에서 푸시 알림을 클릭하는 경우
      _navigateToScreen(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // 백그라운드에서 FCM 메시지 처리
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // 앱이 background 또는 terminated 상태에서 푸시 알림을 수신하는 경우
    _showNotification(message);
  }

  // 로컬 알림 표시
  void _showNotification(RemoteMessage message) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'default_channel_id',
        'Default Channel',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['data'],
    );
  }

  // 화면 이동 처리
  void _navigateToScreen(RemoteMessage message) {
    // TODO: 알림 클릭 시 이동할 화면 구현
  }

  final _valueList = [
    '1-1',
    '1-2',
    '1-3',
    '1-4',
    '1-5',
    '1-6',
    '1-7',
    '1-8',
    '1-9',
    '1-10',
    '2-1',
    '2-2',
    '2-3',
    '2-4',
    '2-5',
    '2-6',
    '2-7',
    '2-8',
    '2-9',
    '2-10',
    '3-1',
    '3-2',
    '3-3',
    '3-4',
    '3-5',
    '3-6',
    '3-7',
    '3-8',
    '3-9',
    '3-10'
  ];
  var _selectedValue = '1-1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('덕영고등학교 시간표 알리미'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: _valueList.map((value) {
                return CheckboxListTile(
                  title: Text(value),
                  value: _selectedValue == value,
                  onChanged: (isChecked) async {
                    if (isChecked != null) {
                      await FirebaseMessaging.instance
                          .unsubscribeFromTopic(_selectedValue);
                      setState(() {
                        _selectedValue = value;
                      });
                      await FirebaseMessaging.instance
                          .subscribeToTopic(_selectedValue);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
