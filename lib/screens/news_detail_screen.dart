import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String category;
  final String date;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      const Text(
                        '1.2k Views',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  const Text(
                    'FINFINNEE - Biiroo Kominikeeshinii Oromiyaa dhimmoota biyyaalessaa fi naannoo irratti ibsa kenneera. Ibsa kanaan akka jedhametti, naannichi damee misoomaatiin injifannoowwan jajjaboo galmeessisaa jira.\n\n'
                    'Pirezidaantii Naannoo Oromiyaa Obbo Shimallis Abdiisaa akka jedhanitti, hojiileen misoomaa fi nageenyaa xiyyeeffannoo olaanaa argatanii hojjetamaa jiru. Keessattuu, guddinni dinagdee qonnaan wal qabatee jiru kan jajjabeeffamudha.\n\n'
                    'Dabalataanis, tajaajila kantiinootaa fi manneen jireenyaa waliin wal qabatee rakkoolee jiran hiikuuf hojjetamaa akka jiru ibsameera. Marii uummataa waliin gaggeeffamuun ragaaleen dhihaachaa jiru.',
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                  const SizedBox(height: 30),
                  _buildFooterBrand(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBrand() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance, color: Colors.white, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Biiroo Kominikeeshinii Oromiyaa',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'info@oromiacommunication.gov.et',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
