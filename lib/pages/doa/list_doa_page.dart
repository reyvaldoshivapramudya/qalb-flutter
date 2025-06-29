// ignore_for_file: use_build_context_synchronously

import 'package:doa_sehari_hari_app/pages/doa/doa_card_widget.dart';
import 'package:doa_sehari_hari_app/provider/doa_list_provider.dart';
import 'package:doa_sehari_hari_app/static/doa_list_result_state.dart';
import 'package:doa_sehari_hari_app/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDoaPage extends StatefulWidget {
  const ListDoaPage({super.key});

  @override
  State<ListDoaPage> createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DoaListProvider>().fetchDoaList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoaListProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            DoaListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            DoaListLoadedState(doa: var doas) => ListView.builder(
              itemCount: doas.length,
              itemBuilder: (context, index) {
                final doa = doas[index];

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
            ),
            DoaListErrorState(error: var errorMessage) => Center(
              child: Text(
                'Error: $errorMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            _ => const Center(
              child: Text(
                'Pilih doa untuk melihat detail.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          };
        },
      ),
    );
  }
}
