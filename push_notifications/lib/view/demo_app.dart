import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:push_notifications/view/notification_badge.dart';
import 'package:push_notifications/model/push_notification.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('handling message ${message.messageId}');
}

class NotificationDemoApp extends StatelessWidget {
  const NotificationDemoApp({super.key});

  @override
  Widget build(Object context) {
    return OverlaySupport.global(
        child: MaterialApp(
            title: 'Demo voor notificaties',
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            home: const MainPage()));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    requestAndRegisterNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });

    _totalNotifications = 0;
    super.initState();
  }

  void requestAndRegisterNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    await _messaging.getAPNSToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('authorized');
      String? token = await _messaging.getToken();
      // we krijgen een token van de server (van Firebase)
      // normaliter zou je deze ergens opslaan (terugsturen naar onze
      // eigen server, bijvoorbeeld), maar voor nu printen we hem gewoon
      // even uit.
      print('received token $token');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _totalNotifications++;
          _notificationInfo = notification;
        });
        if (_notificationInfo != null) {
          showSimpleNotification(
            Text(_notificationInfo!.title ?? ''),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body ?? ''),
            background: Colors.cyan.shade700,
            // we tonen de notificatie wat lang, voor demonstratie-doeleinden
            duration: const Duration(seconds: 4),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificatie-demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              // die Container is alleen voor die EdgeInsets hieronder
              margin: const EdgeInsets.all(24),
              child: const Text(
                'App voor het tonen van notificaties (iOS only)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )),
          const SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          const SizedBox(height: 16.0),
          _getNotificationMessage()
        ],
      ),
    );
  }

  Widget _getNotificationMessage() {
    return _notificationInfo != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'titel: ${_notificationInfo!.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'payload: ${_notificationInfo!.body}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          )
        : Container();
  }
}
