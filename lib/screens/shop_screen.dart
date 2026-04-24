import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/screens/login_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> products = [
      {'name': 'Kallacha Weekly', 'price': '15.00', 'img': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=400'},
      {'name': 'Oromia Map', 'price': '150.00', 'img': 'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=400'},
      {'name': 'History Book', 'price': '350.00', 'img': 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=400'},
      {'name': 'Bureau Badge', 'price': '50.00', 'img': 'https://images.unsplash.com/photo-1554224155-672629188411?q=80&w=400'},
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF4F7F9),
      appBar: AppBar(
        title: Text(AppTranslations.getText(lang, 'Shops')),
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue,
      ),
      // Footer is removed here (no Footer widget at bottom)
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            elevation: 2,
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(p['img']!, fit: BoxFit.cover, width: double.infinity,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], child: const Icon(Icons.shopping_cart)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 4),
                      Text('ETB ${p['price']}', style: TextStyle(color: isDark ? Colors.blue[300] : AppTheme.primaryBlue, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 38,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Using red as requested for buy buttons
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('LOGIN TO BUY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
