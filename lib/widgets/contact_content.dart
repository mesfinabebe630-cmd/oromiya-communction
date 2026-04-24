import 'package:flutter/material.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/localization/app_translations.dart';

class ContactContent extends StatelessWidget {
  final String lang;
  const ContactContent({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Contact Us'),
          const Text(
            'The Oromia Communication Bureau is responsible for delivering accurate, timely, and reliable information to the public. We serve as a bridge between the government and citizens.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 25),
          
          _infoTile(Icons.location_on, 'Address', 'Bole Dembel, Finfinnee (Addis Ababa), Ethiopia'),
          _infoTile(Icons.phone, 'Phone', '+251-116-18-10-10'),
          _infoTile(Icons.phone_iphone, 'Mobile', '+251-912-79-46-53'),
          _infoTile(Icons.email, 'Email', 'info@oromiacommunication.gov.et'),
          _infoTile(Icons.mail, 'P.O. Box', '3115 Code 1250'),

          const SizedBox(height: 40),
          _sectionTitle('Welcome to the Oromia Community Report Portal!'),
          const Text(
            'Do you have any questions, comments, reports, or inquiries? Submit them below:',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 30),

          _buildContactForm(),
          
          const SizedBox(height: 50),
          _sectionTitle('Our Partners'),
          _partnerLinks(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
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
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _textField('Your Name *'),
          _textField('Phone Number *'),
          _textField('Email Address *'),
          _dropdownField('Report For *'),
          _textField('Your Message *', maxLines: 4),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
              child: const Text('SEND MESSAGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black, fontSize: 14), // Ensures black text
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }

  Widget _dropdownField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
        items: const [
          DropdownMenuItem(value: '1', child: Text('General Inquiry')),
          DropdownMenuItem(value: '2', child: Text('Regional Office')),
          DropdownMenuItem(value: '3', child: Text('Media Inquiry')),
        ],
        onChanged: (v) {},
      ),
    );
  }

  Widget _partnerLinks() {
    final partners = ['Ethio Telecom', 'Zemen Gebeya', 'EGP Procurement', 'Siinqee Bank', 'Dallol Tech'];
    return Wrap(
      spacing: 10,
      children: partners.map((p) => ActionChip(
        label: Text(p, style: const TextStyle(fontSize: 11)),
        onPressed: () {},
        backgroundColor: Colors.grey[100],
      )).toList(),
    );
  }
}
