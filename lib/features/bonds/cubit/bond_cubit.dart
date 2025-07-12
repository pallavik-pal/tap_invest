import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/models/bond_model.dart';
import '../data/repositories/bond_api_service.dart';
import 'bond_state.dart';

@injectable
class BondCubit extends Cubit<BondState> {
  final BondApiService _apiService;

  BondCubit(this._apiService) : super(const BondState.initial());

  Future<void> fetchBonds() async {
    emit(const BondState.loading());
    try {
      final bonds = await _apiService.fetchBonds();
      emit(BondState.loaded(bonds));
    } catch (e) {
      emit(BondState.error(e.toString()));
    }
  }
}
