// Diperbarui: Menggunakan model Doa
import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  // Diperbarui: Tipe list diubah menjadi Doa
  List<Doa> _favorites = [];
  List<Doa> _allDoa = [];

  // Diperbarui: Tipe getter diubah menjadi Doa
  List<Doa> get favorites => _favorites;

  // Diperbarui: Tipe parameter diubah menjadi Doa
  void setInitialDoaAndLoadFavorites(List<Doa> allDoa) {
    if (_allDoa.isEmpty) { 
      _allDoa = allDoa;
      _loadFavorites();
    }
  }

  // Diperbarui: Tipe parameter diubah menjadi Doa
  bool isFavorite(Doa doa) {
    return _favorites.any((item) => item.id == doa.id);
  }

  // Diperbarui: Tipe parameter diubah menjadi Doa
  void toggleFavorite(Doa doa) {
    if (isFavorite(doa)) {
      _favorites.removeWhere((item) => item.id == doa.id);
    } else {
      _favorites.add(doa);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteDoaIds') ?? [];
    
    _favorites = _allDoa.where((doa) => favoriteIds.contains(doa.id.toString())).toList();
    
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    // Diperbarui: Tipe list diubah menjadi Doa
    List<String> favoriteIds = _favorites.map((doa) => doa.id.toString()).toList();
    await prefs.setStringList('favoriteDoaIds', favoriteIds);
  }
}