import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;

    return Container(
      width: double.infinity,
      color: AppTheme.primaryBlue,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _footerColumn1(context, lang)),
                    Expanded(child: _footerColumn2(lang)),
                    Expanded(child: _footerColumn3(lang)),
                    Expanded(child: _footerColumn4(lang)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _footerColumn1(context, lang),
                    const SizedBox(height: 40),
                    _footerColumn2(lang),
                    const SizedBox(height: 40),
                    _footerColumn3(lang),
                    const SizedBox(height: 40),
                    _footerColumn4(lang),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '© 2026 ${AppTranslations.getText(lang, 'app_title')}. All rights reserved.',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ),
              const Text(
                'Powered by Dallol Tech PLC',
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerColumn1(BuildContext context, String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/ic_launcher.png',
          height: 60,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance, color: Colors.white, size: 50),
        ),
        const SizedBox(height: 20),
        Text(
          AppTranslations.getText(lang, 'app_title'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          AppTranslations.getText(lang, 'slogan'),
          style: const TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 20),
        _footerInfoItem(Icons.location_on, 'Bole Dembel, Finfinnee, Ethiopia'),
        _footerInfoItem(Icons.phone, '+251115541816'),
        _footerInfoItem(Icons.email, 'info@oromiacommunication.gov.et'),
        _footerInfoItem(Icons.mail, 'P.O. Box 8741'),
      ],
    );
  }

  Widget _footerColumn2(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTranslations.getText(lang, 'categories'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        _footerLink(AppTranslations.getText(lang, 'home')),
        _footerLink(AppTranslations.getText(lang, 'politics')),
        _footerLink(AppTranslations.getText(lang, 'social')),
        _footerLink(AppTranslations.getText(lang, 'economy')),
        _footerLink(AppTranslations.getText(lang, 'sport')),
      ],
    );
  }

  Widget _footerColumn3(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTranslations.getText(lang, 'links'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        _footerLink('Kalacha Weekly'),
        _footerLink('Quarterly Magazine'),
        _footerLink(AppTranslations.getText(lang, 'tenders')),
        _footerLink(AppTranslations.getText(lang, 'shops')),
      ],
    );
  }

  Widget _footerColumn4(String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTranslations.getText(lang, 'subscribe'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        Text(
          'Stay informed with the latest updates.',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppTranslations.getText(lang, 'your_email'),
                  hintStyle: const TextStyle(color: Colors.white54, fontSize: 12),
                  filled: true,
                  fillColor: Colors.white12,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: Text(AppTranslations.getText(lang, 'send')),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footerInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {},
        child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ),
    );
  }
}
