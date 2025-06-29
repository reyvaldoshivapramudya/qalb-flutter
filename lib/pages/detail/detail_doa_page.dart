import 'package:doa_sehari_hari_app/provider/doa_detail_provider.dart';
import 'package:doa_sehari_hari_app/provider/favorite_provider.dart'; // Tambahkan ini
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doa_sehari_hari_app/static/doa_detail_result_state.dart';

class DetailDoaPage extends StatefulWidget {
  final int doaId;

  const DetailDoaPage({super.key, required this.doaId});

  @override
  State<DetailDoaPage> createState() => _DetailDoaPageState();
}

class _DetailDoaPageState extends State<DetailDoaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoaDetailProvider>(
        context,
        listen: false,
      ).fetchDoaDetail(widget.doaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kita 'watch' provider detail di sini untuk membangun ulang seluruh scaffold saat data berubah
    return Consumer<DoaDetailProvider>(
      builder: (context, doaDetailProvider, child) {
        final state = doaDetailProvider.resultState;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              // Tampilkan judul jika sudah dimuat, jika tidak tampilkan 'Detail Doa'
              state is DoaDetailLoadedState ? state.doa.judul : 'Detail Doa',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.teal.shade700,
            foregroundColor: Colors.white,
            actions: [
              // Hanya tampilkan tombol favorit jika data sudah berhasil dimuat
              if (state is DoaDetailLoadedState)
                // Gunakan Consumer di sini agar hanya icon yang di-render ulang
                Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    final bool isFavorited = favoriteProvider.isFavorite(state.doa);
                    return IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red.shade400 : Colors.white,
                      ),
                      onPressed: () {
                        // Panggil method dari provider favorit
                        favoriteProvider.toggleFavorite(state.doa);
                      },
                    );
                  },
                ),
            ],
          ),
          body: _buildBody(state), // Body tetap menggunakan method yang sama
        );
      },
    );
  }

  Widget _buildBody(DoaDetailResultState state) {
    if (state is DoaDetailLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is DoaDetailLoadedState) {
      final doa = state.doa;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Center(
                  child: Icon(
                    _getIconForDoa(doa.id),
                    size: 80,
                    color: Colors.teal.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              doa.judul,
              textAlign: TextAlign.center,
              style: GoogleFonts.scheherazadeNew(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.teal.shade200)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber.shade700,
                  ),
                ),
                Expanded(child: Divider(color: Colors.teal.shade200)),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                doa.arab,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: GoogleFonts.amiri(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.brown.shade800,
                  height: 2.0,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              doa.latin,
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              doa.terjemah,
              textAlign: TextAlign.justify,
              style: GoogleFonts.notoSans(
                fontSize: 17,
                color: Colors.black87,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    } else if (state is DoaDetailErrorState) {
      return Center(
        child: Text(
          'Gagal memuat detail doa: \n${state.error}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Pilih doa untuk melihat detail.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
  }

  IconData _getIconForDoa(int id) {
    switch (id) {
      case 1:
        return Icons.wb_sunny_outlined;
      case 2:
        return Icons.bed_outlined;
      case 3:
        return Icons.bathtub_outlined;
      case 4:
        return Icons.bathroom_outlined;
      case 5:
        return Icons.face_retouching_natural;
      case 6:
        return Icons.exit_to_app;
      case 7:
        return Icons.house_outlined;
      case 8:
      case 9:
      case 10:
        return Icons.school_outlined;
      case 11:
      case 12:
        return Icons.water_drop_outlined;
      case 13:
      case 14:
        return Icons.book_outlined;
      case 15:
        return Icons.shower_outlined;
      case 16:
      case 17:
        return Icons.travel_explore_outlined;
      case 18:
        return Icons.payments_outlined;
      case 19:
        return Icons.sentiment_dissatisfied_outlined;
      case 20:
        return Icons.handshake_outlined;
      case 21:
        return Icons.watch_later_outlined;
      case 22:
        return Icons.brightness_high_outlined;
      case 23:
        return Icons.brightness_low_outlined;
      default:
        return Icons.menu_book;
    }
  }
}
