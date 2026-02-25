// ============================================================
// COOK REELS — Same layout & design as Customer Reels (purple theme)
// ============================================================

import 'package:flutter/material.dart';

import '../../customer/naham_customer_screens.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _reels = [
    {'chef': "Maria's Kitchen", 'dish': 'Kabsa', 'likes': '1.2k'},
    {'chef': 'Chef Qasm', 'dish': 'Mandi', 'likes': '890'},
    {'chef': "Om Saleh's Kitchen", 'dish': 'Jareesh', 'likes': '2.3k'},
    {'chef': 'Chef Ahmed', 'dish': 'Saleeg', 'likes': '456'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                    child: const Icon(Icons.person, color: NahamCustomerColors.primaryDark),
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
                style: const TextStyle(color: Colors.white70, fontSize: 14),
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
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}
