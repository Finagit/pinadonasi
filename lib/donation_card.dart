import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final String name;
  final String location;
  final String imagePath;
  final VoidCallback onDonate;

  const DonationCard({
    super.key,
    required this.name,
    required this.location,
    required this.imagePath,
    required this.onDonate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              imagePath,
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("Lokasi: $location", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onDonate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Donasi Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
