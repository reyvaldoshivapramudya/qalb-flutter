import 'package:doa_sehari_hari_app/data/model/doa.dart';

sealed class DoaListResultState {}

class DoaListNoneState extends DoaListResultState {}

class DoaListLoadingState extends DoaListResultState {}

class DoaListErrorState extends DoaListResultState {
  final String error;

  DoaListErrorState(this.error);
}

class DoaListLoadedState extends DoaListResultState {
  final List<Doa> doa;
  DoaListLoadedState(this.doa);
}
