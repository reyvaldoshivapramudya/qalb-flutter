import 'package:doa_sehari_hari_app/data/api/api_service.dart';
import 'package:doa_sehari_hari_app/main_screen.dart';
import 'package:doa_sehari_hari_app/pages/about/about_page.dart';
import 'package:doa_sehari_hari_app/pages/detail/detail_doa_page.dart';
import 'package:doa_sehari_hari_app/provider/doa_detail_provider.dart';
import 'package:doa_sehari_hari_app/provider/doa_list_provider.dart';
import 'package:doa_sehari_hari_app/provider/favorite_provider.dart';
import 'package:doa_sehari_hari_app/provider/page_provider.dart';
import 'package:doa_sehari_hari_app/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(
          create: (context) => DoaListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(
          create: (context) => DoaDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade800),
      ),
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailDoaPage(
          doaId: ModalRoute.of(context)?.settings.arguments as int,
        ),
        NavigationRoute.aboutRoute.name: (context) => const AboutPage(),
      },
    );
  }
}