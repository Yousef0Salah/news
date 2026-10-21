// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../module/layout/data/data_source/local_data_source.dart' as _i498;
import '../../module/layout/data/data_source/remote_data_source.dart' as _i180;
import '../../module/layout/data/repo/repo.dart' as _i1043;
import '../../module/layout/view/cubit/layot_cubit.dart' as _i740;
import '../services/api_service.dart' as _i137;
import '../services/hive_service.dart' as _i1047;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.singleton<_i137.ApiService>(() => _i137.ApiService());
  gh.singleton<_i1047.HiveService>(() => _i1047.HiveService());
  gh.factory<_i180.RemoteDataSource>(
    () => _i180.RemoteDataSourceImp(gh<_i137.ApiService>()),
  );
  gh.factory<_i498.LocalDataSource>(
    () => _i498.LocalDataSourceImp(gh<_i1047.HiveService>()),
  );
  gh.factory<_i1043.Repo>(
    () => _i1043.RepoImp(
      gh<_i498.LocalDataSource>(),
      gh<_i180.RemoteDataSource>(),
    ),
  );
  gh.factory<_i740.LayoutCubit>(() => _i740.LayoutCubit(gh<_i1043.Repo>()));
  return getIt;
}
