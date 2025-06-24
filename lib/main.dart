import 'package:flutter/material.dart';
import 'cover_page.dart'; // pastikan file ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donasi App',
      debugShowCheckedModeBanner: false,
      home: const CoverPage(), // mulai dari CoverPage
    );
  }
}
