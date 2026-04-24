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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;
  int _selectedNavIndex = 0; 
  String? _activeSubCategory;
  String? _newsSubCategory; // Track sub-category specifically for News tab
  
  // Search state
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isSearching = false;

  // Get all possible categories for searching (Full Deep Search)
  List<String> _getAllCategories() {
    List<String> all = [];
    for (var item in NavigationData.mainNavItems) {
      all.add(item.title); // Add main titles (News, Media, etc)
      if (item.subItems != null) {
        all.addAll(item.subItems!);
      }
    }
    return all.toSet().toList(); // Remove duplicates
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
      _newsSubCategory = null; // Reset news sub-category when switching tabs
      if (index == 0) _selectedNavIndex = 0;
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

  // --- HOME TAB ---
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

  // --- SEARCH TAB (FULL FUNCTIONAL) ---
  Widget _buildSearchTab(BuildContext context, String lang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
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
              fillColor: Colors.grey[100],
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
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final category = _searchResults[index];
        // Determine where this category belongs
        bool isNews = false;
        bool isMain = NavigationData.mainNavItems.any((e) => e.title == category);
        
        try {
          isNews = NavigationData.mainNavItems.firstWhere((e) => e.title == 'News').subItems!.contains(category);
        } catch (_) {}
        
        return ListTile(
          leading: Icon(isNews ? Icons.newspaper : (isMain ? Icons.star_border : Icons.grid_view), color: AppTheme.primaryBlue),
          title: Text(AppTranslations.getText(lang, category)),
          subtitle: Text("Jump to $category section"),
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
                _bottomIndex = 1; // Go to News Tab
                _newsSubCategory = category;
                _activeSubCategory = null;
                _selectedNavIndex = 0;
              } else {
                _bottomIndex = 0; // Go to Home Tab
                // Find which top-nav item it belongs to
                for (int i = 0; i < NavigationData.mainNavItems.length; i++) {
                  if (NavigationData.mainNavItems[i].subItems?.contains(category) ?? false) {
                    _selectedNavIndex = i;
                    break;
                  }
                }
                _activeSubCategory = category;
                _newsSubCategory = null;
              }
              _isSearching = false;
              _searchController.clear();
            });
          },
        );
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
          AppTranslations.getText(lang, 'search'),
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

  // --- OTHER UI HELPERS (Unchanged) ---
  Widget _buildTopCategories(BuildContext context, String lang) {
    // Show ALL navigation items except Home, News (removed as requested), Language, and About
    final items = NavigationData.mainNavItems.where((item) => 
      item.title != 'Home' && item.title != 'News' && item.title != 'Language' && item.title != 'About'
    ).toList();

    return Column(
      children: [
        // Added Search Bar directly in the Home Tab for better accessibility
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: InkWell(
            onTap: () => setState(() => _bottomIndex = 2), // Jump to search tab
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
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
                    if (item.title == 'News') {
                       setState(() { _bottomIndex = 1; _newsSubCategory = null; });
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
                        Icon(item.icon, size: 16, color: sel ? Colors.white : Colors.grey[700]),
                        const SizedBox(width: 8),
                        Text(
                          AppTranslations.getText(lang, item.title), 
                          style: TextStyle(
                            color: sel ? Colors.white : Colors.grey[700], 
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
    // Get actual subcategories from News for the latest grid
    final newsItem = NavigationData.mainNavItems.firstWhere((item) => item.title == 'News');
    final latestCategories = newsItem.subItems?.take(6).toList() ?? [];

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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))
                  ),
                  TextButton(
                    onPressed: () => setState(() => _bottomIndex = 1),
                    child: Text(AppTranslations.getText(lang, 'read_more'), style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Unified Two-Column Box Layout for Latest Items
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final cat = latestCategories[index];
                  final imageUrl = NavigationData.categoryImages[cat];
                  
                  return InkWell(
                    onTap: () => setState(() {
                      _bottomIndex = 1;
                      _newsSubCategory = cat;
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
                                  child: imageUrl != null 
                                    ? Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover)
                                    : Container(color: Colors.grey[200]),
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
                                      AppTranslations.getText(lang, cat).toUpperCase(),
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
                                    "Latest updates on $cat in Oromia region...", 
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.2),
                                  ),
                                  Text(
                                    "2 hours ago", 
                                    style: TextStyle(color: Colors.grey[500], fontSize: 10),
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
    if (sub == 'Contact Us') return ContactContent(lang: lang);
    if (sub == 'About Us') return AboutContent(lang: lang);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4, height: 24,
                color: AppTheme.primaryBlue,
                margin: const EdgeInsets.only(right: 12),
              ),
              Text(
                AppTranslations.getText(lang, sub), 
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNewsList(context, lang, sub, itemCount: 10), // Increased itemCount for "Full" view
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, String lang, String category, {int itemCount = 3}) {
    final imageUrl = NavigationData.categoryImages[category];
    
    // Check category types
    bool isVideo = category == 'Video';
    bool isAudio = category == 'Audio File';
    bool isGallery = category == 'Image & Gallery';
    
    // Kallacha items (Newspapers, Books, Files)
    final kallachaItems = ['Weekly Newspaper', 'Quarterly Newspaper', 'Yearly Book', 'Brochure', 'Archive', 'File', 'Book'];
    bool isKallacha = kallachaItems.contains(category);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: InkWell(
            onTap: () {},
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
                    if (isVideo) 
                      _mediaIcon(Icons.play_arrow),
                    if (isAudio)
                      _mediaIcon(Icons.music_note),
                    if (isKallacha)
                      _mediaIcon(Icons.picture_as_pdf, color: Colors.red),
                    if (isGallery)
                      Positioned(
                        bottom: 8, right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.collections, color: Colors.white, size: 14),
                        ),
                      ),
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
                            Icon(
                              isKallacha ? Icons.description : (isVideo ? Icons.videocam : (isAudio ? Icons.headset : Icons.newspaper)),
                              size: 14, color: AppTheme.primaryBlue,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              AppTranslations.getText(lang, category).toUpperCase(), 
                              style: const TextStyle(color: AppTheme.primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isKallacha ? "${AppTranslations.getText(lang, category)} - Vol ${20 + index}" : AppTranslations.getText(lang, 'read_more') + '...', 
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        if (isKallacha)
                          Row(
                            children: [
                              _actionButton(Icons.remove_red_eye_outlined, "READ", Colors.blue),
                              const SizedBox(width: 8),
                              _actionButton(Icons.download_for_offline_outlined, "PDF", Colors.green),
                            ],
                          )
                        else
                          Text("2 hours ago", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
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

  Widget _mediaIcon(IconData icon, {Color color = Colors.white}) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
    child: Icon(icon, color: color, size: 24),
  );

  Widget _actionButton(IconData icon, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: color.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _buildSubGrid(BuildContext context, String lang) {
    final item = NavigationData.mainNavItems[_selectedNavIndex];
    final subItems = item.subItems!;
    final isMedia = item.title == 'Media';
    final isKallacha = item.title == 'Kallacha Oromiyaa';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTranslations.getText(lang, item.title),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                  ),
                  Text("Explore all ${item.title} categories", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() => _selectedNavIndex = 0),
                child: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: subItems.length,
            itemBuilder: (context, index) {
              final sub = subItems[index];
              final imageUrl = NavigationData.categoryImages[sub];
              return InkWell(
                onTap: () => setState(() => _activeSubCategory = sub),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
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
                                  ? Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[100], child: Icon(item.icon, color: Colors.grey)),
                                    )
                                  : Container(color: AppTheme.primaryBlue.withOpacity(0.1), child: Icon(item.icon, color: AppTheme.primaryBlue)),
                            ),
                            if (isMedia)
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), shape: BoxShape.circle),
                                  child: Icon(_getMediaIcon(sub), color: Colors.white, size: 24),
                                ),
                              ),
                            if (isKallacha)
                              Positioned(
                                top: 8, right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                                  child: const Text('PDF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppTranslations.getText(lang, sub),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1A237E)),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
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
    if (_newsSubCategory != null) {
      return SingleChildScrollView(
        child: _buildSubCategoryContent(context, lang, _newsSubCategory!),
      );
    }

    final newsItem = NavigationData.mainNavItems.firstWhere((item) => item.title == 'News');
    final subItems = newsItem.subItems!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.05),
            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.getText(lang, 'News'),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
              ),
              const Text("Select a category to explore latest updates", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: subItems.length,
            itemBuilder: (context, index) {
              final sub = subItems[index];
              final imageUrl = NavigationData.categoryImages[sub];
              return InkWell(
                onTap: () => setState(() => _newsSubCategory = sub),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
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
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            AppTranslations.getText(lang, sub),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

  Widget _buildProfileTab(BuildContext context, String lang) => const LoginScreen(isTab: true);
}
