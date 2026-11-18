import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/show_model.dart';

class FavoriteService {
  static const String boxName = 'favorites';

  Box<ShowModel> get _box => Hive.box<ShowModel>(boxName);

  // Get all favorites
  List<ShowModel> getFavorites() {
    return _box.values.toList();
  }

  // Check if a show is marked as favorite
  bool isFavorite(int id) {
    return _box.containsKey(id);
  }

  // Add show to favorites
  Future<void> addFavorite(ShowModel show) async {
    await _box.put(show.id, show);
  }

  // Remove show from favorites by id
  Future<void> removeFavorite(int id) async {
    await _box.delete(id);
  }

  // Toggle favorite status
  Future<bool> toggleFavorite(ShowModel show) async {
    if (isFavorite(show.id)) {
      await removeFavorite(show.id);
      return false; // un-favorited
    } else {
      await addFavorite(show);
      return true; // favorited
    }
  }

  // Box listenable for reactive UI
  ValueListenable<Box<ShowModel>> getListenable() {
    return _box.listenable();
  }
}
