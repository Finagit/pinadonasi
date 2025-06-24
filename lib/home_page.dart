import 'package:flutter/material.dart';
import 'donation_page.dart';
import 'donation_history_page.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> lembagaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLembaga();
  }

  void fetchLembaga() async {
    final data = await ApiService.fetchLembagaList();
    setState(() {
      lembagaList = data;
      isLoading = false;
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "Riwayat Donasi",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DonationHistoryPage()),
              );
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.asset(
                          image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DonationPage(
                                      name: name,
                                      danaNumber: lembaga['dana_number'],
                                      bankAccount: lembaga['bank_account'],
                                      transferImage:
                                          lembaga['transfer_image'],
                                    ),
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
