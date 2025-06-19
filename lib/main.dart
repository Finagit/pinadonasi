import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'donation_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); // Inisialisasi notifikasi
  runApp(const DonasiApp());
}

class DonasiApp extends StatelessWidget {
  const DonasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donasi & Sedekah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Auto navigate to HomePage after 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
            child: child,
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
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donasi & Sedekah'),
         style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4,
        foregroundColor: Colors.black54
      ),
      body: ListView.builder(
        itemCount: lembagaList.length,
        itemBuilder: (context, index) {
          final lembaga = lembagaList[index];
          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(     // ⬅️ Gunakan asset lokal
                    lembaga['image']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lembaga['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Lokasi: ${lembaga['location']}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                          onPressed: () {
                            showNotification();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DonationPage(name: lembaga['name']!),
                              ),
                            );
                          },
                        child: const Text('Donasi Sekarang'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// Fungsi untuk menampilkan notifikasi lokal
Future<void> showNotification() async {
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

// Kelas untuk inisialisasi notifikasi
class NotificationService {
  Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }
}
