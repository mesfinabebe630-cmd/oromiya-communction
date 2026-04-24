import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/screens/login_screen.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/screens/pdf_viewer_screen.dart';
import 'package:oromiya_communication/models/mock_data.dart';
import 'package:oromiya_communication/models/tender_item.dart';

class TendersScreen extends StatelessWidget {
  const TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LanguageProvider>(context).currentLanguage;
    final tenders = MockData.tenders;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF4F7F9),
      appBar: AppBar(
        title: Text(AppTranslations.getText(lang, 'tenders')),
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Top Statistics
          Row(
            children: [
              Expanded(child: _statBox(context, AppTranslations.getText(lang, 'total_tenders'), '${tenders.length}', Colors.blue)),
              const SizedBox(width: 10),
              Expanded(child: _statBox(context, AppTranslations.getText(lang, 'active_now'), '${tenders.where((t) => t.daysLeft > 0).length}', Colors.orange)),
            ],
          ),
          const SizedBox(height: 20),

          // TENDER LIST
          ...tenders.map((tender) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildSmartTenderCard(context, tender),
          )),
        ],
      ),
    );
  }

  Widget _buildSmartTenderCard(BuildContext context, TenderItem tender) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LanguageProvider>(context).currentLanguage;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 77 : 15), 
            blurRadius: 15, 
            offset: const Offset(0, 5)
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Fee Required with Key Icon & Days Left
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (tender.isFeeRequired)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.vpn_key_outlined, size: 14, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(AppTranslations.getText(lang, 'fee_required'), style: const TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(AppTranslations.getText(lang, 'free_tenders'), style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${tender.daysLeft} ${AppTranslations.getText(lang, tender.daysLeft > 1 ? 'days_left' : 'day_left')}', style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Title & Office
            Text(tender.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E))),
            const SizedBox(height: 4),
            Text(tender.organization, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),

            // ALL IN ONE RECTANGLE BOX
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE0E5EC)),
              ),
              child: Column(
                children: [
                  // Info Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _infoItem(context, Icons.event_available, AppTranslations.getText(lang, 'closing'), tender.closingDate)),
                      Expanded(child: _infoItem(context, Icons.file_download_outlined, AppTranslations.getText(lang, 'document'), AppTranslations.getText(lang, 'available'))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _infoItem(context, Icons.fingerprint, AppTranslations.getText(lang, 'project_id'), tender.id)),
                      Expanded(child: _infoItem(context, Icons.account_balance_wallet_outlined, AppTranslations.getText(lang, 'fee'), tender.fee)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // VIEW/BUY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!tender.isFeeRequired) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerScreen(
                                title: tender.title,
                                url: tender.documentUrl ?? "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen(redirectTo: 'tenders')));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tender.isFeeRequired ? Colors.red : AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Text(
                        AppTranslations.getText(lang, tender.isFeeRequired ? 'login_to_buy' : 'view_document'), 
                        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(BuildContext context, IconData icon, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, size: 16, color: isDark ? Colors.blue[300] : AppTheme.primaryBlue),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: isDark ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statBox(BuildContext context, String title, String val, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        children: [
          Text(val, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: isDark ? Colors.grey[400] : Colors.grey)),
        ],
      ),
    );
  }
}
