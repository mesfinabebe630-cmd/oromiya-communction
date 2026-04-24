import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';

class AboutContent extends StatelessWidget {
  final String lang;
  const AboutContent({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context, AppTranslations.getText(lang, 'about_bureau')),
          Text(
            AppTranslations.getText(lang, 'about_bureau_desc'),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 20),
          // ... (Removed hardcoded list for brevity, can be expanded if needed)
          
          _quoteSection(isDark),

          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _infoCard(context, AppTranslations.getText(lang, 'mission'), AppTranslations.getText(lang, 'mission_desc'))),
              const SizedBox(width: 15),
              Expanded(child: _infoCard(context, AppTranslations.getText(lang, 'vision'), AppTranslations.getText(lang, 'vision_desc'))),
            ],
          ),

          const SizedBox(height: 30),
          _sectionTitle(context, AppTranslations.getText(lang, 'core_values')),
          _valueItem(isDark, AppTranslations.getText(lang, 'reliable_source'), AppTranslations.getText(lang, 'reliable_source_desc')),
          _valueItem(isDark, AppTranslations.getText(lang, 'working_for_change'), AppTranslations.getText(lang, 'working_for_change_desc')),
          _valueItem(isDark, AppTranslations.getText(lang, 'proactive_engagement'), AppTranslations.getText(lang, 'proactive_engagement_desc')),

          const SizedBox(height: 30),
          _sectionTitle(context, AppTranslations.getText(lang, 'our_leaders')),
          _leaderItem(isDark, AppTranslations.getText(lang, 'hailu_adugna'), AppTranslations.getText(lang, 'hailu_role')),
          _leaderItem(isDark, AppTranslations.getText(lang, 'eshetu_sirnessa'), AppTranslations.getText(lang, 'eshetu_role')),
          _leaderItem(isDark, AppTranslations.getText(lang, 'boja_gebisa'), AppTranslations.getText(lang, 'boja_role')),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.blue[300] : AppTheme.primaryBlue),
      ),
    );
  }

  Widget _quoteSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.withOpacity(0.1) : Colors.blue[50],
        border: const Border(left: BorderSide(color: AppTheme.primaryBlue, width: 5)),
      ),
      child: Column(
        children: [
          Text(
            '“Information is the foundation of public trust. We work every day to ensure that the people of Oromia stay informed, connected, and empowered.”',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text('- Mr. Hailu Adugna', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context, String title, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.blue[300] : AppTheme.primaryBlue)),
          const SizedBox(height: 10),
          Text(text, style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
        ],
      ),
    );
  }

  Widget _valueItem(bool isDark, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• $title', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          Text(desc, style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black54)),
        ],
      ),
    );
  }

  Widget _leaderItem(bool isDark, String name, String role) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: AppTheme.primaryBlue, child: Icon(Icons.person, color: Colors.white)),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(role, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
    );
  }
}
