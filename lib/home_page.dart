import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'donation_page.dart'; agar bisa akses NotificationService

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> lembagaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLembaga();
  }

  Future<void> fetchLembaga() async {
    final response = await http.get(
      Uri.parse('https://mocki.io/v1/a13a6f01-becd-4b57-86b9-f9e68880c65b'), // ganti ke URL API kamu
        );
        if (response.statusCode == 200) {
        setState(() {
            lembagaList = json.decode(response.body);
            isLoading = false;
        });
        } else {
        setState(() {
            isLoading = false;
        });
        throw Exception('Gagal memuat data lembaga');
        }
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
        elevation: 4,
        foregroundColor: Colors.black54,
      ),
      backgroundColor: const Color(0xFFF2F3F7),
      body: isLoading
           ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lembagaList.length,
              itemBuilder: (context, index) {
                final lembaga = lembagaList[index];
                return Card(
                 margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                     elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          lembaga['image'],
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
                              lembaga['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Lokasi: ${lembaga['location']}',
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
                                    builder: (_) => DonationPage(name: lembaga['name']),
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
