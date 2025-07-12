import 'package:freezed_annotation/freezed_annotation.dart';

part 'bond_detail_model.freezed.dart';
part 'bond_detail_model.g.dart';

@freezed
class BondDetailModel with _$BondDetailModel {
  const factory BondDetailModel({
    required String logo,
    @JsonKey(name: 'company_name') required String companyName,
    required String description,
    required String isin,
    required String status,
    @JsonKey(name: 'pros_and_cons') required ProsAndCons prosAndCons,
    required Financials financials,
    @JsonKey(name: 'issuer_details') required IssuerDetails issuerDetails,
  }) = _BondDetailModel;

  factory BondDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BondDetailModelFromJson(json);
}

@freezed
class ProsAndCons with _$ProsAndCons {
  const factory ProsAndCons({
    required List<String> pros,
    required List<String> cons,
  }) = _ProsAndCons;

  factory ProsAndCons.fromJson(Map<String, dynamic> json) =>
      _$ProsAndConsFromJson(json);
}

@freezed
class Financials with _$Financials {
  const factory Financials({
    required List<MonthData> ebitda,
    required List<MonthData> revenue,
  }) = _Financials;

  factory Financials.fromJson(Map<String, dynamic> json) =>
      _$FinancialsFromJson(json);
}

@freezed
class MonthData with _$MonthData {
  const factory MonthData({
    required String month,
    required int value,
  }) = _MonthData;

  factory MonthData.fromJson(Map<String, dynamic> json) =>
      _$MonthDataFromJson(json);
}

@freezed
class IssuerDetails with _$IssuerDetails {
  const factory IssuerDetails({
    @JsonKey(name: 'issuer_name') required String issuerName,
    @JsonKey(name: 'type_of_issuer') required String typeOfIssuer,
    required String sector,
    required String industry,
    @JsonKey(name: 'issuer_nature') required String issuerNature,
    required String cin,
    @JsonKey(name: 'lead_manager') required String leadManager,
    required String registrar,
    @JsonKey(name: 'debenture_trustee') required String debentureTrustee,
  }) = _IssuerDetails;

  factory IssuerDetails.fromJson(Map<String, dynamic> json) =>
      _$IssuerDetailsFromJson(json);
}
extension BondDetailModelExtension on BondDetailModel {
  List<double> get revenueData =>
      financials.revenue.map((e) => e.value.toDouble()).toList();

  List<double> get ebitdaData =>
      financials.ebitda.map((e) => e.value.toDouble()).toList();

  List<String> get months =>
      financials.revenue.map((e) => e.month).toList();
}
