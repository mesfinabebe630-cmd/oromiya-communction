import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/models/navigation_data.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';
import 'package:oromiya_communication/widgets/about_content.dart';
import 'package:oromiya_communication/widgets/contact_content.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/screens/news_detail_screen.dart';
import 'package:oromiya_communication/screens/tenders_screen.dart';
import 'package:oromiya_communication/screens/shop_screen.dart';
import 'package:oromiya_communication/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;
  int _selectedNavIndex = 0; 
  String? _activeSubCategory;

  void _handleMenuAction(String action) {
    setState(() {
      _bottomIndex = 0;
      _selectedNavIndex = 0;
      _activeSubCategory = action;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomIndex = index;
      _activeSubCategory = null;
      if (index == 0) _selectedNavIndex = 0;
      if (index == 1) _selectedNavIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
        leading: (_activeSubCategory != null || (_bottomIndex == 0 && _selectedNavIndex != 0)) 
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() { _activeSubCategory = null; if(_bottomIndex == 0) _selectedNavIndex = 0; }),
              )
            : const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.account_balance, color: Colors.white, size: 24),
              ),
        title: CustomHeader(onMenuAction: _handleMenuAction),
        centerTitle: false,
      ),
      body: _buildBody(context, lang),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: AppTheme.primaryBlue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: AppTranslations.getText(lang, 'home')),
          BottomNavigationBarItem(icon: const Icon(Icons.newspaper_outlined), label: AppTranslations.getText(lang, 'news')),
          BottomNavigationBarItem(icon: const Icon(Icons.search), label: AppTranslations.getText(lang, 'Search')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: AppTranslations.getText(lang, 'sign_in')),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, String lang) {
    switch (_bottomIndex) {
      case 0: return _buildHomeTab(context, lang);
      case 1: return _buildNewsTab(context, lang);
      case 2: return _buildSearchTab(context, lang);
      case 3: return _buildProfileTab(context, lang);
      default: return _buildHomeTab(context, lang);
    }
  }

  Widget _buildHomeTab(BuildContext context, String lang) {
    return Column(
      children: [
        _buildTopCategories(context, lang),
        Expanded(
          child: SingleChildScrollView(
            child: _activeSubCategory != null
                ? _buildSubCategoryContent(context, lang, _activeSubCategory!)
                : _selectedNavIndex != 0
                    ? _buildSubGrid(context, lang)
                    : _buildHomeFeed(context, lang),
          ),
        ),
      ],
    );
  }

  Widget _buildTopCategories(BuildContext context, String lang) {
    final items = NavigationData.mainNavItems.where((item) => 
      item.title != 'Home' && item.title != 'News' && item.title != 'Language' && item.title != 'About'
    ).toList();

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          // CRITICAL FIX: Safe index mapping
          final realIndex = NavigationData.mainNavItems.indexWhere((e) => e.title == item.title);
          final sel = _selectedNavIndex == realIndex;
          
          return InkWell(
            onTap: () {
              if (item.title == 'Shops') {
                Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ShopScreen()));
                return;
              }
              if (item.title == 'Tenders') {
                Navigator.push(ctx, MaterialPageRoute(builder: (_) => const TendersScreen()));
                return;
              }
              setState(() {
                _selectedNavIndex = realIndex;
                _activeSubCategory = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: sel ? AppTheme.primaryBlue : Colors.transparent, width: 3))),
              child: Text(AppTranslations.getText(lang, item.title),
                  style: TextStyle(color: sel ? AppTheme.primaryBlue : null, fontWeight: sel ? FontWeight.bold : null)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeFeed(BuildContext context, String lang) {
    return Column(
      children: [
        _buildHeroSection(lang),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTranslations.getText(lang, 'latest'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildNewsList(context, lang, 'Political', itemCount: 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(String lang) {
    return Container(
      width: double.infinity, height: 160, margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppTheme.primaryBlue, Color(0xFF1565C0)]),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppTranslations.getText(lang, 'app_title'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(AppTranslations.getText(lang, 'slogan'), style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSubCategoryContent(BuildContext context, String lang, String sub) {
    if (sub == 'Contact Us') return ContactContent(lang: lang);
    if (sub == 'About Us') return AboutContent(lang: lang);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTranslations.getText(lang, sub), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          const SizedBox(height: 16),
          _buildNewsList(context, lang, sub),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, String lang, String category, {int itemCount = 3}) {
    final imageUrl = NavigationData.categoryImages[category];
    return ListView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                  child: imageUrl != null ? Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover) : Container(width: 100, height: 100, color: Colors.grey[200]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslations.getText(lang, category).toUpperCase(), style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(AppTranslations.getText(lang, 'read_more') + '...', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubGrid(BuildContext context, String lang) {
    final item = NavigationData.mainNavItems[_selectedNavIndex];
    final subItems = item.subItems!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: subItems.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => setState(() => _activeSubCategory = subItems[index]),
          child: Container(
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(AppTranslations.getText(lang, subItems[index]), textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsTab(BuildContext context, String lang) {
    final categories = ['Political', 'Social', 'Economy', 'Sport', 'Technology', 'Environments'];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTranslations.getText(lang, categories[index]), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildNewsList(context, lang, categories[index], itemCount: 2),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchTab(BuildContext context, String lang) => const Center(child: Icon(Icons.search, size: 100, color: Colors.grey));
  Widget _buildProfileTab(BuildContext context, String lang) => const Center(child: Icon(Icons.person, size: 100, color: Colors.grey));
}
