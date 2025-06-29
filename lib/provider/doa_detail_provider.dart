import 'package:doa_sehari_hari_app/data/api/api_service.dart';
import 'package:doa_sehari_hari_app/data/model/doa.dart';
import 'package:doa_sehari_hari_app/static/doa_detail_result_state.dart';
import 'package:flutter/material.dart';

class DoaDetailProvider extends ChangeNotifier {
  final ApiService _apiServices;

  DoaDetailProvider(this._apiServices);

  DoaDetailResultState _resultState = DoaDetailNoneState();

  DoaDetailResultState get resultState => _resultState;

  Future<void> fetchDoaDetail(int id) async {
    try {
      _resultState = DoaDetailLoadingState();
      notifyListeners();

      final Doa result = await _apiServices.getDoaDetail(id);

      _resultState = DoaDetailLoadedState(result);
      notifyListeners();
    } on Exception catch (e) {
      _resultState = DoaDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
