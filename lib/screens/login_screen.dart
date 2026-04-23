import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 0: Login, 1: Register, 2: Forgot Password
  int _viewMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
        title: const CustomHeader(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_viewMode != 0) {
              setState(() => _viewMode = 0);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
            ),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_viewMode) {
      case 1: return _buildRegisterForm();
      case 2: return _buildForgotForm();
      default: return _buildLoginForm();
    }
  }

  // --- LOGIN FORM ---
  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 24),
        _label('Username or Email Address *'),
        _textField(hint: 'Enter your username or email'),
        const SizedBox(height: 16),
        _label('Password *'),
        _textField(hint: 'Enter your password', obscure: true),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(value: false, onChanged: (v) {}, activeColor: AppTheme.primaryBlue),
            const Text('Remember Me', style: TextStyle(fontSize: 13)),
          ],
        ),
        const SizedBox(height: 24),
        _redButton('LOGIN', () {}),
        const SizedBox(height: 20),
        const Center(child: Text('OR', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _blackButton('REGISTER', () => setState(() => _viewMode = 1))),
            const SizedBox(width: 12),
            Expanded(child: _blackButton('FORGET', () => setState(() => _viewMode = 2))),
          ],
        ),
      ],
    );
  }

  // --- REGISTER FORM ---
  Widget _buildRegisterForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 24),
        _label('Full Name *'),
        _textField(hint: 'Enter your full name'),
        const SizedBox(height: 16),
        _label('Email Address *'),
        _textField(hint: 'Enter your email'),
        const SizedBox(height: 16),
        _label('Phone Number *'),
        _textField(hint: '+251912345678', keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        _label('Password *'),
        _textField(hint: 'Create a password', obscure: true),
        const SizedBox(height: 16),
        _label('Confirm Password *'),
        _textField(hint: 'Confirm your password', obscure: true),
        const SizedBox(height: 16),
        _passwordRequirementBox(),
        const SizedBox(height: 24),
        _redButton('CREATE ACCOUNT', () {}),
      ],
    );
  }

  // --- FORGOT PASSWORD ---
  Widget _buildForgotForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reset Your Password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text('Enter your email and we’ll send you a password reset link.', style: TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 24),
        _label('Email Address *'),
        _textField(hint: 'Enter your email'),
        const SizedBox(height: 32),
        _redButton('SEND PASSWORD RESET LINK', () {}),
      ],
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
  );

  Widget _textField({String? hint, bool obscure = false, TextInputType? keyboardType}) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[200]!)),
      ),
    );
  }

  Widget _passwordRequirementBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password must contain:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          _reqItem('At least 8 characters'),
          _reqItem('At least one uppercase letter'),
          _reqItem('At least one lowercase letter'),
          _reqItem('At least one number'),
          _reqItem('One special character (@\$!%*?&)'),
        ],
      ),
    );
  }

  Widget _reqItem(String text) => Row(
    children: [
      const Icon(Icons.check_circle_outline, size: 12, color: Colors.blue),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 11, color: Colors.black54)),
    ],
  );

  Widget _redButton(String text, VoidCallback onTap) => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
    ),
  );

  Widget _blackButton(String text, VoidCallback onTap) => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
    ),
  );
}
