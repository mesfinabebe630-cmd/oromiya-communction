import 'package:flutter/material.dart';
import 'package:oromiya_communication/screens/home_screen.dart';
import 'package:oromiya_communication/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Container(
        width: double.infinity,
        color: Colors.white, // Changed to white to match logo background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_launcher.png',
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.account_balance,
                size: 100,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
