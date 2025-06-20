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
        title: const Text('Donasi & Sedekah'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: isLoading
           ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                        builder: (_) =>
                            DonationPage(name: lembaga['name']!),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
