// ============================================================
// NAHAM CUSTOMER APP — Purple theme, main nav, home, reels, orders, chat, profile
// ============================================================

import 'package:flutter/material.dart';

// ==================== COLORS (from AppDesignSystem) ====================
import 'package:naham_cook_app/core/theme/app_design_system.dart';
import 'package:naham_cook_app/core/widgets/naham_app_header.dart';
import 'package:naham_cook_app/core/widgets/naham_empty_screens.dart';

class NahamCustomerColors {
  static const Color primary = AppDesignSystem.primary;
  static const Color primaryDark = AppDesignSystem.primaryDark;
  static const Color primaryLight = AppDesignSystem.primaryLight;
  static const Color background = AppDesignSystem.backgroundOffWhite;
  static const Color cardBg = AppDesignSystem.cardWhite;
  static const Color textDark = AppDesignSystem.textPrimary;
  static const Color textGrey = AppDesignSystem.textSecondary;
  static const Color star = Color(0xFFFFC107);
  static const Color categoryBg = Color(0xFFEDE9FE);
  static const Color bottomNavBg = AppDesignSystem.bottomNavBackground;
  static const Color bannerPink = Color(0xFFEC4899);
  static const Color cardGradientStart = Color(0xFFEDE9FE);
  static const Color cardGradientEnd = Color(0xFFF5F3FF);
  static const Color ratingBg = Color(0xFFFFF7ED);

  static const String logoAsset = AppDesignSystem.logoAsset;
}

/// Shared header for all customer screens: purple #9B7FD4, logo + "Naham" white.
/// When [title] is set (e.g. "Chat", "My Orders", "My Profile"), it is perfectly centered between left and right.
Widget nahamCustomerHeader({
  String? title,
  List<Widget>? actions,
}) {
  return Container(
    width: double.infinity,
    color: NahamCustomerColors.primary,
    padding: const EdgeInsets.only(
      top: 12,
      bottom: 12,
      left: 16,
      right: 16,
    ),
    child: SafeArea(
      bottom: false,
      child: Row(
        children: [
          // Left: logo + Naham (fixed width so right can match for balance)
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      NahamCustomerColors.logoAsset,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Naham',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Center: title (takes remaining space, text centered)
          Expanded(
            child: title != null
                ? Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : const SizedBox.shrink(),
          ),
          // Right: actions (same width as left for perfect title centering)
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerRight,
              child: actions != null && actions!.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions!,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    ),
  );
}

// ==================== MAIN NAVIGATION ====================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // Home, Reels, Orders, Chat, Profile
  int _cartCount = 0;

  void _addToCart() {
    setState(() {
      _cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      NahamCustomerHomeScreen(
          onAddToCart: _addToCart, cartCount: _cartCount),
      const NahamCustomerReelsScreen(),
      const NahamCustomerOrdersScreen(),
      const NahamCustomerChatScreen(),
      const NahamCustomerProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Nav bar order: Reels, Orders, Home, Chat, Profile — all items same style
  static const List<int> _navToScreenIndex = [1, 2, 0, 3, 4];

  Widget _buildBottomNav() {
    const labels = ['Reels', 'Orders', 'Home', 'Chat', 'Profile'];
    const icons = [
      (Icons.play_circle_outline_rounded, Icons.play_circle_rounded),
      (Icons.shopping_bag_outlined, Icons.shopping_bag_rounded),
      (Icons.home_outlined, Icons.home_rounded),
      (Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded),
      (Icons.person_outline_rounded, Icons.person_rounded),
    ];
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: NahamCustomerColors.bottomNavBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (navIndex) {
            final screenIndex = _navToScreenIndex[navIndex];
            final isActive = _currentIndex == screenIndex;
            final activeColor = NahamCustomerColors.primaryDark;
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = screenIndex),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isActive
                          ? activeColor.withOpacity(0.25)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isActive ? icons[navIndex].$2 : icons[navIndex].$1,
                      size: 24,
                      color: isActive
                          ? activeColor
                          : NahamCustomerColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[navIndex],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive
                          ? activeColor
                          : NahamCustomerColors.textGrey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ==================== HOME SCREEN (Flutter) ====================
class NahamCustomerHomeScreen extends StatefulWidget {
  final VoidCallback onAddToCart;
  final int cartCount;

  const NahamCustomerHomeScreen({
    super.key,
    required this.onAddToCart,
    required this.cartCount,
  });

  @override
  State<NahamCustomerHomeScreen> createState() =>
      _NahamCustomerHomeScreenState();
}

class _NahamCustomerHomeScreenState extends State<NahamCustomerHomeScreen> {
  String _activeCategory = 'Northern';

  // Cuisine Regions (Figma)
  static const _categories = [
    'Northern',
    'Eastern',
    'Southern',
    'Najdi',
    'Western',
  ];

  // Local asset images for each region (top image in chips)
  static const Map<String, String> _categoryAssets = {
    'Northern': 'assets/images/nt.png',
    'Eastern': 'assets/images/es.png',
    'Southern': 'assets/images/so.png',
    'Najdi': 'assets/images/nj.png',
    'Western': 'assets/images/w.png',
  };

  static final _kitchens = [
    {
      'name': "Maria's Kitchen",
      'rating': 4.9,
      'img': '🍝',
      'dish': 'Creamy Truffle Pasta',
      'cuisine': 'إيطالي',
      'distance': '1.2 km',
      'time': '25-35 دقيقة',
      'badge': 'الأكثر طلباً',
    },
    {
      'name': 'Chef Qasim',
      'rating': 4.7,
      'img': '🍛',
      'dish': 'Kabsa Riyadh Style',
      'cuisine': 'عربي',
      'distance': '0.8 km',
      'time': '20-30 دقيقة',
      'badge': null,
    },
    {
      'name': "Sarah's Home",
      'rating': 4.8,
      'img': '🥗',
      'dish': 'Quinoa Pomegranate Salad',
      'cuisine': 'صحي',
      'distance': '2.1 km',
      'time': '30-40 دقيقة',
      'badge': 'جديد',
    },
    {
      'name': 'Um Khalid',
      'rating': 4.6,
      'img': '🍲',
      'dish': 'Traditional Jareesh',
      'cuisine': 'كويتي',
      'distance': '1.5 km',
      'time': '35-45 دقيقة',
      'badge': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    _buildCategoryChips(),
                    _buildPopularDishes(context),
                    _buildBanner(),
                    _buildFamousCooks(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return NahamAppHeader(
      cartCount: widget.cartCount,
      showSearchBar: false,
      onSearch: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NahamCustomerSearchScreen(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: _categories.map((c) {
          final isActive = _activeCategory == c;
          final assetPath = _categoryAssets[c];
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => _activeCategory = c),
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? NahamCustomerColors.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: NahamCustomerColors.primary
                                  .withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (assetPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            assetPath,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: NahamCustomerColors.categoryBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                NahamCustomerColors.logoAsset,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_rounded, color: NahamCustomerColors.primary, size: 24),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                        c,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : NahamCustomerColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPopularDishes(BuildContext context) {
    final dishes = [
      {'name': 'Gereesh', 'price': '20.0 SR'},
      {'name': 'Qrsan', 'price': '22.0 SR'},
      {'name': 'Mandy Laham', 'price': '90.0 SR'},
      {'name': 'Cream', 'price': '35.0 SR'},
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Dishes',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: NahamCustomerColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
            children: dishes.map((d) => _PopularDishCard(
                  name: d['name']!,
                  price: d['price']!,
                  onAddToCart: widget.onAddToCart,
                )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            NahamCustomerColors.primary,
            NahamCustomerColors.bannerPink,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عرض اليوم',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'خصم 20%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'على أول طلب لك 🎉',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          const Text('🍽️', style: TextStyle(fontSize: 60)),
        ],
      ),
    );
  }

  Widget _buildFamousCooks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Famous Cooks',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: NahamCustomerColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ..._kitchens.map((k) => _KitchenCard(
                name: k['name'] as String,
                rating: k['rating'] as double,
                img: k['img'] as String,
                dish: k['dish'] as String,
                cuisine: k['cuisine'] as String,
                distance: k['distance'] as String,
                time: k['time'] as String,
                badge: k['badge'] as String?,
                onAddToCart: widget.onAddToCart,
              )),
        ],
      ),
    );
  }
}

class _PopularDishCard extends StatelessWidget {
  final String name;
  final String price;
  final VoidCallback onAddToCart;

  const _PopularDishCard({
    required this.name,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NahamCustomerColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    NahamCustomerColors.cardGradientStart,
                    NahamCustomerColors.cardGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Image.asset(
                  NahamCustomerColors.logoAsset,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_rounded, size: 32, color: NahamCustomerColors.primary),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: NahamCustomerColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: NahamCustomerColors.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: NahamCustomerColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KitchenCard extends StatelessWidget {
  final String name;
  final double rating;
  final String img;
  final String dish;
  final String cuisine;
  final String distance;
  final String time;
  final String? badge;
  final VoidCallback onAddToCart;

  const _KitchenCard({
    required this.name,
    required this.rating,
    required this.img,
    required this.dish,
    required this.cuisine,
    required this.distance,
    required this.time,
    this.badge,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: NahamCustomerColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: NahamCustomerColors.categoryBg,
                  child: Text(
                    img,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: NahamCustomerColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: NahamCustomerColors.ratingBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('⭐', style: TextStyle(fontSize: 12)),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: NahamCustomerColors.star,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dish,
                        style: const TextStyle(
                          fontSize: 13,
                          color: NahamCustomerColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (badge != null) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: NahamCustomerColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '📍 $distance',
                  style: const TextStyle(
                    fontSize: 13,
                    color: NahamCustomerColors.textGrey,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '⏱ $time',
                  style: const TextStyle(
                    fontSize: 13,
                    color: NahamCustomerColors.textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onAddToCart,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          NahamCustomerColors.primary,
                          NahamCustomerColors.primaryLight,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'أضف للسلة +',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== REELS SCREEN ====================
class NahamCustomerReelsScreen extends StatefulWidget {
  const NahamCustomerReelsScreen({super.key});

  @override
  State<NahamCustomerReelsScreen> createState() =>
      _NahamCustomerReelsScreenState();
}

class _NahamCustomerReelsScreenState extends State<NahamCustomerReelsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _reels = [
    {'chef': "Maria's Kitchen", 'dish': 'Kabsa', 'likes': '1.2k'},
    {'chef': 'Chef Qasm', 'dish': 'Mandi', 'likes': '890'},
    {'chef': "Om Saleh's Kitchen", 'dish': 'Jareesh', 'likes': '2.3k'},
    {'chef': 'Chef Ahmed', 'dish': 'Saleeg', 'likes': '456'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _reels.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          return _buildReelItem(_reels[index], context);
        },
      ),
    );
  }

  Widget _buildReelItem(Map<String, String> reel, BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                NahamCustomerColors.primary.withOpacity(0.8),
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              NahamCustomerColors.logoAsset,
              width: 72,
              height: 72,
              fit: BoxFit.contain,
              color: Colors.white30,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_rounded, size: 64, color: Colors.white24),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: nahamCustomerHeader(
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: NahamCustomerColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person,
                        color: NahamCustomerColors.primaryDark),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    reel['chef']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                reel['dish']!,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          right: 16,
          child: Column(
            children: [
              _reelAction(Icons.favorite_border, reel['likes']!),
              const SizedBox(height: 20),
              _reelAction(Icons.comment_outlined, 'Comment'),
              const SizedBox(height: 20),
              _reelAction(Icons.share_outlined, 'Share'),
              const SizedBox(height: 20),
              _reelAction(Icons.add_shopping_cart, 'Order'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reelAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}

// ==================== ORDERS SCREEN ====================
class NahamCustomerOrdersScreen extends StatefulWidget {
  const NahamCustomerOrdersScreen({super.key});

  @override
  State<NahamCustomerOrdersScreen> createState() =>
      _NahamCustomerOrdersScreenState();
}

class _NahamCustomerOrdersScreenState extends State<NahamCustomerOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          nahamCustomerHeader(title: 'My Orders'),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: NahamCustomerColors.primaryDark,
              labelColor: NahamCustomerColors.primaryDark,
              unselectedLabelColor: NahamCustomerColors.textGrey,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveOrders(),
                _buildCompletedOrders(),
                _buildCancelledOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _orderCard(
          name: 'greesh',
          chef: "Maria's Kitchen",
          status: 'Out for Delivery',
          statusColor: Colors.green,
          price: '20',
          time: '13:28 GM',
          showTrack: true,
          showCall: true,
        ),
        _orderCard(
          name: 'qishd',
          chef: 'on saleh\'s Kitchen',
          status: 'Preparing',
          statusColor: NahamCustomerColors.primary,
          price: '25',
          time: '14:05 GM',
          showTrack: true,
          showCall: false,
        ),
      ],
    );
  }

  Widget _buildCompletedOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _orderCard(
          name: 'cremah',
          chef: "om saleh's Kitchen",
          status: 'Order Delivered',
          statusColor: Colors.green,
          price: '35',
          time: '12:00 GM',
          showTrack: false,
          showCall: false,
          showRate: true,
        ),
      ],
    );
  }

  Widget _buildCancelledOrders() {
    const cancelledList = <Widget>[];
    if (cancelledList.isEmpty) {
      return const Center(child: EmptyOrdersScreen(fullScreen: false));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _orderCard(
          name: 'qishied',
          chef: "on saleh's Kitchen",
          status: 'Cancelled',
          statusColor: Colors.red,
          price: '22',
          time: '10:30 GM',
          showTrack: false,
          showCall: false,
          showReorder: true,
        ),
      ],
    );
  }

  Widget _orderCard({
    required String name,
    required String chef,
    required String status,
    required Color statusColor,
    required String price,
    required String time,
    required bool showTrack,
    required bool showCall,
    bool showRate = false,
    bool showReorder = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NahamCustomerColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(time,
                  style: const TextStyle(
                      color: NahamCustomerColors.textGrey,
                      fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: NahamCustomerColors.primaryLight
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  NahamCustomerColors.logoAsset,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_rounded, color: NahamCustomerColors.primary, size: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(chef,
                        style: const TextStyle(
                            color: NahamCustomerColors.textGrey,
                            fontSize: 12)),
                  ],
                ),
              ),
              Text(
                '$price SR',
                style: const TextStyle(
                  color: NahamCustomerColors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          if (showTrack || showCall || showRate || showReorder) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (showTrack)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: NahamCustomerColors.primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Track Order',
                          style: TextStyle(
                              color: NahamCustomerColors.primary)),
                    ),
                  ),
                if (showTrack && showCall) const SizedBox(width: 8),
                if (showCall)
                  Container(
                    decoration: BoxDecoration(
                      color: NahamCustomerColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone,
                          color: Colors.white, size: 20),
                    ),
                  ),
                if (showRate)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NahamCustomerColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Rate Now',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                if (showReorder) ...[
                  Text('Needs payment',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NahamCustomerColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Reorder',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ==================== CHAT SCREEN ====================
class NahamCustomerChatScreen extends StatelessWidget {
  const NahamCustomerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': "Maria's Kitchen",
        'last': 'Your order is ready!',
        'time': '2:30 PM',
        'unread': '2'
      },
      {
        'name': 'Chef Qasm',
        'last': 'Thank you for your order',
        'time': '1:15 PM',
        'unread': '0'
      },
      {
        'name': "Om Saleh's Kitchen",
        'last': 'We are preparing your food',
        'time': 'Yesterday',
        'unread': '0'
      },
    ];

    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          nahamCustomerHeader(
            title: 'Chat',
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final hasUnread = chat['unread'] != '0';
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NahamCustomerChatConversationScreen(
                        name: chat['name']!,
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: NahamCustomerColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: NahamCustomerColors.primaryLight
                              .withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person,
                            color: NahamCustomerColors.primaryDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat['name']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              chat['last']!,
                              style: const TextStyle(
                                  color: NahamCustomerColors.textGrey,
                                  fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(chat['time']!,
                              style: const TextStyle(
                                  color: NahamCustomerColors.textGrey,
                                  fontSize: 11)),
                          if (hasUnread) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: NahamCustomerColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chat['unread']!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CHAT CONVERSATION SCREEN ====================
class NahamCustomerChatConversationScreen extends StatefulWidget {
  final String name;

  const NahamCustomerChatConversationScreen({super.key, required this.name});

  @override
  State<NahamCustomerChatConversationScreen> createState() =>
      _NahamCustomerChatConversationScreenState();
}

class _NahamCustomerChatConversationScreenState
    extends State<NahamCustomerChatConversationScreen> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hi! How can I help you today?', 'isMe': false, 'time': '2:28 PM'},
    {'text': 'When will my order be ready?', 'isMe': true, 'time': '2:30 PM'},
    {'text': 'Your order is ready for pickup!', 'isMe': false, 'time': '2:30 PM'},
  ];

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': _ctrl.text.trim(),
        'isMe': true,
        'time': 'Now',
      });
      _ctrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                final isMe = msg['isMe'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMe
                                ? NahamCustomerColors.primary
                                : NahamCustomerColors.cardBg,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: Radius.circular(isMe ? 18 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            msg['text'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: isMe
                                  ? Colors.white
                                  : NahamCustomerColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            decoration: BoxDecoration(
              color: NahamCustomerColors.cardBg,
              border: Border(
                top: BorderSide(color: NahamCustomerColors.primary.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(
                          color: NahamCustomerColors.textGrey, fontSize: 14),
                      filled: true,
                      fillColor: NahamCustomerColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: NahamCustomerColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: NahamCustomerColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SEARCH SCREEN ====================
class NahamCustomerSearchScreen extends StatefulWidget {
  const NahamCustomerSearchScreen({super.key});

  @override
  State<NahamCustomerSearchScreen> createState() =>
      _NahamCustomerSearchScreenState();
}

class _NahamCustomerSearchScreenState
    extends State<NahamCustomerSearchScreen> {
  final _searchCtrl = TextEditingController();

  final List<Map<String, String>> _mockResults = [
    {
      'title': "Maria's Kitchen",
      'subtitle': 'Kabsa, Mandi, Daily Specials',
      'type': 'Kitchen',
    },
    {
      'title': 'Chicken Kabsa',
      'subtitle': "Maria's Kitchen · 45 SAR",
      'type': 'Dish',
    },
    {
      'title': 'Mandi Laham',
      'subtitle': 'Chef Qasm · 90 SAR',
      'type': 'Dish',
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search for a dish or kitchen...',
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _mockResults.length,
              itemBuilder: (context, index) {
                final r = _mockResults[index];
                final isKitchen = r['type'] == 'Kitchen';
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: NahamCustomerColors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: NahamCustomerColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isKitchen
                              ? Icons.storefront_rounded
                              : Icons.restaurant_rounded,
                          color: NahamCustomerColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: NahamCustomerColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              r['subtitle']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: NahamCustomerColors.textGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PROFILE SCREEN ====================
class NahamCustomerProfileScreen extends StatelessWidget {
  const NahamCustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          nahamCustomerHeader(title: 'My Profile'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 20),
                  _buildProfileOptions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: NahamCustomerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.person,
                    size: 50, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt,
                      size: 16,
                      color: NahamCustomerColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Ahmad Ali',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'Member since 2024',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statItem('142', 'Orders'),
              Container(
                  width: 1, height: 30, color: Colors.white30),
              _statItem('583', 'Points'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _optionCard(
            context: context,
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            subtitle: 'Name, phone, location',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NahamCustomerEditProfileScreen(),
              ),
            ),
          ),
          _optionCard(
            context: context,
            icon: Icons.favorite_border,
            title: 'Favorites',
            subtitle: 'Saved cooks & dishes',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NahamCustomerFavoritesScreen(),
              ),
            ),
          ),
          _optionCard(
            context: context,
            icon: Icons.headset_mic_outlined,
            title: 'Support',
            subtitle: 'Chat with admins',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NahamCustomerChatConversationScreen(
                  name: 'Naham Support',
                ),
              ),
            ),
          ),
          _optionCard(
            context: context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Notification settings',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NahamCustomerNotificationsScreen(),
              ),
            ),
          ),
          _optionCard(
            context: context,
            icon: Icons.location_on_outlined,
            title: 'My Addresses',
            subtitle: 'Saved delivery locations',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NahamCustomerAddressesScreen(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Logout',
                  style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NahamCustomerColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: NahamCustomerColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: NahamCustomerColors.primary, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: NahamCustomerColors.textGrey,
                          fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: NahamCustomerColors.textGrey),
          ],
        ),
      ),
    );
  }
}

// ==================== EDIT PROFILE SCREEN ====================
class NahamCustomerEditProfileScreen extends StatefulWidget {
  const NahamCustomerEditProfileScreen({super.key});

  @override
  State<NahamCustomerEditProfileScreen> createState() =>
      _NahamCustomerEditProfileScreenState();
}

class _NahamCustomerEditProfileScreenState
    extends State<NahamCustomerEditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'Ahmad Ali');
  final _phoneCtrl = TextEditingController(text: '+966 50 123 4567');
  final _locationCtrl = TextEditingController(text: 'Riyadh, Al-Olaya');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: NahamCustomerColors.primaryLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: NahamCustomerColors.primary.withOpacity(0.3),
                          width: 3),
                    ),
                    child: const Icon(Icons.person, size: 50,
                        color: NahamCustomerColors.primary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: NahamCustomerColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white,
                          size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel('Full Name'),
            const SizedBox(height: 6),
            _buildField(_nameCtrl),
            const SizedBox(height: 16),
            _buildLabel('Phone Number'),
            const SizedBox(height: 6),
            _buildField(_phoneCtrl, keyboard: TextInputType.phone),
            const SizedBox(height: 16),
            _buildLabel('Location'),
            const SizedBox(height: 6),
            _buildField(_locationCtrl),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: NahamCustomerColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Save Changes',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: NahamCustomerColors.textGrey,
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl,
      {TextInputType? keyboard}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: NahamCustomerColors.textDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: NahamCustomerColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: NahamCustomerColors.primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// ==================== FAVORITES SCREEN ====================
class NahamCustomerFavoritesScreen extends StatelessWidget {
  const NahamCustomerFavoritesScreen({super.key});

  static final _savedCooks = [
    {'name': "Maria's Kitchen", 'dish': 'Kabsa', 'rating': 4.9, 'emoji': '🍝'},
    {'name': 'Chef Qasm', 'dish': 'Mandi', 'rating': 4.7, 'emoji': '🍲'},
  ];
  static final _savedDishes = [
    {'name': 'Chicken Kabsa', 'cook': "Maria's Kitchen", 'price': '45 SAR'},
    {'name': 'Lamb Mandi', 'cook': 'Chef Qasm', 'price': '55 SAR'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Favorites'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saved Cooks',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: NahamCustomerColors.textDark)),
            const SizedBox(height: 12),
            ..._savedCooks.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: NahamCustomerColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: NahamCustomerColors.primaryLight,
                        child: Text((c['emoji'] as String), style: const TextStyle(fontSize: 28)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c['name'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                            Text(c['dish'] as String,
                                style: const TextStyle(
                                    color: NahamCustomerColors.textGrey,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Text('⭐ ${c['rating']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: NahamCustomerColors.star)),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            const Text('Saved Dishes',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: NahamCustomerColors.textDark)),
            const SizedBox(height: 12),
            ..._savedDishes.map((d) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: NahamCustomerColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: NahamCustomerColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.restaurant_rounded,
                            color: NahamCustomerColors.primary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d['name'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                            Text(d['cook'] as String,
                                style: const TextStyle(
                                    color: NahamCustomerColors.textGrey,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Text(d['price'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: NahamCustomerColors.primary)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// ==================== NOTIFICATIONS SCREEN ====================
class NahamCustomerNotificationsScreen extends StatefulWidget {
  const NahamCustomerNotificationsScreen({super.key});

  @override
  State<NahamCustomerNotificationsScreen> createState() =>
      _NahamCustomerNotificationsScreenState();
}

class _NahamCustomerNotificationsScreenState
    extends State<NahamCustomerNotificationsScreen> {
  bool _orderUpdates = true;
  bool _promos = false;
  bool _chat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _switchRow('Order updates', 'Get notified when order status changes',
              _orderUpdates, (v) => setState(() => _orderUpdates = v)),
          _switchRow('Promotions', 'Offers and discounts',
              _promos, (v) => setState(() => _promos = v)),
          _switchRow('Chat messages', 'New message alerts',
              _chat, (v) => setState(() => _chat = v)),
        ],
      ),
    );
  }

  Widget _switchRow(
      String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NahamCustomerColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: NahamCustomerColors.textDark)),
                Text(subtitle,
                    style: const TextStyle(
                        color: NahamCustomerColors.textGrey,
                        fontSize: 12)),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: NahamCustomerColors.primary,
              ),
            ),
            child: Switch(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

// ==================== ADDRESSES SCREEN ====================
class NahamCustomerAddressesScreen extends StatefulWidget {
  const NahamCustomerAddressesScreen({super.key});

  @override
  State<NahamCustomerAddressesScreen> createState() =>
      _NahamCustomerAddressesScreenState();
}

class _NahamCustomerAddressesScreenState
    extends State<NahamCustomerAddressesScreen> {
  final List<Map<String, String>> _addresses = [
    {'label': 'Home', 'address': 'Riyadh, Al-Olaya, Building 12'},
    {'label': 'Office', 'address': 'Riyadh, King Fahd Rd, Tower A'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      appBar: AppBar(
        backgroundColor: NahamCustomerColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Addresses'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._addresses.map((a) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: NahamCustomerColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: NahamCustomerColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.location_on_rounded,
                          color: NahamCustomerColors.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['label']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                          Text(a['address']!,
                              style: const TextStyle(
                                  color: NahamCustomerColors.textGrey,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined,
                          color: NahamCustomerColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded,
                  color: NahamCustomerColors.primary),
              label: const Text('Add new address',
                  style: TextStyle(
                      color: NahamCustomerColors.primary,
                      fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: NahamCustomerColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== WEB NAV BAR & HEADER (DESKTOP) ====================
class NahamCustomerWebNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const NahamCustomerWebNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Home', Icons.home_rounded),
      ('Reels', Icons.play_circle_rounded),
      ('Orders', Icons.receipt_long_rounded),
      ('Chat', Icons.chat_bubble_rounded),
      ('Profile', Icons.person_rounded),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: NahamCustomerColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  NahamCustomerColors.logoAsset,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Naham',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: List.generate(items.length, (index) {
              final isActive = index == currentIndex;
              final (label, icon) = items[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => onItemSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white
                          : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: isActive
                              ? NahamCustomerColors.primaryDark
                              : Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            color: isActive
                                ? NahamCustomerColors.primaryDark
                                : Colors.white,
                            fontSize: 13,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  tooltip: 'Notifications',
                ),
                const SizedBox(width: 4),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: NahamCustomerColors.primaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NahamCustomerWebHeader extends StatelessWidget {
  const NahamCustomerWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NahamCustomerColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اطلب أكل بيت بنكهة المطابخ الشعبية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اكتشف أفضل المطابخ المنزلية حولك، اطلب خلال ثواني وتابع طلبك لحظة بلحظة.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: NahamCustomerColors.textGrey,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'ابحث عن طبق أو مطبخ...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: NahamCustomerColors.primaryDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                icon: const Icon(Icons.location_on_rounded, size: 18),
                label: const Text(
                  'اختر موقعك',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _NahamWebStatChip(value: '+200', label: 'مطعم منزلي'),
              SizedBox(width: 10),
              _NahamWebStatChip(value: '20-30 دقيقة', label: 'متوسط التوصيل'),
              SizedBox(width: 10),
              _NahamWebStatChip(value: '4.8', label: 'متوسط التقييم'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NahamWebStatChip extends StatelessWidget {
  final String value;
  final String label;

  const _NahamWebStatChip({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

