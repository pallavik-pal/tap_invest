// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bond_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BondDetailModelImpl _$$BondDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BondDetailModelImpl(
      logo: json['logo'] as String,
      companyName: json['company_name'] as String,
      description: json['description'] as String,
      isin: json['isin'] as String,
      status: json['status'] as String,
      prosAndCons:
          ProsAndCons.fromJson(json['pros_and_cons'] as Map<String, dynamic>),
      financials:
          Financials.fromJson(json['financials'] as Map<String, dynamic>),
      issuerDetails: IssuerDetails.fromJson(
          json['issuer_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BondDetailModelImplToJson(
        _$BondDetailModelImpl instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'company_name': instance.companyName,
      'description': instance.description,
      'isin': instance.isin,
      'status': instance.status,
      'pros_and_cons': instance.prosAndCons,
      'financials': instance.financials,
      'issuer_details': instance.issuerDetails,
    };

_$ProsAndConsImpl _$$ProsAndConsImplFromJson(Map<String, dynamic> json) =>
    _$ProsAndConsImpl(
      pros: (json['pros'] as List<dynamic>).map((e) => e as String).toList(),
      cons: (json['cons'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ProsAndConsImplToJson(_$ProsAndConsImpl instance) =>
    <String, dynamic>{
      'pros': instance.pros,
      'cons': instance.cons,
    };

_$FinancialsImpl _$$FinancialsImplFromJson(Map<String, dynamic> json) =>
    _$FinancialsImpl(
      ebitda: (json['ebitda'] as List<dynamic>)
          .map((e) => MonthData.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenue: (json['revenue'] as List<dynamic>)
          .map((e) => MonthData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FinancialsImplToJson(_$FinancialsImpl instance) =>
    <String, dynamic>{
      'ebitda': instance.ebitda,
      'revenue': instance.revenue,
    };

_$MonthDataImpl _$$MonthDataImplFromJson(Map<String, dynamic> json) =>
    _$MonthDataImpl(
      month: json['month'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$$MonthDataImplToJson(_$MonthDataImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'value': instance.value,
    };

_$IssuerDetailsImpl _$$IssuerDetailsImplFromJson(Map<String, dynamic> json) =>
    _$IssuerDetailsImpl(
      issuerName: json['issuer_name'] as String,
      typeOfIssuer: json['type_of_issuer'] as String,
      sector: json['sector'] as String,
      industry: json['industry'] as String,
      issuerNature: json['issuer_nature'] as String,
      cin: json['cin'] as String,
      leadManager: json['lead_manager'] as String,
      registrar: json['registrar'] as String,
      debentureTrustee: json['debenture_trustee'] as String,
    );

Map<String, dynamic> _$$IssuerDetailsImplToJson(_$IssuerDetailsImpl instance) =>
    <String, dynamic>{
      'issuer_name': instance.issuerName,
      'type_of_issuer': instance.typeOfIssuer,
      'sector': instance.sector,
      'industry': instance.industry,
      'issuer_nature': instance.issuerNature,
      'cin': instance.cin,
      'lead_manager': instance.leadManager,
      'registrar': instance.registrar,
      'debenture_trustee': instance.debentureTrustee,
    };
