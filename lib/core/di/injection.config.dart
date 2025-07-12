// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tap_invest/core/di/di_module.dart' as _i355;
import 'package:tap_invest/features/bonds/cubit/bond_cubit.dart' as _i186;
import 'package:tap_invest/features/bonds/cubit/bond_detail_cubit.dart'
    as _i585;
import 'package:tap_invest/features/bonds/cubit/bond_list_cubit.dart' as _i281;
import 'package:tap_invest/features/bonds/data/repositories/bond_api_service.dart'
    as _i350;
import 'package:tap_invest/features/bonds/data/repositories/bond_detail_api_service.dart'
    as _i65;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i350.BondApiService>(
        () => _i350.BondApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i65.BondDetailApiService>(
        () => _i65.BondDetailApiService(gh<_i361.Dio>()));
    gh.factory<_i585.BondDetailCubit>(
        () => _i585.BondDetailCubit(gh<_i65.BondDetailApiService>()));
    gh.factory<_i186.BondCubit>(
        () => _i186.BondCubit(gh<_i350.BondApiService>()));
    gh.factory<_i281.BondListCubit>(
        () => _i281.BondListCubit(gh<_i350.BondApiService>()));
    return this;
  }
}

class _$RegisterModule extends _i355.RegisterModule {}
