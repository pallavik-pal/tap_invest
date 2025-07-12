import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../data/models/bond_detail_model.dart';
import '../data/repositories/bond_detail_api_service.dart';

part 'bond_detail_state.dart';
part 'bond_detail_cubit.freezed.dart';

@injectable
class BondDetailCubit extends Cubit<BondDetailState> {
  final BondDetailApiService _api;

  BondDetailCubit(this._api) : super(const BondDetailState.initial());

  Future<void> fetchDetails(String isin) async {
    emit(const BondDetailState.loading());
    try {
      final detail = await _api.fetchBondDetail(isin); // ✅ This is now correct
      emit(BondDetailState.loaded(detail));
    } catch (e) {
      emit(BondDetailState.error(e.toString()));
    }
  }
}
