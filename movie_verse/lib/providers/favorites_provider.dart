import 'package:flutter/material.dart';
import '../models/show_models.dart';
import '../helpers/hive_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Show> _favorites = [];

  List<Show> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    _favorites = await HiveHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Show show) async {
    if (!_favorites.any((s) => s.id == show.id)) {
      _favorites.add(show);
      await HiveHelper.addFavorite(show);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Show show) async {
    _favorites.removeWhere((s) => s.id == show.id);
    await HiveHelper.removeFavorite(show.id);
    notifyListeners();
  }

  bool isFavorite(Show show) {
    return _favorites.any((s) => s.id == show.id);
  }
}
