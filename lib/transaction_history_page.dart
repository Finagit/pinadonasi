import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Masjid Al-Huda',
      'amount': 10000,
      'method': 'DANA',
      'date': '2025-06-24 16:27',
    },
    {
      'name': 'Yayasan Anak Yatim',
      'amount': 20000,
      'method': 'E-Wallet',
      'date': '2025-06-22 14:11',
    },
    {
      'name': 'Masjid Al-Falah',
      'amount': 15000,
      'method': 'Transfer Bank',
      'date': '2025-06-20 18:45',
    },
  ];

  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: transactions.isEmpty
          ? const Center(child: Text("Belum ada transaksi."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final trx = transactions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: Text(trx['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jumlah: Rp ${trx['amount']}"),
                        Text("Metode: ${trx['method']}"),
                        Text("Tanggal: ${trx['date']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
