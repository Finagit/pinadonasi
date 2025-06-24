import 'package:flutter/material.dart';
import 'donation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> lembagaList = [
    {
      'name': 'Masjid Al-Huda',
      'location': 'Pamekasan',
      'image': 'assets/images/masjid_alhuda.jpg'
    },
    {
      'name': 'Masjid Al-falah',
      'location': 'Sidoarjo',
      'image': 'assets/images/masjid_al_falah.jpg'
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
      'name': 'Yayasan anak yatim ',
      'location': 'surabaya ',
      'image': 'assets/images/yayasan_yatim.jpg'
    },
     {
      'name': 'Panti Asuhan Al-Falah',
      'location': 'Bangkalan',
      'image': 'assets/images/panti_asuhan_alfalah.jpg'
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        elevation: 4,
        foregroundColor: Colors.black54,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lembagaList.length,
            itemBuilder: (context, index) {
              final lembaga = lembagaList[index];
              final image = lembaga['image'] ?? '';
              final name = lembaga['name'] ?? '';
              final location = lembaga['location'] ?? '';

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                          height: 180,
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Lokasi: $location',
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DonationPage(name: name),
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
        ],
      ),
    );
  }
}
