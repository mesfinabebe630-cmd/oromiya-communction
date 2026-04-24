import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oromiya_communication/models/navigation_data.dart';
import 'package:oromiya_communication/theme/app_theme.dart';
import 'package:oromiya_communication/widgets/custom_header.dart';
import 'package:oromiya_communication/widgets/about_content.dart';
import 'package:oromiya_communication/widgets/contact_content.dart';
import 'package:oromiya_communication/localization/app_translations.dart';
import 'package:oromiya_communication/localization/language_provider.dart';
import 'package:oromiya_communication/screens/tenders_screen.dart';
import 'package:oromiya_communication/screens/shop_screen.dart';
import 'package:oromiya_communication/screens/login_screen.dart';
import 'package:oromiya_communication/screens/pdf_viewer_screen.dart';
import 'package:oromiya_communication/screens/news_detail_screen.dart';
import 'package:oromiya_communication/screens/media_player_screen.dart';
import 'package:oromiya_communication/models/mock_data.dart';
import 'package:oromiya_communication/models/media_item.dart';
import 'package:oromiya_communication/models/government_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;
  int _selectedNavIndex = 0; 
  String? _activeSubCategory;
  String? _newsSubCategory; 
  
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isSearching = false;

  List<String> _getAllCategories() {
    List<String> all = [];
    for (var item in NavigationData.mainNavItems) {
      all.add(item.title);
      if (item.subItems != null) {
        all.addAll(item.subItems!);
      }
    }
    return all.toSet().toList();
  }

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
      _newsSubCategory = null;
      if (index == 0) _selectedNavIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LanguageProvider>(context);
    final lang = lp.currentLanguage;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue,
        elevation: 0,
        leading: (_activeSubCategory != null || _newsSubCategory != null || (_bottomIndex == 0 && _selectedNavIndex != 0)) 
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => setState(() { 
                    if (_activeSubCategory != null) {
                      _activeSubCategory = null;
                    } else if (_newsSubCategory != null) {
                      _newsSubCategory = null;
                    } else if (_bottomIndex == 0 && _selectedNavIndex != 0) {
                      _selectedNavIndex = 0;
                    }
                  }),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.account_balance, color: Colors.white, size: 24),
              ),
        title: CustomHeader(
          onMenuAction: _handleMenuAction,
          onSearchTap: () => setState(() => _bottomIndex = 2),
        ),
        centerTitle: false,
      ),
      body: _buildBody(context, lang),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: isDark ? Colors.white : AppTheme.primaryBlue,
        unselectedItemColor: Colors.grey,
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
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
          child: _activeSubCategory != null
              ? SingleChildScrollView(child: _buildSubCategoryContent(context, lang, _activeSubCategory!))
              : _selectedNavIndex != 0
                  ? _buildSubGrid(context, lang)
                  : SingleChildScrollView(child: _buildHomeFeed(context, lang)),
        ),
      ],
    );
  }

  Widget _buildSearchTab(BuildContext context, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            onChanged: (val) {
              setState(() {
                _isSearching = val.isNotEmpty;
                if (_isSearching) {
                  _searchResults = _getAllCategories()
                      .where((item) => item.toLowerCase().contains(val.toLowerCase()))
                      .toList();
                }
              });
            },
            decoration: InputDecoration(
              hintText: '${AppTranslations.getText(lang, 'Search')}...',
              prefixIcon: const Icon(Icons.search, color: AppTheme.primaryBlue),
              suffixIcon: _isSearching 
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
                    _searchController.clear();
                    setState(() => _isSearching = false);
                  })
                : null,
              filled: true,
              fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _isSearching
                ? _searchResults.isEmpty
                    ? _buildNoResults(lang)
                    : _buildSearchResults(lang)
                : _buildRecentSearchSection(lang),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(String lang) {
    final newsResults = MockData.newsItems.where((item) => 
      item.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
      item.category.toLowerCase().contains(_searchController.text.toLowerCase())
    ).toList();

    return ListView.builder(
      itemCount: _searchResults.length + newsResults.length,
      itemBuilder: (context, index) {
        if (index < _searchResults.length) {
          final category = _searchResults[index];
          bool isNews = false;
          bool isMain = NavigationData.mainNavItems.any((e) => e.title == category);
          try {
            isNews = NavigationData.mainNavItems.firstWhere((e) => e.title == 'News').subItems!.contains(category);
          } catch (_) {}
          
          return ListTile(
            leading: Icon(isNews ? Icons.newspaper : (isMain ? Icons.star_border : Icons.grid_view), color: AppTheme.primaryBlue),
            title: Text(AppTranslations.getText(lang, category)),
            subtitle: Text("Jump to ${AppTranslations.getText(lang, category)} section"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              setState(() {
                if (isMain) {
                  if (category == 'News') {
                    _bottomIndex = 1;
                    _newsSubCategory = null;
                  } else if (category == 'Shops') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopScreen()));
                  } else if (category == 'Tenders') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TendersScreen()));
                  } else {
                    _bottomIndex = 0;
                    _selectedNavIndex = NavigationData.mainNavItems.indexWhere((e) => e.title == category);
                    _activeSubCategory = null;
                  }
                } else if (isNews) {
                  _bottomIndex = 1;
                  _newsSubCategory = category;
                  _activeSubCategory = null;
                  _selectedNavIndex = 0;
                } else {
                  _bottomIndex = 0;
                  // Handle potential missing main category by defaulting or searching correctly
                  int targetMainIndex = -1;
                  for (int i = 0; i < NavigationData.mainNavItems.length; i++) {
                    if (NavigationData.mainNavItems[i].subItems?.contains(category) ?? false) {
                      targetMainIndex = i;
                      break;
                    }
                  }
                  
                  if (targetMainIndex != -1) {
                    _selectedNavIndex = targetMainIndex;
                    _activeSubCategory = category;
                    _newsSubCategory = null;
                  }
                }
                _isSearching = false;
                _searchController.clear();
              });
            },
          );
        } else {
          final item = newsResults[index - _searchResults.length];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(item.imageUrl, width: 40, height: 40, fit: BoxFit.cover),
            ),
            title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(item.category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(
                    title: item.title,
                    category: item.category,
                    date: item.time,
                    imageUrl: item.imageUrl,
                    content: item.content ?? '',
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildRecentSearchSection(String lang) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Icon(Icons.manage_search_rounded, size: 120, color: Colors.grey[200]),
        const SizedBox(height: 20),
        Text(
          AppTranslations.getText(lang, 'Search'),
          style: TextStyle(color: Colors.grey[400], fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Type any category, news topic, or document name above to search the entire Oromia Communication database.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Widget _buildNoResults(String lang) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.sentiment_dissatisfied, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text('No results found', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTopCategories(BuildContext context, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = NavigationData.mainNavItems.where((item) => 
      item.title != 'Home' && item.title != 'News' && item.title != 'Language' && item.title != 'About'
    ).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: InkWell(
            onTap: () => setState(() => _bottomIndex = 2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text("${AppTranslations.getText(lang, 'Search')}...", style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 54,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              final item = items[index];
              final realIndex = NavigationData.mainNavItems.indexWhere((e) => e.title == item.title);
              final sel = _selectedNavIndex == realIndex;
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: InkWell(
                  onTap: () {
                    if (item.title == 'Shops') {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ShopScreen()));
                      return;
                    }
                    if (item.title == 'Tenders') {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => const TendersScreen()));
                      return;
                    }
                    setState(() { _selectedNavIndex = realIndex; _activeSubCategory = null; });
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sel ? AppTheme.primaryBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: sel ? AppTheme.primaryBlue : Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon, size: 16, color: sel ? Colors.white : (isDark ? Colors.white70 : Colors.grey[700])),
                        const SizedBox(width: 8),
                        Text(
                          AppTranslations.getText(lang, item.title), 
                          style: TextStyle(
                            color: sel ? Colors.white : (isDark ? Colors.white70 : Colors.grey[700]), 
                            fontWeight: sel ? FontWeight.bold : FontWeight.w500,
                            fontSize: 13
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeFeed(BuildContext context, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final latestNews = MockData.getNewsByCategory('Latest').take(6).toList();

    return Column(
      children: [
        _buildHeroSection(lang),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTranslations.getText(lang, 'latest'), 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E))
                  ),
                  TextButton(
                    onPressed: () => setState(() => _bottomIndex = 1),
                    child: Text(AppTranslations.getText(lang, 'read_more'), style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestNews.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = latestNews[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailScreen(
                          title: item.title,
                          category: item.category,
                          date: item.time,
                          imageUrl: item.imageUrl,
                          content: item.content ?? '',
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.06), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(item.imageUrl, width: double.infinity, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 8, left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryBlue.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      AppTranslations.getText(lang, item.category).toUpperCase(),
                                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.title, 
                                    maxLines: 2, overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.2, color: isDark ? Colors.white : Colors.black),
                                  ),
                                  Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (sub == 'Contact Us') return ContactContent(lang: lang);
    if (sub == 'About Us') return AboutContent(lang: lang);
    
    // Check if it's a Media subcategory
    final mediaSubcategories = ['Press Release', 'Documentation', 'Video', 'Image & Gallery', 'Audio File'];
    if (mediaSubcategories.contains(sub)) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 24, color: AppTheme.primaryBlue, margin: const EdgeInsets.only(right: 12)),
                Text(
                  AppTranslations.getText(lang, sub), 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.primaryBlue)
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildMediaList(context, lang, sub),
          ],
        ),
      );
    }

    // Check if it's a Government subcategory
    final govSubcategories = ['Regional Sector', 'Zone', 'Woreda', 'City', 'Sub-city', 'Kebele'];
    if (govSubcategories.contains(sub)) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 24, color: AppTheme.primaryBlue, margin: const EdgeInsets.only(right: 12)),
                Text(
                  AppTranslations.getText(lang, sub), 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.primaryBlue)
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildGovernmentList(context, lang, sub),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 24, color: AppTheme.primaryBlue, margin: const EdgeInsets.only(right: 12)),
              Text(
                AppTranslations.getText(lang, sub), 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.primaryBlue)
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNewsList(context, lang, sub, itemCount: 10),
        ],
      ),
    );
  }

  Widget _buildGovernmentList(BuildContext context, String lang, String category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final entities = MockData.getEntitiesByCategory(category);

    if (entities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(Icons.account_balance, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 10),
              Text("No $category information available right now.", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entities.length,
      itemBuilder: (context, index) {
        final entity = entities[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => _buildEntityDetailSheet(context, entity, lang),
              );
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: Image.network(entity.imageUrl, width: 110, height: 110, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entity.name,
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entity.description,
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(AppTranslations.getText(lang, 'tap_for_details'), style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 11, fontWeight: FontWeight.bold)),
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

  Widget _buildEntityDetailSheet(BuildContext context, GovernmentEntity entity, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        child: Image.network(
                          entity.imageUrl, 
                          width: double.infinity, 
                          height: 250, 
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 250,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.4),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            AppTranslations.getText(lang, entity.category).toUpperCase(),
                            style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          entity.name, 
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black, height: 1.2)
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        Text(
                          AppTranslations.getText(lang, 'about'), 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entity.description, 
                          style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87, height: 1.6)
                        ),
                        const SizedBox(height: 24),
                        if (entity.address != null || entity.contact != null || entity.website != null) ...[
                          Text(
                            AppTranslations.getText(lang, 'contact_us'), 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)
                          ),
                          const SizedBox(height: 12),
                          if (entity.address != null) _buildInfoRow(Icons.location_on_outlined, entity.address!),
                          if (entity.contact != null) _buildInfoRow(Icons.phone_outlined, entity.contact!),
                          if (entity.website != null) _buildInfoRow(Icons.language_outlined, entity.website!, isLink: true),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppTranslations.getText(lang, 'close'), 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: TextStyle(color: isLink ? AppTheme.primaryBlue : Colors.grey[600], decoration: isLink ? TextDecoration.underline : null))),
        ],
      ),
    );
  }

  Widget _buildMediaList(BuildContext context, String lang, String category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaItems = MockData.getMediaByCategory(category);

    if (mediaItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(Icons.play_circle_outline, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 10),
              Text("No $category media available right now.", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final item = mediaItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: InkWell(
            onTap: () {
              if (item.type == MediaType.document) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(
                      title: item.title,
                      url: item.url,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaPlayerScreen(item: item),
                  ),
                );
              }
            },
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                      child: Image.network(item.thumbnail, width: 110, height: 110, fit: BoxFit.cover),
                    ),
                    _mediaIcon(_getMediaIcon(item.category)),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(_getMediaIcon(item.category), size: 14, color: AppTheme.primaryBlue),
                            const SizedBox(width: 6),
                            Text(AppTranslations.getText(lang, item.category).toUpperCase(), style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.title,
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                        ),
                        if (item.duration != null) ...[
                          const SizedBox(height: 8),
                          Text(item.duration!, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                        ],
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

  Widget _buildNewsList(BuildContext context, String lang, String category, {int itemCount = 3}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final kallachaItems = ['Weekly Newspaper', 'Quarterly Newspaper', 'Yearly Book', 'Brochure', 'Archive', 'File', 'Book'];
    bool isKallacha = kallachaItems.contains(category);

    if (!isKallacha) {
      final newsItems = MockData.getNewsByCategory(category);
      if (newsItems.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Icon(Icons.newspaper, size: 60, color: Colors.grey[300]),
                const SizedBox(height: 10),
                Text("No $category news available right now.", style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: newsItems.length > itemCount ? itemCount : newsItems.length,
        itemBuilder: (context, index) {
          final item = newsItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(
                    title: item.title,
                    category: item.category,
                    date: item.time,
                    imageUrl: item.imageUrl,
                    content: item.content ?? '',
                  ),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                    child: Image.network(item.imageUrl, width: 110, height: 110, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 110, height: 110, color: Colors.grey[200])),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.newspaper, size: 14, color: AppTheme.primaryBlue),
                              const SizedBox(width: 6),
                              Text(AppTranslations.getText(lang, item.category).toUpperCase(), style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.title,
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
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

    // Kallacha Logic
    final imageUrl = NavigationData.categoryImages[category];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerScreen(
                    title: "${AppTranslations.getText(lang, category)} - Vol ${20 + index}",
                    url: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                      child: imageUrl != null 
                        ? Image.network(imageUrl, width: 110, height: 110, fit: BoxFit.cover) 
                        : Container(width: 110, height: 110, color: Colors.grey[200]),
                    ),
                    _mediaIcon(Icons.picture_as_pdf, color: Colors.red),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.description, size: 14, color: AppTheme.primaryBlue),
                            const SizedBox(width: 6),
                            Text(AppTranslations.getText(lang, category).toUpperCase(), style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${AppTranslations.getText(lang, category)} - Vol ${20 + index}", 
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _actionButton(Icons.remove_red_eye_outlined, "READ", Colors.blue),
                            const SizedBox(width: 8),
                            _actionButton(Icons.download_for_offline_outlined, "PDF", Colors.green),
                          ],
                        ),
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

  Widget _mediaIcon(IconData icon, {Color color = Colors.white}) => Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24));
  Widget _actionButton(IconData icon, String label, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: Row(children: [Icon(icon, size: 12, color: color), const SizedBox(width: 4), Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold))]));

  Widget _buildSubGrid(BuildContext context, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final item = NavigationData.mainNavItems[_selectedNavIndex];
    final subItems = item.subItems!;
    final isMedia = item.title == 'Media';
    final isKallacha = item.title == 'Kallacha Oromiyaa';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16), width: double.infinity,
          decoration: BoxDecoration(color: isDark ? const Color(0xFF1F1F1F) : Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppTranslations.getText(lang, item.title), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.primaryBlue)),
                  Text("Explore all ${AppTranslations.getText(lang, item.title)} categories", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const Spacer(),
              TextButton(onPressed: () => setState(() => _selectedNavIndex = 0), child: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9),
            itemCount: subItems.length,
            itemBuilder: (context, index) {
              final sub = subItems[index];
              final imageUrl = NavigationData.categoryImages[sub];
              return InkWell(
                onTap: () => setState(() => _activeSubCategory = sub),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: imageUrl != null 
                                  ? Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[100], child: Icon(item.icon, color: Colors.grey)))
                                  : Container(color: AppTheme.primaryBlue.withOpacity(0.1), child: Icon(item.icon, color: AppTheme.primaryBlue)),
                            ),
                            if (isMedia) Center(child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), shape: BoxShape.circle), child: Icon(_getMediaIcon(sub), color: Colors.white, size: 24))),
                            if (isKallacha) Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: const Text('PDF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppTranslations.getText(lang, sub), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : const Color(0xFF1A237E)), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(isKallacha ? "Read Paper" : "Explore", style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getMediaIcon(String category) {
    if (category.contains('Video')) return Icons.play_arrow_rounded;
    if (category.contains('Audio')) return Icons.music_note_rounded;
    if (category.contains('Image')) return Icons.photo_library_rounded;
    return Icons.description_rounded;
  }

  Widget _buildNewsTab(BuildContext context, String lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (_newsSubCategory != null) return SingleChildScrollView(child: _buildSubCategoryContent(context, lang, _newsSubCategory!));
    final newsItem = NavigationData.mainNavItems.firstWhere((item) => item.title == 'News');
    final subItems = newsItem.subItems!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16), width: double.infinity,
          decoration: BoxDecoration(color: isDark ? const Color(0xFF1F1F1F) : AppTheme.primaryBlue.withOpacity(0.05), border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTranslations.getText(lang, 'news'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.primaryBlue)),
              const Text("Select a category to explore latest updates", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.1),
            itemCount: subItems.length,
            itemBuilder: (context, index) {
              final sub = subItems[index];
              final imageUrl = NavigationData.categoryImages[sub];
              return InkWell(
                onTap: () => setState(() => _newsSubCategory = sub),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: imageUrl != null 
                              ? Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover)
                              : Container(color: AppTheme.primaryBlue.withOpacity(0.1), child: const Icon(Icons.newspaper, color: AppTheme.primaryBlue)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(AppTranslations.getText(lang, sub), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab(BuildContext context, String lang) => const LoginScreen(isTab: true);
}
