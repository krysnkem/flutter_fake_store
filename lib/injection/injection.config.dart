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
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/api/api_client.dart' as _i217;
import '../data/cache/cache_service.dart' as _i208;
import '../data/cache/shared_preference_cache_impl.dart' as _i704;
import '../data/repositories/data_repository.dart' as _i724;
import '../data/repositories/data_repository_impl.dart' as _i377;
import '../presentation/blocs/auth/auth_bloc.dart' as _i525;
import 'register_module.dart' as _i291;

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
    gh.lazySingleton<String>(() => registerModule.baseUrl);
    gh.lazySingletonAsync<_i460.SharedPreferences>(
        () => registerModule.sharedPreferences);
    gh.lazySingletonAsync<_i208.CacheService>(() async =>
        _i704.SharedPreferenceCacheImpl(
            await getAsync<_i460.SharedPreferences>()));
    gh.factory<_i217.ApiClient>(() => _i217.ApiClient(gh<_i361.Dio>()));
    gh.lazySingletonAsync<_i724.DataRepository>(
        () async => _i377.DataRepositoryImpl(
              gh<_i217.ApiClient>(),
              await getAsync<_i208.CacheService>(),
            ));
    gh.factoryAsync<_i525.AuthBloc>(() async =>
        _i525.AuthBloc(dataRepository: await getAsync<_i724.DataRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
