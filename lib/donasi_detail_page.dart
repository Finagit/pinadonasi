import 'package:flutter/material.dart';

class DonationDetailPage extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;
  final int amount;
  final String paymentMethod;

  const DonationDetailPage({
    super.key,
    required this.name,
    required this.location,
    required this.imagePath,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Donasi'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 180, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Lokasi: $location'),
            const SizedBox(height: 12),
            Text('Nominal Donasi: Rp $amount'),
            Text('Metode Pembayaran: $paymentMethod'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman sukses atau aksi transfer dummy
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Donasi Berhasil"),
                      content: Text("Terima kasih telah berdonasi ke $name!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Konfirmasi Donasi"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
