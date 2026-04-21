import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/screens/login_screen.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  final List<String> _headlines = [
    "The urbanization strategy is changing the lives of the community!",
    "The stage of our struggle is Economy, Education and Technology as well as, System Building!",
    "Agriculture has been radically transformed to increase production and productivity.",
  ];
  int _currentHeadlineIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentHeadlineIndex = (_currentHeadlineIndex + 1) % _headlines.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // 1. Logo Section
          Row(
            children: [
              Image.asset(
                'assets/ic_launcher.png',
                height: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance, color: Colors.white, size: 35),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTranslations.getText(lang, 'app_title').split(' ')[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    AppTranslations.getText(lang, 'app_title').replaceFirst(AppTranslations.getText(lang, 'app_title').split(' ')[0], '').trim().toUpperCase(),
                    style: const TextStyle(color: Colors.white70, fontSize: 7, letterSpacing: 0.5),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(width: 15),

          // 2. Date Section (White Rectangle)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: const [
                Text('20', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(width: 4),
                Text('APR 2026', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // 3. Headline Label (Red Rectangle)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${AppTranslations.getText(lang, 'headline')} :',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),

          const SizedBox(width: 15),

          // 4. News Ticker
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(4),
                color: Colors.black12,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  _headlines[_currentHeadlineIndex],
                  key: ValueKey<int>(_currentHeadlineIndex),
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // 5. Language Selector & Social
          Row(
            children: [
              _langButton(lp, 'EN', 'en'),
              _langButton(lp, 'OR', 'om'),
              _langButton(lp, 'AM', 'am'),
              const VerticalDivider(color: Colors.white24, indent: 25, endIndent: 25),
              _socialIcon(Icons.facebook),
              _socialIcon(Icons.play_circle_filled),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  minimumSize: const Size(60, 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Text(AppTranslations.getText(lang, 'sign_in'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _langButton(LanguageProvider lp, String label, String code) {
    bool isSelected = lp.currentLanguage == code;
    return InkWell(
      onTap: () => lp.changeLanguage(code),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.yellow : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}
