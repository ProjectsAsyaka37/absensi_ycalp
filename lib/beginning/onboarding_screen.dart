import 'package:absensi_ycalp/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController _controller = OnboardingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required String imagePath,
    required String title,
    required String description,
    bool showBack = false,
    bool showNext = false,
    bool showSkip = true,
  }) {
    return Stack(
      children: [
        if (showSkip)
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: () => _controller.skip(context),
              child: Text("Skip", style: TextStyle(color: Colors.deepPurple)),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Image.asset(imagePath, height: 220),
            SizedBox(height: 32),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            buildPageIndicator(),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showBack
                      ? ElevatedButton(
                        onPressed: () {
                          _controller.prevPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : SizedBox(width: 80),
                  showNext
                      ? ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(context, () => setState(() {}));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : SizedBox(width: 80),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _controller.currentPage == index ? 12 : 8,
          height: _controller.currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _controller.currentPage == index
                    ? Colors.deepPurple
                    : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged:
            (index) => _controller.onPageChanged(index, () => setState(() {})),
        children: [
          buildPage(
            imagePath: 'assets/onboard1.png',
            title: "Hi Kawan YCALP",
            description: "Selamat datang di aplikasi absensi para kawan YCALP.",
            showBack: false,
            showNext: true,
            showSkip: true,
          ),
          buildPage(
            imagePath: 'assets/onboard2.png',
            title: "Absen Jadi Gampang",
            description:
                "Catat kehadiranmu dengan mudah dan cepat. Tak perlu ribet, cukup satu klik untuk absen!",
            showBack: true,
            showNext: true,
            showSkip: true,
          ),
          buildPage(
            imagePath: 'assets/onboard3.png',
            title: "Bersama, Kita Hadir",
            description:
                "Bersama kita hadir, bersama kita peduli. Ayo jadi bagian dari semangat Kawan YCALP!",
            showBack: true,
            showNext: true,
            showSkip: false,
          ),
        ],
      ),
    );
  }
}
