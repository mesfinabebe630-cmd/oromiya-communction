import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/models/navigation_data.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/screens/login_screen.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';
import 'package:oromiya_communication/widgets/custom_footer.dart';
import 'package:oromiya_communication/widgets/about_content.dart';
import 'package:oromiya_communication/widgets/contact_content.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;
  String? _activeSubCategory;
  String _sortBy = 'Latest';

  void _onNavItemTap(int index) {
    setState(() {
      _selectedNavIndex = index;
      _activeSubCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
        toolbarHeight: 80,
        title: const CustomHeader(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              _buildMainNavigation(lang),
              _buildSubNavigation(lang),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(lang),
            _buildMainContent(lang),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainNavigation(String lang) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: NavigationData.mainNavItems.length,
        itemBuilder: (context, index) {
          final item = NavigationData.mainNavItems[index];
          final isSelected = _selectedNavIndex == index;
          return InkWell(
            onTap: () => _onNavItemTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                AppTranslations.getText(lang, item.title).toUpperCase(),
                style: TextStyle(
                  color: isSelected ? AppTheme.primaryBlue : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubNavigation(String lang) {
    final activeItem = NavigationData.mainNavItems[_selectedNavIndex];
    if (activeItem.subItems == null || activeItem.subItems!.isEmpty) {
      return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
      );
    }

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: activeItem.subItems!.length,
        itemBuilder: (context, index) {
          final sub = activeItem.subItems![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: TextButton(
                onPressed: () => setState(() => _activeSubCategory = sub),
                child: Text(
                  AppTranslations.getText(lang, sub),
                  style: TextStyle(
                    color: _activeSubCategory == sub ? AppTheme.primaryBlue : Colors.black54,
                    fontWeight: _activeSubCategory == sub ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(String lang) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://www.oromiacommunication.gov.et/website/images/slider/banner1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTranslations.getText(lang, 'app_title'),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              AppTranslations.getText(lang, 'slogan'),
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(String lang) {
    final activeItem = NavigationData.mainNavItems[_selectedNavIndex];
    
    if (activeItem.title == 'Tenders') {
      return const TendersScreenContent();
    } else if (activeItem.title == 'Shops') {
      return const ShopScreenContent();
    } else if (activeItem.title == 'About') {
      if (_activeSubCategory == 'Contact Us') {
        return ContactContent(lang: lang);
      }
      return AboutContent(lang: lang);
    }
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppTranslations.getText(lang, _activeSubCategory ?? activeItem.title),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: AppTheme.primaryBlue),
                onPressed: () {},
              ),
              DropdownButton<String>(
                value: _sortBy,
                items: <String>['Latest', 'Most Read', 'Most Viewed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(AppTranslations.getText(lang, value), style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _sortBy = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildPopularTags(lang),
          const SizedBox(height: 20),
          _buildDynamicList(lang),
        ],
      ),
    );
  }

  Widget _buildPopularTags(String lang) {
    final tags = ['Politics', 'Social', 'Economy', 'Sport', 'Technology', 'Environment', 'Features'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Popular Tags', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) => ActionChip(
            label: Text(tag, style: const TextStyle(fontSize: 12)),
            onPressed: () {
              // Navigate to the News section and select the tag as sub-category
              setState(() {
                _selectedNavIndex = 1; // Assuming News is index 1
                _activeSubCategory = tag;
              });
            },
            backgroundColor: Colors.grey[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDynamicList(String lang) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        final currentCat = _activeSubCategory ?? NavigationData.mainNavItems[_selectedNavIndex].title;
        final imageUrl = NavigationData.categoryImages[currentCat] ?? 
                         'https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=800';

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppTranslations.getText(lang, currentCat)} News Update #${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Official communication regarding the latest developments in this sector. Providing transparent and timely information to the public.',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(AppTranslations.getText(lang, 'read_more'), style: const TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.remove_red_eye, size: 14, color: Colors.grey),
                            SizedBox(width: 4),
                            Text('1.2k', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TendersScreenContent extends StatelessWidget {
  const TendersScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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

class ShopScreenContent extends StatelessWidget {
  const ShopScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.grey[100], child: const Icon(Icons.shopping_bag, size: 50, color: Colors.grey))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Product ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('ETB 500.00', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(double.infinity, 36)),
                        child: const Text('LOGIN TO BUY', style: TextStyle(color: Colors.white, fontSize: 10)),
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
