import 'package:doa_sehari_hari_app/data/api/api_service.dart';
import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:doa_sehari_hari_app/static/doa_list_result_state.dart';
import 'package:flutter/material.dart';

class DoaListProvider extends ChangeNotifier {
  final ApiService _apiService;

  DoaListProvider(this._apiService);

  DoaListResultState _resultState = DoaListNoneState();

  DoaListResultState get resultState => _resultState;

  Future<void> fetchDoaList() async {
    try {
      _resultState = DoaListLoadingState();
      notifyListeners();

      final dynamic responseData = await _apiService.getDoaList();
      if (responseData is List) {
        final List<Doa> doas = responseData
            .map(
              (jsonItem) =>
                  Doa.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();

        _resultState = DoaListLoadedState(doas);
        notifyListeners();
      } else {
        _resultState = DoaListErrorState('Format respons API tidak sesuai');
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = DoaListErrorState(e.toString());
      notifyListeners();
    }
  }
}
