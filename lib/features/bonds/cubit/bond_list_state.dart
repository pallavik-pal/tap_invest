part of 'bond_list_cubit.dart';

@freezed
class BondListState with _$BondListState {
  const factory BondListState.initial() = _Initial;
  const factory BondListState.loading() = _Loading;
  const factory BondListState.loaded(List<BondModel> bonds) = _Loaded;
  const factory BondListState.error(String message) = _Error;
}
