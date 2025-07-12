import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/bond_model.dart';
import '../models/bond_detail_model.dart';

@lazySingleton
class BondApiService {
  final Dio _dio;

  BondApiService(this._dio);

  static const String bondListUrl = 'https://eol122duf9sy4de.m.pipedream.net';
  static const String bondDetailUrl = 'https://eo61q3zd4heiwke.m.pipedream.net';

  // Fetch Bond List
  Future<List<BondModel>> fetchBonds() async {
    final response = await _dio.get(bondListUrl);
    final data = response.data['data'] as List;
    return data.map((e) => BondModel.fromJson(e)).toList();
  }

  // Fetch Bond Detail using ISIN
  Future<BondDetailModel> fetchBondDetail(String isin) async {
    final response = await _dio.get(
      bondDetailUrl,
      queryParameters: {'isin': isin},
    );
    return BondDetailModel.fromJson(response.data);
  }
}
