import 'package:doa_sehari_hari_app/pages/doa/list_doa_page.dart';
import 'package:doa_sehari_hari_app/pages/favorite/favorite_page.dart';
import 'package:doa_sehari_hari_app/provider/page_provider.dart';
import 'package:doa_sehari_hari_app/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [ListDoaPage(), FavoritePage()];
  final List<String> _titleAppBar = const ['Qalb', 'Favorite'];

  @override
  Widget build(BuildContext context) {
    final selectedPage = context.watch<PageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleAppBar[selectedPage.currentIndex],
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NavigationRoute.aboutRoute.name);
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: _pages[selectedPage.currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => selectedPage.setIndex(value),
        selectedIndex: selectedPage.currentIndex,
        destinations: [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.handsPraying),
            label: 'Doa-doa',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.bookmark),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
