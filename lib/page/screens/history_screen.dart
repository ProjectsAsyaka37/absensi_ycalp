import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final String token;
  const HistoryScreen({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Absen")),
      body: Center(child: Text("Token: $token")),
    );
  }
}
