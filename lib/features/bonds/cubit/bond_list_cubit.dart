import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../data/models/bond_model.dart';
import '../data/repositories/bond_api_service.dart';

part 'bond_list_state.dart';
part 'bond_list_cubit.freezed.dart';

@injectable
class BondListCubit extends Cubit<BondListState> {
  final BondApiService _service;

  BondListCubit(this._service) : super(const BondListState.initial());

  Future<void> fetchBonds() async {
    emit(const BondListState.loading());
    try {
      final bonds = await _service.fetchBonds();
      emit(BondListState.loaded(bonds));
    } catch (e) {
      emit(BondListState.error(e.toString()));
    }
  }
}
