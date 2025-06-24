import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home_page.dart';
import 'donation_page.dart'; 
import 'donation_card.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // Inisialisasi notifikasi
  runApp(const DonasiApp());
}

 class DonasiApp extends StatelessWidget {
  const DonasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinadonasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // atau langsung HomePage()
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {// Auto navigate to HomePage after 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);
           return FadeTransition(
              opacity: curvedAnimation,
              child: ScaleTransition(
                scale:
                   Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
                child: child
              ),
            );
          },
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/cover.jpg', // Ganti sesuai nama file cover kamu
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 final List<Map<String, String>> lembagaList = const [
  {
    'name': 'Masjid Al-Huda',
    'location': 'Pamekasan',
    'image': 'assets/images/masjid_alhuda.jpg',
  },
  {
    'name': 'Yayasan Anak Yatim',
    'location': 'Surabaya',
    'image': 'assets/images/yayasan_yatim.jpg',
  },
  {
    'name': 'Masjid Al-Falah',
    'location': 'Sidoarjo',
    'image': 'assets/images/masjid_alfalah.jpg',
  },
  {
      'name': 'Yayasan Nurul Hikmah',
      'location': 'Sumenep',
      'image': 'assets/images/yayasan_nurul_hikmah.jpg'
    },
     {
      'name': 'Panti Asuhan Al-Falah',
      'location': 'Bangkalan',
      'image': 'assets/images/panti_asuhan_alfalah.jpg'
    },
    {
      'name': 'Yayasan Nurul Hikmah',
      'location': 'Sumenep',
      'image': 'assets/images/yayasan_nurul_hikmah.jpg'
    }, 
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donasi & Sedekah',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4,
        foregroundColor: Colors.black54
      ),
       backgroundColor: const Color(0xFFF2F3F7),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lembagaList.length,
        itemBuilder: (context, index) {
          final lembaga = lembagaList[index];
          return DonationCard(
            name: lembaga['name']!,
            location: lembaga['location']!,
            imagePath: lembaga['image']!,
            onDonate: () {
              NotificationService.showNotification();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DonationPage(name: lembaga['name']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationService {
  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'donasi_channel',
      'Donasi Notifikasi',
      channelDescription: 'Notifikasi untuk simulasi donasi',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ayo Berdonasi!',
      'Ingatkan kebaikan dengan sedekah hari ini 😊',
      notifDetails,
    );
  }
}
