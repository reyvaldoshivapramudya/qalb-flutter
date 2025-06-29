import 'package:doa_sehari_hari_app/data/model/doa.dart';

sealed class DoaDetailResultState {}

class DoaDetailNoneState extends DoaDetailResultState {}

class DoaDetailLoadingState extends DoaDetailResultState {}

class DoaDetailErrorState extends DoaDetailResultState {
  final String error;

  DoaDetailErrorState(this.error);
}

class DoaDetailLoadedState extends DoaDetailResultState {
  final Doa doa;

  DoaDetailLoadedState(this.doa);
}
