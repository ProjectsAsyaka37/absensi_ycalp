import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashHomeScreen extends StatefulWidget {
  const SplashHomeScreen({super.key});

  @override
  State<SplashHomeScreen> createState() => _SplashHomeScreenState();
}

class _SplashHomeScreenState extends State<SplashHomeScreen> {
  String? token;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadTokenAndUser();
  }

  Future<void> _loadTokenAndUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');
    final savedName = prefs.getString('userName'); // simpan ini waktu login

    if (savedToken != null && savedName != null) {
      setState(() {
        token = savedToken;
        userName = savedName;
      });
    } else {
      // Kalau tidak ada data, arahkan langsung ke Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token == null || userName == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Decorative Bottom Right Circles
          Positioned(
            bottom: -30,
            right: -30,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircleAvatar(radius: 60, backgroundColor: Color(0xFF3D00A0)),
                CircleAvatar(radius: 40, backgroundColor: Color(0xFF7D52F4)),
              ],
            ),
          ),
          // Decorative Top Left Circle
          Positioned(
            top: -20,
            left: -20,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircleAvatar(radius: 50, backgroundColor: Color(0xFF3D00A0)),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo_no_bg.png', height: 100),
                  const SizedBox(height: 24),
                  const Text(
                    "ABSENSI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3D00A0),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Text(
                    "ONLINE",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userName!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => HomeScreen(
                                userName: userName!,
                                token: token!,
                              ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF3D00A0),
                    ),
                    label: Text(
                      "Lanjutkan sebagai ${userName!.split(' ').first.toLowerCase()}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3D00A0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      await prefs.remove('userName');

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
