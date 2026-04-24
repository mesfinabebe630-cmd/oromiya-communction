import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';

class ContactContent extends StatelessWidget {
  final String lang;
  const ContactContent({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, AppTranslations.getText(lang, 'contact_us')),
          Text(
            AppTranslations.getText(lang, 'contact_desc'),
            style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 25),
          
          _infoTile(context, Icons.location_on, AppTranslations.getText(lang, 'address'), 'Bole Dembel, Finfinnee (Addis Ababa), Ethiopia'),
          _infoTile(context, Icons.phone, AppTranslations.getText(lang, 'phone'), '+251-116-18-10-10'),
          _infoTile(context, Icons.phone_iphone, AppTranslations.getText(lang, 'mobile'), '+251-912-79-46-53'),
          _infoTile(context, Icons.email, AppTranslations.getText(lang, 'email'), 'info@oromiacommunication.gov.et'),
          _infoTile(context, Icons.mail, AppTranslations.getText(lang, 'po_box'), '3115 Code 1250'),

          const SizedBox(height: 40),
          _sectionTitle(context, AppTranslations.getText(lang, 'report_portal_title')),
          Text(
            AppTranslations.getText(lang, 'report_portal_desc'),
            style: TextStyle(fontSize: 14, color: isDark ? Colors.white60 : Colors.black54),
          ),
          const SizedBox(height: 30),

          _buildContactForm(context),
          
          const SizedBox(height: 50),
          _sectionTitle(context, AppTranslations.getText(lang, 'our_partners')),
          _partnerLinks(isDark),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.blue[300] : AppTheme.primaryBlue),
    );
  }

  Widget _infoTile(BuildContext context, IconData icon, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _textField(context, AppTranslations.getText(lang, 'your_name')),
          _textField(context, AppTranslations.getText(lang, 'phone_number')),
          _textField(context, AppTranslations.getText(lang, 'email_address')),
          _dropdownField(context, AppTranslations.getText(lang, 'report_for')),
          _textField(context, AppTranslations.getText(lang, 'your_message'), maxLines: 4),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
              child: Text(AppTranslations.getText(lang, 'send_message'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context, String label, {int maxLines = 1}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        maxLines: maxLines,
        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryBlue)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }

  Widget _dropdownField(BuildContext context, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryBlue)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        items: [
          DropdownMenuItem(value: '1', child: Text(AppTranslations.getText(lang, 'general_inquiry'))),
          DropdownMenuItem(value: '2', child: Text(AppTranslations.getText(lang, 'regional_office'))),
          DropdownMenuItem(value: '3', child: Text(AppTranslations.getText(lang, 'media_inquiry'))),
        ],
        onChanged: (v) {},
      ),
    );
  }

  Widget _partnerLinks(bool isDark) {
    final partners = ['Ethio Telecom', 'Zemen Gebeya', 'EGP Procurement', 'Siinqee Bank', 'Dallol Tech'];
    return Wrap(
      spacing: 10,
      children: partners.map((p) => ActionChip(
        label: Text(p, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87)),
        onPressed: () {},
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
      )).toList(),
    );
  }
}
