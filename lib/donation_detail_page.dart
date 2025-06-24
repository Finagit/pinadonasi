import 'package:flutter/material.dart';

class DonationDetailPage extends StatelessWidget {
  final String name;
  final String nominal;
  final String metode;
  final String danaNumber;
  final String bankAccount;
  final String transferImage;

  const DonationDetailPage({
    super.key,
    required this.name,
    required this.nominal,
    required this.metode,
    required this.danaNumber,
    required this.bankAccount,
    required this.transferImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Donasi'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Donasi untuk: $name',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Nominal: Rp $nominal', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Metode Pembayaran: $metode', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                metode == 'DANA' ? 'No. DANA: $danaNumber' : 'No. Rekening: $bankAccount',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text('Bukti Transfer:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  transferImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check),
                  label: const Text('Selesai'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
