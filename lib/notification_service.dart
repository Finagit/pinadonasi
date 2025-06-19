Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'donasi_channel', // ID channel
    'Donasi Channel', // Nama channel
    channelDescription: 'Channel untuk notifikasi pengingat donasi',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Ayo Berdonasi Hari Ini!',
    'Klik untuk menyalurkan kebaikanmu.',
    platformChannelSpecifics,
  );
}
