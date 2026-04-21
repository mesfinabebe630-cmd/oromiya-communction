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
    
    // Kallacha
    'Weekly Newspaper': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=800',
    'Quarterly Newspaper': 'https://images.unsplash.com/photo-1585829365294-18d530cba2d8?q=80&w=800',
    'Yearly Book': 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=800',

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
