import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io' as io;

class NotificationPlugin {
  //
//!=================================< SERVICE >=================================

  Future<void> sendNotification({
    //
//*==========================< SIMPLE NOTIFICATION >=======================*//
    int id = 0,
    String? title,
    String? body,
    String? payload,
    String? image,
    String? icon,
    int? timeout,
    Color? color,
    String? ticker,
    String? subText,
    bool playSound = true,
    fullScreenIntent = true,
    bool enableLights = true,
    bool enableVibrate = true,
    Priority priority = Priority.max,
    Importance importance = Importance.max,
  }) async {
    String? _image;
    String? _icon;
    if (image != null) {
      _image = image;
      if (icon != null) _icon = icon;
    } else {}

    var iOSNotificationDetails = IOSNotificationDetails();
    var androidNotificationDetails = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      color: color,
      ticker: ticker,
      subText: subText,
      icon: 'app_icon',
      priority: priority,
      importance: importance,
      enableLights: enableLights,
      enableVibration: enableVibrate,
      fullScreenIntent: fullScreenIntent,
      styleInformation: _image == null
          ? null
          : BigPictureStyleInformation(
              FilePathAndroidBitmap(_image),
              largeIcon: _icon == null ? null : FilePathAndroidBitmap(_icon),
              contentTitle: title,
              hideExpandedLargeIcon: false,
            ),
    );
    var platformChannelSpecific = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecific, payload: payload);
  }

//!=================================< CANCEL NOTFIFICATIONS >=================================
//
  cancelAllNotifications() async =>
      await flutterLocalNotificationsPlugin.cancelAll();

  cancelNotification(int notificationID) async =>
      await flutterLocalNotificationsPlugin.cancel(notificationID);

//!=================================< PLUGIN >=================================
//
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  late InitializationSettings initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (io.Platform.isIOS)
      await _requestIOSPermissions();
    else {}
    _inititalizePlatformSpecific();
  }

  _inititalizePlatformSpecific() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationSubject.add(receivedNotification);
      },
    );

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  _requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  setListenerForLowerVersion(Function onNotificationLowerVersion) {
    didReceiveLocalNotificationSubject.listen((receivedNotification) =>
        onNotificationLowerVersion(receivedNotification));
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async =>
            await onNotificationClick(payload));
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final String? imageUrl;

  ReceivedNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
    this.imageUrl,
  });
}
