import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';
import 'package:oromiya_communication/widgets/custom_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false, // Use our custom back or home
        title: const CustomHeader(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!, width: 2),
                  borderRadius: BorderRadius.zero,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, spreadRadius: 5)
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username or Email Address *',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Password *',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (v) {}, activeColor: AppTheme.primaryBlue),
                        const Text('Remember Me'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // LOGIN - RED
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // REGISTER - BLACK
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text('REGISTER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // LOST PASSWORD - BLACK BOX
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          side: BorderSide.none,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text('LOST YOUR PASSWORD?', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}
