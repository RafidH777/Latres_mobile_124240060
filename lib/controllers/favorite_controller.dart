import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/show_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _favoriteService = FavoriteService();

  final RxList<ShowModel> favorites = <ShowModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // Load favorites from Hive
  void loadFavorites() {
    favorites.assignAll(_favoriteService.getFavorites());
  }

  // Check if show is in favorites (must read reactive `favorites` list for Obx)
  bool isFavorite(int id) {
    return favorites.any((show) => show.id == id);
  }

  // Toggle favorite status
  Future<void> toggleFavorite(ShowModel show) async {
    final bool added = await _favoriteService.toggleFavorite(show);
    loadFavorites();

    Get.snackbar(
      added ? 'Favorit Ditambahkan' : 'Favorit Dihapus',
      added
          ? '${show.name} berhasil ditambahkan ke daftar favorit'
          : '${show.name} dihapus dari daftar favorit',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: added ? Colors.redAccent.shade700 : Colors.grey.shade900,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      icon: Icon(
        added ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }

  // Remove a favorite show
  Future<void> removeFavorite(int id, String showName) async {
    await _favoriteService.removeFavorite(id);
    loadFavorites();

    Get.snackbar(
      'Dihapus',
      '$showName berhasil dihapus dari favorit.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey.shade900,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }
}
