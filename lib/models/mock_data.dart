import 'news_item.dart';
import 'media_item.dart';
import 'government_entity.dart';
import 'tender_item.dart';
import 'product_item.dart';

class MockData {
  static final List<ProductItem> products = [
    ProductItem(
      name: 'Kallacha Weekly Newspaper',
      price: '15.00',
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=400',
      description: 'The latest weekly edition of the Kallacha Oromiyaa newspaper.',
    ),
    ProductItem(
      name: 'Oromia Administrative Map',
      price: '150.00',
      imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=400',
      description: 'High-quality printed map of the Oromia region with current administrative boundaries.',
    ),
    ProductItem(
      name: 'History of the Oromo People',
      price: '350.00',
      imageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=400',
      description: 'A comprehensive book on the rich history and culture of the Oromo people.',
    ),
    ProductItem(
      name: 'Official Bureau Badge',
      price: '50.00',
      imageUrl: 'https://images.unsplash.com/photo-1554224155-672629188411?q=80&w=400',
      description: 'Official lapel pin of the Oromia Communication Bureau.',
    ),
  ];

  static final List<TenderItem> tenders = [
    TenderItem(
      title: 'Shakiso Airport Construction Project',
      id: 'PRJ-20260303-165813',
      category: 'Active Tenders',
      organization: 'Oromia President Office',
      closingDate: 'Apr 30, 2026',
      fee: '1,000.00 ETB',
      daysLeft: 7,
      documentUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
    TenderItem(
      title: 'Adama Water Expansion Phase II',
      id: 'PRJ-20260415-8821',
      category: 'Paid Tenders',
      organization: 'Oromia Water Bureau',
      closingDate: 'May 15, 2026',
      fee: '500.00 ETB',
      daysLeft: 12,
      documentUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
    TenderItem(
      title: 'Supply of Medical Equipment for Jimma Hospital',
      id: 'PRJ-20260520-4432',
      category: 'Closing Soon',
      organization: 'Oromia Health Bureau',
      closingDate: 'March 25, 2024',
      fee: '200.00 ETB',
      daysLeft: 2,
      documentUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
    TenderItem(
      title: 'Rural Road Maintenance in West Arsi',
      id: 'PRJ-20260601-9901',
      category: 'Free Tenders',
      organization: 'Oromia Roads Authority',
      closingDate: 'June 10, 2026',
      fee: '0.00 ETB',
      daysLeft: 20,
      isFeeRequired: false,
      documentUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
  ];

  static final List<GovernmentEntity> governmentEntities = [
    GovernmentEntity(
      name: 'Oromia Health Bureau',
      category: 'Regional Sector',
      description: 'The Oromia Health Bureau is responsible for the planning and implementation of health policies in the region.',
      website: 'https://www.ohb.gov.et',
      address: 'Adama, Oromia',
      contact: '+251 22 111 2233',
      imageUrl: 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'East Shewa Zone Administration',
      category: 'Zone',
      description: 'The administrative body for the East Shewa Zone, overseeing local development and governance.',
      address: 'Adama',
      imageUrl: 'https://images.unsplash.com/photo-1577412647305-991150c7d163?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Bishoftu City Administration',
      category: 'City',
      description: 'Governing body for the city of Bishoftu, focusing on urban development and public services.',
      imageUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Oromia Education Bureau',
      category: 'Regional Sector',
      description: 'Ensuring quality education and accessibility across all levels in the Oromia region.',
      website: 'https://www.oeb.gov.et',
      imageUrl: 'https://images.unsplash.com/photo-1523050853064-db72f10664e1?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Jimma Zone Administration',
      category: 'Zone',
      description: 'Administration of the Jimma zone, known for its rich coffee production and cultural history.',
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Ambo Woreda Office',
      category: 'Woreda',
      description: 'Local government office serving the Ambo district and surrounding rural areas.',
      imageUrl: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Nekemte City Mayor Office',
      category: 'City',
      description: 'The administrative heart of Nekemte city, coordinating urban development and public safety.',
      imageUrl: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Bole Sub-city Branch',
      category: 'Sub-city',
      description: 'Local administrative branch focusing on community services and residential governance.',
      imageUrl: 'https://images.unsplash.com/photo-1517733948473-7c9388334460?q=80&w=800',
    ),
    GovernmentEntity(
      name: 'Kebele 01 Administration',
      category: 'Kebele',
      description: 'The primary level of government administration, providing direct services to local residents.',
      imageUrl: 'https://images.unsplash.com/photo-1541970730449-623625f3fb40?q=80&w=800',
    ),
  ];

  static final List<MediaItem> mediaItems = [
    MediaItem(
      title: 'Oromia Regional State Annual Progress Report 2023',
      category: 'Video',
      thumbnail: 'https://images.unsplash.com/photo-1492724441997-5dc865305da7?q=80&w=800',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      type: MediaType.video,
      duration: '15:20',
      description: 'A comprehensive overview of the developmental milestones achieved in the Oromia region over the past year.',
    ),
    MediaItem(
      title: 'Preserving Oromo Cultural Heritage',
      category: 'Documentation',
      thumbnail: 'https://images.unsplash.com/photo-1517842645767-c639042777db?q=80&w=800',
      url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      type: MediaType.document,
      description: 'An in-depth document detailing the efforts taken to preserve and promote the Gadaa system and Oromo language.',
    ),
    MediaItem(
      title: 'Speech by President Shimelis Abdisa at Adama Youth Forum',
      category: 'Audio File',
      thumbnail: 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?q=80&w=800',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      type: MediaType.audio,
      duration: '08:45',
      description: 'President Shimelis Abdisa addresses the youth on economic opportunities and leadership.',
    ),
    MediaItem(
      title: 'Press Release on Agricultural Investment 2024',
      category: 'Press Release',
      thumbnail: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?q=80&w=800',
      url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      type: MediaType.document,
      description: 'Official statement regarding new incentives for local and international agricultural investors.',
    ),
    MediaItem(
      title: 'Oromia Green Legacy 2024 Campaign Launch',
      category: 'Video',
      thumbnail: 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=800',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      type: MediaType.video,
      duration: '05:12',
      description: 'Highlights from the launch event of the 2024 Green Legacy tree-planting initiative.',
    ),
    MediaItem(
      title: 'Traditional Oromo Music Collection - Vol 1',
      category: 'Audio File',
      thumbnail: 'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=800',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      type: MediaType.audio,
      duration: '45:00',
    ),
  ];

  static final List<NewsItem> newsItems = [
    NewsItem(
      title: 'Oromia Regional State Launches New Irrigation Project in East Hararghe',
      category: 'Economy',
      time: '2 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=800',
      content: 'The Oromia Regional State has officially launched a multi-million birr irrigation project aimed at boosting agricultural productivity in the East Hararghe zone...',
    ),
    NewsItem(
      title: 'Regional President Discusses Development Goals with Local Elders',
      category: 'Political',
      time: '4 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?q=80&w=800',
      content: 'President Shimelis Abdisa met with community elders in Jimma to discuss ongoing development projects and security matters...',
    ),
    NewsItem(
      title: 'Cultural Festival Celebrated with Grandeur in Shashamane',
      category: 'Social',
      time: '1 day ago',
      imageUrl: 'https://images.unsplash.com/photo-1511632765486-a01980e01a18?q=80&w=800',
      content: 'Thousands gathered in Shashamane to celebrate the annual cultural heritage festival, showcasing the rich traditions of the Oromo people...',
    ),
    NewsItem(
      title: 'Oromia Coffee Exports Reach Record High This Quarter',
      category: 'Economy',
      time: '3 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=800',
      content: 'The Oromia Coffee Farmers Cooperative Union announced that export volumes have increased by 15% compared to the previous year...',
    ),
    NewsItem(
      title: 'New High School Inaugurated in Ambo to Improve Education Access',
      category: 'Social',
      time: '5 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1523050853064-db72f10664e1?q=80&w=800',
      content: 'A modern high school facility equipped with digital labs was inaugurated in Ambo city today...',
    ),
    NewsItem(
      title: 'Oromia Athletics Team Triumphs at National Championships',
      category: 'Sport',
      time: '6 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=800',
      content: 'Athletes from the Oromia region dominated the long-distance events at the national track and field championships held in Addis Ababa...',
    ),
    NewsItem(
      title: 'Tech Hub for Youth Entrepreneurs Opens in Adama',
      category: 'Technology',
      time: '10 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?q=80&w=800',
      content: 'Adama city now hosts a new innovation center providing mentorship and resources for young tech entrepreneurs in the region...',
    ),
    NewsItem(
      title: 'Environmental Protection Bureau Initiates Green Legacy Campaign',
      category: 'Environments',
      time: '12 hours ago',
      imageUrl: 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=800',
      content: 'The region plans to plant millions of seedlings this rainy season as part of the nationwide Green Legacy initiative...',
    ),
  ];

  static List<NewsItem> getNewsByCategory(String category) {
    if (category == 'News' || category == 'Latest') return newsItems;
    return newsItems.where((item) => item.category == category).toList();
  }

  static List<MediaItem> getMediaByCategory(String category) {
    if (category == 'Media' || category == 'All') return mediaItems;
    return mediaItems.where((item) => item.category == category).toList();
  }

  static List<GovernmentEntity> getEntitiesByCategory(String category) {
    return governmentEntities.where((item) => item.category == category).toList();
  }
}
