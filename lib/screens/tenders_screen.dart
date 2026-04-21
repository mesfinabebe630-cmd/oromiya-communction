import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';

class TendersScreen extends StatelessWidget {
  const TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenders')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _box('Calbaasii waliigala', '0', Colors.blue),
                _box('Calbaasii kan gatii hin qabne', '1', Colors.green),
                _box('Kaffaltiin Barbaachisa', '0', Colors.orange),
                _box('Dhiyootti cufamu', '0', Colors.red),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Qajeelfama iyyannoo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('• Calbaasii kan gatii hin qabne'),
                  Text('• Kaffaltiin Barbaachisa'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(String title, String val, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(val, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
