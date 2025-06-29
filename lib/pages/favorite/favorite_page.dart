import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:doa_sehari_hari_app/pages/doa/doa_card_widget.dart';
import 'package:doa_sehari_hari_app/provider/favorite_provider.dart';
import 'package:doa_sehari_hari_app/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final List<Doa> favoriteDoaList = favoriteProvider.favorites;

    if (favoriteDoaList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gunakan Lottie.asset untuk memuat animasi dari file JSON
              Lottie.asset(
                'assets/animations/favorite_animation.json',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 24),
              Text(
                'Halaman Favoritmu masih kosong nih',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Yuk, tambahkan doa favoritmu dengan menekan ikon hati di halaman detail.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    // Bagian ini tidak berubah, akan ditampilkan jika ada isinya
    return ListView.builder(
      itemCount: favoriteDoaList.length,
      itemBuilder: (context, index) {
        final Doa doa = favoriteDoaList[index];
        return DoaCardWidget(
          doa: doa,
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationRoute.detailRoute.name,
              arguments: doa.id,
            );
          },
        );
      },
    );
  }
}
