import 'package:hive/hive.dart';
import '../models/show_models.dart';

class HiveHelper {
  static Box? _favouritesBox;

  static Future<void> init() async {
    _favouritesBox = await Hive.openBox('favourites');
  }

  static Future<void> addFavorite(Show show) async {
    await _favouritesBox!.put(show.id, show.toMap());
  }

  static Future<void> removeFavorite(int id) async {
    await _favouritesBox!.delete(id);
  }

  static List<Show> getFavorites() {
    return _favouritesBox!.values
        .map((e) => Show.fromMap(Map<dynamic, dynamic>.from(e)))
        .toList();
  }
}
