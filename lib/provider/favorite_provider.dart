import 'package:doa_sehari_hari_app/data/api/api_service.dart';
import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  // Menggunakan ApiService untuk mengambil data
  final ApiService _apiService = ApiService();

  List<Doa> _favorites = [];
  late List<Doa> _allDoa; // Daftar lengkap semua doa

  List<Doa> get favorites => _favorites;

  // Constructor: Memanggil method inisialisasi
  FavoriteProvider() {
    _initialize();
  }

  // Method inisialisasi yang mengambil data dari API
  Future<void> _initialize() async {
    try {
      // LANGKAH 1: Ambil data mentah dari API
      final List<dynamic> rawDoaList = await _apiService.getDoaList();

      // LANGKAH 2: Ubah data mentah (List<dynamic>) menjadi List<Doa>
      // Kita menggunakan .map untuk mengubah setiap item JSON menjadi objek Doa
      _allDoa = rawDoaList
          .map((json) => Doa.fromJson(json as Map<String, dynamic>))
          .toList();

      // LANGKAH 3: Setelah _allDoa terisi, muat favorit dari SharedPreferences
      await _loadFavorites();
    } catch (e) {
      // Penanganan error jika API gagal dimuat
      debugPrint('Error initializing FavoriteProvider: $e');
      // Pastikan _allDoa tidak null jika terjadi error
      _allDoa = [];
    }
  }

  // Method ini tidak perlu diubah, sudah benar
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteDoaIds') ?? [];

    _favorites = _allDoa
        .where((doa) => favoriteIds.contains(doa.id.toString()))
        .toList();

    notifyListeners();
  }

  // Method ini tidak perlu diubah, sudah benar
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = _favorites
        .map((doa) => doa.id.toString())
        .toList();
    await prefs.setStringList('favoriteDoaIds', favoriteIds);
  }

  // Method ini tidak perlu diubah, sudah benar
  bool isFavorite(Doa doa) {
    return _favorites.any((item) => item.id == doa.id);
  }

  // Method ini tidak perlu diubah, sudah benar
  void toggleFavorite(Doa doa) {
    if (isFavorite(doa)) {
      _favorites.removeWhere((item) => item.id == doa.id);
    } else {
      _favorites.add(doa);
    }
    _saveFavorites();
    notifyListeners();
  }
}
