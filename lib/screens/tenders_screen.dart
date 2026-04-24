import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/screens/login_screen.dart';

class TendersScreen extends StatelessWidget {
  const TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF4F7F9),
      appBar: AppBar(
        title: const Text('Tenders'),
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Statistics
            Row(
              children: [
                Expanded(child: _statBox(context, 'Total Tenders', '12', Colors.blue)),
                const SizedBox(width: 10),
                Expanded(child: _statBox(context, 'Active Now', '9', Colors.orange)),
              ],
            ),
            const SizedBox(height: 20),

            // UNIFIED TENDER CARD
            _buildSmartTenderCard(context),
            const SizedBox(height: 20),
            _buildSmartTenderCard(context, 
              title: "Adama Water Expansion", 
              id: "PRJ-20260415-8821", 
              fee: "500.00 ETB", 
              days: "12"
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartTenderCard(BuildContext context, {
    String title = "Shakiso Airport", 
    String id = "PRJ-20260303-165813", 
    String fee = "1,000.00 ETB",
    String days = "7"
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06), 
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.vpn_key_outlined, size: 14, color: Colors.orange),
                      SizedBox(width: 5),
                      Text('Fee Required', style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('$days Day Left', style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Title & Office
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E))),
            const SizedBox(height: 4),
            Text('Oromia Presidant Office', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
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
                      Expanded(child: _infoItem(context, Icons.event_available, "Closing", "Apr 30, 2026")),
                      Expanded(child: _infoItem(context, Icons.file_download_outlined, "Document", "Available")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _infoItem(context, Icons.fingerprint, "Project ID", id)),
                      Expanded(child: _infoItem(context, Icons.account_balance_wallet_outlined, "Fee", fee)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // LOGIN TO BUY BUTTON INSIDE THE BOX
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('LOGIN TO BUY', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8)),
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
        border: Border.all(color: color.withOpacity(0.2)),
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
