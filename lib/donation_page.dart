import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DonationPage extends StatefulWidget {
  final String name;
  final String danaNumber;
  final String bankAccount;
  final String transferImage;

  const DonationPage({
    super.key,
    required this.name,
    required this.danaNumber,
    required this.bankAccount,
    required this.transferImage,
  });

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController paymentNumberController = TextEditingController();

  String? selectedMethod;
  bool showPaymentInput = false;

  final List<String> paymentMethods = [
    'Transfer Bank',
    'E-Wallet',
    'DANA',
  ];

  void _handleDonation() {
    if (amountController.text.isEmpty || selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi nominal dan pilih metode")),
      );
      return;
    }

    setState(() {
      showPaymentInput = true;
    });
  }

  Future<void> saveDonationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('donation_history') ?? [];

    final newEntry = jsonEncode({
      'name': widget.name,
      'amount': amountController.text,
      'method': selectedMethod,
      'date': DateTime.now().toIso8601String(),
    });

    history.add(newEntry);
    await prefs.setStringList('donation_history', history);
  }

  void _confirmDonation() async {
    if (paymentNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi nomor pembayaran")),
      );
      return;
    }

    await saveDonationHistory();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Donasi Berhasil 🎉"),
        content: const Text("Selamat, Anda telah berhasil berdonasi."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // kembali ke HomePage
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donasi ke ${widget.name}"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nominal Donasi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Metode Pembayaran",
                border: OutlineInputBorder(),
              ),
              value: selectedMethod,
              items: paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("Kirim Donasi"),
              onPressed: _handleDonation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 20),

            if (showPaymentInput) ...[
              TextField(
                controller: paymentNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan Nomor ${selectedMethod ?? ''}",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text("Konfirmasi Donasi"),
                onPressed: _confirmDonation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),

              Text("Detail Pembayaran:", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text("Nomor DANA: ${widget.danaNumber}"),
              Text("No. Rekening: ${widget.bankAccount}"),
            ],
          ],
        ),
      ),
    );
  }
}
