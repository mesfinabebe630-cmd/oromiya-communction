import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';

class AboutContent extends StatelessWidget {
  final String lang;
  const AboutContent({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('About Oromia Communication Bureau'),
          const Text(
            'The powers and roles of the Oromia Communications Bureau are defined in Article 31 of the Oromia Regional State Executive Bodies Reorganization Law No. 242/2.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildRolePoint('1', 'Serve as the information center of the region; coordinate the information work of the regional government; establish rules; provide leadership.'),
          _buildRolePoint('2', 'Serve as government spokesperson; prepare position statements on emergencies, holidays, and national events.'),
          _buildRolePoint('3', 'Coordinate government communication activities in public sectors.'),
          _buildRolePoint('4', 'Provide training to communication and media managers.'),
          _buildRolePoint('5', 'Develop programs to promote regional reputation.'),
          // ... summarized for brevity in UI
          const SizedBox(height: 30),
          
          _quoteSection(),

          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _infoCard('Mission', 'To create a good understanding between the government and the public by establishing an effective communication system.')),
              const SizedBox(width: 15),
              Expanded(child: _infoCard('Vision', 'To see the public gain accurate understanding of government positions and begin the journey to prosperity by the year 2030.')),
            ],
          ),

          const SizedBox(height: 30),
          _sectionTitle('Core Values'),
          _valueItem('Reliable Source', 'Strengthening trust by providing reliable, transparent, and timely information.'),
          _valueItem('Working for Change', 'Adapting to circumstances to embrace improvement.'),
          _valueItem('Proactive Engagement', 'Implementing planned and monitored communication activities.'),

          const SizedBox(height: 30),
          _sectionTitle('Our Leaders'),
          _leaderItem('Mr. Hailu Adugna', 'Head of Oromia Communication Bureau'),
          _leaderItem('Mr. Eshetu Sirnessa', 'Deputy Head'),
          _leaderItem('Mr. Boja Gebisa', 'Deputy Head'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
      ),
    );
  }

  Widget _buildRolePoint(String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$num. ', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _quoteSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: const Border(left: BorderSide(color: AppTheme.primaryBlue, width: 5)),
      ),
      child: Column(
        children: const [
          Text(
            '“Information is the foundation of public trust. We work every day to ensure that the people of Oromia stay informed, connected, and empowered.”',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text('- Mr. Hailu Adugna', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryBlue)),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _valueItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• $title', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _leaderItem(String name, String role) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: AppTheme.primaryBlue, child: Icon(Icons.person, color: Colors.white)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(role),
    );
  }
}
