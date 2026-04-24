import 'package:flutter/material.dart';
import 'nav_item.dart';

class NavigationData {
  static const Map<String, String> categoryImages = {
    // News Subcategories
    'Political': 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?q=80&w=800',
    'Social': 'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=800',
    'Economy': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=800',
    'Sport': 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=800',
    'Technology': 'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?q=80&w=800',
    'Environments': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=800',
    'Features': 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?q=80&w=800',
    
    // Tenders
    'Active Tenders': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?q=80&w=800',
    'Free Tenders': 'https://images.unsplash.com/photo-1554224155-672629188411?q=80&w=800',
    'Paid Tenders': 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?q=80&w=800',
    'Closing Soon': 'https://images.unsplash.com/photo-1508962914676-134849a727f0?q=80&w=800',

    // Governments
    'Regional Sector': 'https://images.unsplash.com/photo-1577412647305-991150c7d163?q=80&w=800',
    'Zone': 'https://images.unsplash.com/photo-1524813686514-a57563d77965?q=80&w=800',
    'Woreda': 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?q=80&w=800',
    
    // Kallacha Oromiyaa (Corrected Mappings)
    'Weekly Newspaper': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=800',
    'Quarterly Newspaper': 'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=800',
    'Yearly Book': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?q=80&w=800',
    'Brochure': 'https://images.unsplash.com/photo-1626785774573-4b799315345d?q=80&w=800',
    'Archive': 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?q=80&w=800',
    'Book': 'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=800',
    'File': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=800',

    // Media
    'Press Release': 'https://images.unsplash.com/photo-1557804506-669a67965ba0?q=80&w=800',
    'Documentation': 'https://images.unsplash.com/photo-1517842645767-c639042777db?q=80&w=800',
    'Video': 'https://images.unsplash.com/photo-1492724441997-5dc865305da7?q=80&w=800',
    'Image & Gallery': 'https://images.unsplash.com/photo-1452587925148-ce544e77e70d?q=80&w=800',
    'Audio File': 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?q=80&w=800',

    // Shops/General
    'Shops': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=800',
    'Books': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?q=80&w=800',
  };

  static List<NavItem> mainNavItems = [
    NavItem(title: 'Home', icon: Icons.home),
    NavItem(
      title: 'News',
      icon: Icons.newspaper,
      subItems: ['Political', 'Social', 'Economy', 'Sport', 'Technology', 'Environments', 'Features'],
    ),
    NavItem(
      title: 'Tenders',
      icon: Icons.gavel,
      subItems: ['Active Tenders', 'Free Tenders', 'Paid Tenders', 'Closing Soon'],
    ),
    NavItem(
      title: 'Governments',
      icon: Icons.account_balance,
      subItems: ['Regional Sector', 'Zone', 'Woreda', 'City', 'Sub-city', 'Kebele'],
    ),
    NavItem(
      title: 'Media',
      icon: Icons.play_circle_fill,
      subItems: ['Press Release', 'Documentation', 'Video', 'Image & Gallery', 'Audio File'],
    ),
    NavItem(
      title: 'Kallacha Oromiyaa',
      icon: Icons.article,
      subItems: ['Weekly Newspaper', 'Quarterly Newspaper', 'Yearly Book', 'Brochure', 'Archive', 'File', 'Book'],
    ),
    NavItem(title: 'Shops', icon: Icons.shopping_bag),
    NavItem(
      title: 'About',
      icon: Icons.info,
      subItems: ['About Us', 'Contact Us'],
    ),
    NavItem(
      title: 'Language',
      icon: Icons.language,
      subItems: ['Afaan Oromoo', 'Amharic', 'English', 'Tigrinya', 'Somali'],
    ),
  ];
}
