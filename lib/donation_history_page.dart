import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DonationHistoryPage extends StatefulWidget {
  const DonationHistoryPage({super.key});

  @override
  State<DonationHistoryPage> createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
  List<Map<String, dynamic>> historyList = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('donation_history') ?? [];

    setState(() {
      historyList = history
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList()
          .reversed
          .toList(); // urut dari terbaru
    });
  }

  String formatDate(String isoString) {
    final date = DateTime.parse(isoString);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Donasi"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: historyList.isEmpty
          ? const Center(child: Text("Belum ada riwayat donasi."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.redAccent),
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nominal: Rp ${item['amount']}"),
                        Text("Metode: ${item['method']}"),
                        Text("Tanggal: ${formatDate(item['date'])}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
