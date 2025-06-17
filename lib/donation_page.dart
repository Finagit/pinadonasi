import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  final String name;

  const DonationPage({super.key, required this.name});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nominalController = TextEditingController();
  String? _metodePembayaran;

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  void _submitDonasi() {
    if (_formKey.currentState!.validate() && _metodePembayaran != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Donasi Berhasil"),
          content: Text("Terima kasih telah berdonasi ke ${widget.name}!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donasi ke ${widget.name}"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Nominal Donasi",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Masukkan nominal" : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Metode Pembayaran",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Transfer Bank",
                    child: Text("Transfer Bank"),
                  ),
                  DropdownMenuItem(
                    value: "E-Wallet",
                    child: Text("E-Wallet"),
                  ),
                  DropdownMenuItem(
                    value: "QRIS",
                    child: Text("QRIS"),
                  ),
                ],
                onChanged: (value) => setState(() => _metodePembayaran = value),
                validator: (value) =>
                    value == null ? "Pilih metode pembayaran" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitDonasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Kirim Donasi"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
