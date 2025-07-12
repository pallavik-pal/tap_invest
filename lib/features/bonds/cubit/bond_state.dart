import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/bond_model.dart';

part 'bond_state.freezed.dart';

@freezed
class BondState with _$BondState {
  const factory BondState.initial() = _Initial;
  const factory BondState.loading() = _Loading;
  const factory BondState.loaded(List<BondModel> bonds) = _Loaded;
  const factory BondState.error(String message) = _Error;
}
