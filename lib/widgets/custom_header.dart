import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/theme/theme_provider.dart';

class CustomHeader extends StatefulWidget {
  final Function(String)? onMenuAction;
  final VoidCallback? onSearchTap;
  const CustomHeader({super.key, this.onMenuAction, this.onSearchTap});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  int _currentHeadlineIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) setState(() => _currentHeadlineIndex = (_currentHeadlineIndex + 1) % 3);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SettingsBottomSheet(onAction: widget.onMenuAction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;

    final List<String> headlines = [
      AppTranslations.getText(lang, 'slogan'),
      AppTranslations.getText(lang, 'Effective communication for Oromia Prosperity'),
      AppTranslations.getText(lang, 'The urbanization strategy is changing lives'),
    ];

    return Row(
      children: [
        // LEFT SIDE: APP ICON
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Image.asset(
            'assets/ic_launcher.png',
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) => const Icon(Icons.account_balance, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(width: 8),

        // MIDDLE: SMART ANIMATED RECTANGLE
        Expanded(
          child: Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 0.5),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);
                return ClipRect(
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Center(
                key: ValueKey<int>(_currentHeadlineIndex),
                child: Text(
                  headlines[_currentHeadlineIndex],
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),

        // RIGHT SIDE: SEARCH & MENU ICONS
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 24),
          onPressed: widget.onSearchTap,
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 26),
          onPressed: () => _openMenu(context),
        ),
      ],
    );
  }
}

class _SettingsBottomSheet extends StatelessWidget {
  final Function(String)? onAction;
  const _SettingsBottomSheet({this.onAction});

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final tp = Provider.of<ThemeProvider>(context);
    final lang = lp.currentLanguage;
    final isDark = tp.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          
          ListTile(
            leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: AppTheme.primaryBlue),
            title: Text(AppTranslations.getText(lang, 'Night Mode'), style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Switch(
              value: isDark,
              onChanged: (val) => tp.toggleTheme(val),
              activeColor: AppTheme.primaryBlue,
            ),
          ),
          
          const Divider(),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [Text(AppTranslations.getText(lang, 'language'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))]),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _langOption(context, lp, 'en', 'English'),
                const SizedBox(width: 10),
                _langOption(context, lp, 'om', 'Oromoo'),
                const SizedBox(width: 10),
                _langOption(context, lp, 'am', 'አማርኛ'),
              ],
            ),
          ),
          
          const Divider(height: 30),
          
          _menuItem(context, lang, Icons.info_outline, 'about_us', () {
            Navigator.pop(context);
            if (onAction != null) onAction!('About Us');
          }),
          _menuItem(context, lang, Icons.contact_support_outlined, 'contact_us', () {
            Navigator.pop(context);
            if (onAction != null) onAction!('Contact Us');
          }),
          _menuItem(context, lang, Icons.share_outlined, 'Share App', () {
            Navigator.pop(context);
            Share.share(
              'Install the Oromia Communication Bureau app to stay updated! Download here: https://play.google.com/store/apps/details?id=com.example.oromiya_communication',
              subject: 'Oromia Communication App',
            );
          }),
          _menuItem(context, lang, Icons.star_outline, 'Rate Us', () {
            Navigator.pop(context);
            final Uri url = Uri.parse('market://details?id=com.example.oromiya_communication');
            launchUrl(url, mode: LaunchMode.externalApplication).catchError((_) {
               launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.example.oromiya_communication'));
               return true;
            });
          }),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _langOption(BuildContext context, LanguageProvider lp, String code, String name) {
    bool isSel = lp.currentLanguage == code;
    return ChoiceChip(
      label: Text(name),
      selected: isSel,
      onSelected: (_) => lp.changeLanguage(code),
      selectedColor: AppTheme.primaryBlue.withOpacity(0.2),
      labelStyle: TextStyle(color: isSel ? AppTheme.primaryBlue : null, fontWeight: isSel ? FontWeight.bold : null),
    );
  }

  Widget _menuItem(BuildContext context, String lang, IconData icon, String key, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(AppTranslations.getText(lang, key)),
      onTap: onTap,
    );
  }
}
