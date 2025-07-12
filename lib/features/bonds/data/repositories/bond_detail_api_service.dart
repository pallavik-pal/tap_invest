import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/bond_detail_model.dart';

@lazySingleton
class BondDetailApiService {
  final Dio _dio;

  BondDetailApiService(this._dio);

  static const String detailUrl = 'https://eo61q3zd4heiwke.m.pipedream.net/';

  Future<BondDetailModel> fetchBondDetail(String isin) async {
    final response = await _dio.get('$detailUrl?isin=$isin');
    return BondDetailModel.fromJson(response.data);
  }
}
