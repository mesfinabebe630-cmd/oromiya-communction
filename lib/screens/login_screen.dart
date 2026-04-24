import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';

class LoginScreen extends StatefulWidget {
  final bool isTab;
  const LoginScreen({super.key, this.isTab = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 0: Login, 1: Register, 2: Forgot Password
  int _viewMode = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content = SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          margin: EdgeInsets.symmetric(vertical: widget.isTab ? 20 : 40, horizontal: 20),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
                blurRadius: 20,
              )
            ],
          ),
          child: _buildContent(isDark),
        ),
      ),
    );

    if (widget.isTab) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue,
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
      body: content,
    );
  }

  Widget _buildContent(bool isDark) {
    switch (_viewMode) {
      case 1: return _buildRegisterForm(isDark);
      case 2: return _buildForgotForm(isDark);
      default: return _buildLoginForm(isDark);
    }
  }

  // --- LOGIN FORM ---
  Widget _buildLoginForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 24),
        _label('Username or Email Address *', isDark),
        _textField(hint: 'Enter your username or email', isDark: isDark),
        const SizedBox(height: 16),
        _label('Password *', isDark),
        _textField(hint: 'Enter your password', obscure: true, isDark: isDark),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (v) {},
              activeColor: AppTheme.primaryBlue,
              side: BorderSide(color: isDark ? Colors.white54 : Colors.grey),
            ),
            Text('Remember Me', style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
          ],
        ),
        const SizedBox(height: 24),
        _redButton('LOGIN', () {}),
        const SizedBox(height: 20),
        Center(child: Text('OR', style: TextStyle(color: isDark ? Colors.white38 : Colors.grey, fontWeight: FontWeight.bold))),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _blackButton('REGISTER', () => setState(() => _viewMode = 1), isDark)),
            const SizedBox(width: 12),
            Expanded(child: _blackButton('FORGET', () => setState(() => _viewMode = 2), isDark)),
          ],
        ),
      ],
    );
  }

  // --- REGISTER FORM ---
  Widget _buildRegisterForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            if (widget.isTab) IconButton(onPressed: () => setState(() => _viewMode = 0), icon: Icon(Icons.close, color: isDark ? Colors.white54 : Colors.grey)),
          ],
        ),
        const SizedBox(height: 24),
        _label('Full Name *', isDark),
        _textField(hint: 'Enter your full name', isDark: isDark),
        const SizedBox(height: 16),
        _label('Email Address *', isDark),
        _textField(hint: 'Enter your email', isDark: isDark),
        const SizedBox(height: 16),
        _label('Phone Number *', isDark),
        _textField(hint: '+251912345678', keyboardType: TextInputType.phone, isDark: isDark),
        const SizedBox(height: 16),
        _label('Password *', isDark),
        _textField(hint: 'Create a password', obscure: true, isDark: isDark),
        const SizedBox(height: 16),
        _label('Confirm Password *', isDark),
        _textField(hint: 'Confirm your password', obscure: true, isDark: isDark),
        const SizedBox(height: 16),
        _passwordRequirementBox(isDark),
        const SizedBox(height: 24),
        _redButton('CREATE ACCOUNT', () {}),
        if (widget.isTab) Center(
          child: TextButton(
            onPressed: () => setState(() => _viewMode = 0),
            child: const Text('Already have an account? Login', style: TextStyle(color: AppTheme.primaryBlue)),
          ),
        ),
      ],
    );
  }

  // --- FORGOT PASSWORD ---
  Widget _buildForgotForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reset Password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            if (widget.isTab) IconButton(onPressed: () => setState(() => _viewMode = 0), icon: Icon(Icons.close, color: isDark ? Colors.white54 : Colors.grey)),
          ],
        ),
        const SizedBox(height: 12),
        Text('Enter your email and we’ll send you a password reset link.', style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 14)),
        const SizedBox(height: 24),
        _label('Email Address *', isDark),
        _textField(hint: 'Enter your email', isDark: isDark),
        const SizedBox(height: 32),
        _redButton('SEND RESET LINK', () {}),
        if (widget.isTab) Center(
          child: TextButton(
            onPressed: () => setState(() => _viewMode = 0),
            child: const Text('Back to Login', style: TextStyle(color: AppTheme.primaryBlue)),
          ),
        ),
      ],
    );
  }

  Widget _label(String text, bool isDark) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
  );

  Widget _textField({String? hint, bool obscure = false, TextInputType? keyboardType, required bool isDark}) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white30 : Colors.grey[400], fontSize: 13),
        filled: true,
        fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
      ),
    );
  }

  Widget _passwordRequirementBox(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.primaryBlue.withOpacity(0.1) : Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password must contain:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 6),
          _reqItem('At least 8 characters', isDark),
          _reqItem('At least one uppercase letter', isDark),
          _reqItem('At least one lowercase letter', isDark),
          _reqItem('At least one number', isDark),
          _reqItem('One special character (@\$!%*?&)', isDark),
        ],
      ),
    );
  }

  Widget _reqItem(String text, bool isDark) => Row(
    children: [
      const Icon(Icons.check_circle_outline, size: 12, color: Colors.blue),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : Colors.black54)),
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

  Widget _blackButton(String text, VoidCallback onTap, bool isDark) => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? Colors.white10 : Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
    ),
  );
}
