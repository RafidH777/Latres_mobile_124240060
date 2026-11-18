import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/product_controller.dart';
import '../../utils/app_theme.dart';
import 'product_list_view.dart';
import 'wishlist_view.dart';
import 'profile_view.dart';

class MainNavView extends StatefulWidget {
  final int initialIndex;

  const MainNavView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  late int _selectedIndex;

  // List of pages for BottomNavigationBar
  final List<Widget> _pages = const [
    ProductListView(),
    WishlistView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Ensure controllers are ready
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController());
    }
    if (!Get.isRegistered<FavoriteController>()) {
      Get.put(FavoriteController());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Refresh favorites list if switching to Wishlist tab
    if (index == 1) {
      Get.find<FavoriteController>().loadFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppTheme.darkBackground,
        selectedItemColor: AppTheme.primaryRed,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
