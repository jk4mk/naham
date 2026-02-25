// ============================================================
// COOK MENU SCREEN — Naham App
// Header #9B7EC8 (same as Customer home); all buttons/colors purple
// ============================================================

import 'package:flutter/material.dart';

import '../../customer/naham_customer_screens.dart';

// Purple only (#9B7EC8) — no green
const Color _menuPurple = Color(0xFF9B7EC8);

class _NC {
  static const primary = _menuPurple;
  static const primaryMid = _menuPurple;
  static const primaryLight = Color(0xFFF0EBFF);
  static const bg = Color(0xFFF8F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF1A1A1A);
  static const textSub = Color(0xFF6B7280);
  static const border = Color(0xFFF0F0F0);
  static const error = Color(0xFFE74C3C);
  static const warning = Color(0xFFF5A623);
}

// ─── Menu Screen ─────────────────────────────────────────────
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategory = 0;
  final _categories = [
    'All',
    'Grills',
    'Rice',
    'Sweets',
    'Pastries',
    'Salads',
  ];

  final List<Map<String, dynamic>> _dishes = [
    {
      'name': 'Chicken Kabsa',
      'description': 'Traditional Saudi rice with saffron chicken',
      'price': 45.0,
      'prepTime': '45 min',
      'category': 'Rice',
      'emoji': '🍛',
      'color': Color(0xFFFFF3E0),
      'available': true,
      'badge': 'Popular',
    },
    {
      'name': 'Margog',
      'description': 'Slow-cooked lamb stew with vegetables',
      'price': 55.0,
      'prepTime': '60 min',
      'category': 'Grills',
      'emoji': '🥘',
      'color': Color(0xFFF0EBFF),
      'available': true,
      'badge': '',
    },
    {
      'name': 'Chicken Biryani',
      'description': 'Fragrant basmati rice with spiced chicken',
      'price': 38.0,
      'prepTime': '40 min',
      'category': 'Rice',
      'emoji': '🍚',
      'color': Color(0xFFFCE4EC),
      'available': false,
      'badge': '',
    },
    {
      'name': 'Kunafa',
      'description': 'Sweet cheese pastry with sugar syrup',
      'price': 25.0,
      'prepTime': '20 min',
      'category': 'Sweets',
      'emoji': '🍮',
      'color': Color(0xFFFFF8E1),
      'available': true,
      'badge': 'New',
    },
    {
      'name': 'Jareesh',
      'description': 'Crushed wheat with lamb and spices',
      'price': 40.0,
      'prepTime': '50 min',
      'category': 'Grills',
      'emoji': '🥣',
      'color': Color(0xFFE3F2FD),
      'available': true,
      'badge': '',
    },
  ];

  List<Map<String, dynamic>> get _filteredDishes {
    if (_selectedCategory == 0) return List<Map<String, dynamic>>.from(_dishes);
    final cat = _categories[_selectedCategory];
    return _dishes.where((d) => d['category'] == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _NC.bg,
      body: Column(
        children: [
          _buildHeader(),
          _buildCategories(),
          Expanded(
            child: _filteredDishes.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: _filteredDishes.length,
                    itemBuilder: (ctx, i) => _DishCard(
                      dish: _filteredDishes[i],
                      onToggle: () {
                        setState(() {
                          final dish = _filteredDishes[i];
                          final idx = _dishes.indexOf(dish);
                          _dishes[idx]['available'] =
                              !(_dishes[idx]['available'] as bool);
                        });
                      },
                      onEdit: () =>
                          _showEditSheet(context, _filteredDishes[i]),
                      onDelete: () =>
                          _showDeleteDialog(context, _filteredDishes[i]),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return nahamCustomerHeader(
      title: 'My Menu',
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fastfood_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                '${_dishes.length} Dishes',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Container(
      color: _NC.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (ctx, i) {
            final isSelected = i == _selectedCategory;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? _NC.primaryMid : _NC.bg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? _NC.primaryMid : _NC.border,
                  ),
                ),
                child: Center(
                  child: Text(
                    _categories[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : _NC.textSub,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _NC.primaryLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.restaurant_menu_rounded,
                size: 40, color: _NC.primaryMid),
          ),
          const SizedBox(height: 16),
          const Text(
            'No dishes in this category',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: _NC.text),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap + to add a new dish',
            style: TextStyle(fontSize: 13, color: _NC.textSub),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_NC.primary, _NC.primaryMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _NC.primaryMid.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showAddSheet(context),
          borderRadius: BorderRadius.circular(16),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Add Dish',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddEditDishSheet(isEdit: false),
    );
  }

  void _showEditSheet(BuildContext context, Map<String, dynamic> dish) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddEditDishSheet(isEdit: true, dish: dish),
    );
  }

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> dish) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Dish',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: Text(
            'Are you sure you want to delete "${dish['name']}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _NC.error,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Dish Card ────────────────────────────────────────────────
class _DishCard extends StatelessWidget {
  final Map<String, dynamic> dish;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DishCard({
    required this.dish,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = dish['available'] as bool;
    final badge = dish['badge'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _NC.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 100,
            decoration: BoxDecoration(
              color: isAvailable ? _NC.primaryMid : _NC.border,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: dish['color'] as Color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(dish['emoji'] as String,
                      style: const TextStyle(fontSize: 38)),
                ),
                if (badge.isNotEmpty)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badge == 'New'
                            ? _NC.warning
                            : _NC.primaryMid,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish['name'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isAvailable ? _NC.text : _NC.textSub,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dish['description'] as String,
                    style: const TextStyle(fontSize: 12, color: _NC.textSub),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${(dish['price'] as num).toStringAsFixed(0)} SAR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isAvailable ? _NC.primaryMid : _NC.textSub,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.schedule_rounded,
                          size: 12, color: _NC.textSub),
                      const SizedBox(width: 3),
                      Text(
                        dish['prepTime'] as String,
                        style: const TextStyle(
                            fontSize: 11, color: _NC.textSub),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 44,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isAvailable ? _NC.primaryMid : _NC.border,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: isAvailable
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _NC.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.edit_rounded,
                        size: 16, color: _NC.primaryMid),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _NC.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: _NC.error),
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

// ─── Add/Edit Dish Sheet ──────────────────────────────────────
class _AddEditDishSheet extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? dish;

  const _AddEditDishSheet({required this.isEdit, this.dish});

  @override
  State<_AddEditDishSheet> createState() => _AddEditDishSheetState();
}

class _AddEditDishSheetState extends State<_AddEditDishSheet> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  String _selectedCategory = 'Rice';
  int _prepTime = 25;
  final _categories = ['Grills', 'Rice', 'Sweets', 'Pastries', 'Salads'];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.dish != null) {
      _nameCtrl.text = widget.dish!['name'] as String;
      _descCtrl.text = widget.dish!['description'] as String;
      _priceCtrl.text = (widget.dish!['price'] as num).toString();
      _selectedCategory = widget.dish!['category'] as String;
      _prepTime = int.tryParse(
              (widget.dish!['prepTime'] as String).replaceAll(' min', '')) ??
          25;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [_NC.primary, _NC.primaryMid]),
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.isEdit ? 'Edit Dish' : 'Add New Dish',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!widget.isEdit) ...[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: _NC.primaryLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: _NC.primaryMid,
                              width: 1.5),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_rounded,
                                size: 40, color: _NC.primaryMid),
                            SizedBox(height: 8),
                            Text('Upload Photos',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: _NC.primaryMid)),
                            Text('Up to 3 images',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: _NC.textSub)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  _buildLabel('Dish Name'),
                  _buildField(_nameCtrl, 'e.g. Margog'),
                  const SizedBox(height: 16),
                  _buildLabel('Description'),
                  _buildField(_descCtrl,
                      'Explain what makes your dish special...',
                      maxLines: 3),
                  const SizedBox(height: 16),
                  _buildLabel('Category'),
                  _buildDropdown(),
                  const SizedBox(height: 16),
                  _buildLabel('Preparation Time (Min)'),
                  _buildPrepTime(),
                  const SizedBox(height: 16),
                  _buildLabel('Price (SAR)'),
                  _buildField(_priceCtrl, '0',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            _menuPurple,
                            Color(0xFFB59FD6),
                          ]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(14),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 14),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome_rounded,
                                  color: Colors.white,
                                  size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Start AI Pricing',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _NC.primaryMid,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14)),
                      ),
                      child: Text(
                        widget.isEdit
                            ? 'Save Changes'
                            : 'Add Dish',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _NC.text)),
    );
  }

  Widget _buildField(TextEditingController ctrl, String hint,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: _NC.textSub, fontSize: 14),
        filled: true,
        fillColor: _NC.bg,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: _NC.primaryMid, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 13),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _NC.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          isExpanded: true,
          items: _categories
              .map((c) => DropdownMenuItem(
                  value: c, child: Text(c)))
              .toList(),
          onChanged: (v) =>
              setState(() => _selectedCategory = v!),
        ),
      ),
    );
  }

  Widget _buildPrepTime() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _NC.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_rounded,
              color: _NC.primaryMid, size: 20),
          const SizedBox(width: 10),
          Text(
            '$_prepTime min',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _NC.text),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() {
              if (_prepTime > 5) _prepTime -= 5;
            }),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _NC.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove_rounded,
                  size: 16, color: _NC.primaryMid),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => _prepTime += 5),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _NC.primaryMid,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_rounded,
                  size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
