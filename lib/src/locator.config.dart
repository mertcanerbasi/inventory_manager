// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:get_storage/get_storage.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:inventory_manager/src/app_module.dart' as _i20;
import 'package:inventory_manager/src/data/data_sources/remote/auth_service.dart'
    as _i3;
import 'package:inventory_manager/src/data/data_sources/remote/qr_code_api_service.dart'
    as _i8;
import 'package:inventory_manager/src/data/data_sources/remote/store_settings_service.dart'
    as _i9;
import 'package:inventory_manager/src/data/repositories/api_repository_impl.dart'
    as _i11;
import 'package:inventory_manager/src/data/repositories/database_repository_impl.dart'
    as _i14;
import 'package:inventory_manager/src/domain/repositories/api_repository.dart'
    as _i10;
import 'package:inventory_manager/src/domain/repositories/database_repository.dart'
    as _i13;
import 'package:inventory_manager/src/presentation/cubits/app_cubit/app_cubit.dart'
    as _i18;
import 'package:inventory_manager/src/presentation/cubits/create_qr_cubit/create_qr_cubit.dart'
    as _i19;
import 'package:inventory_manager/src/presentation/cubits/home_cubit/home_cubit.dart'
    as _i15;
import 'package:inventory_manager/src/presentation/cubits/login_cubit/login_cubit.dart'
    as _i16;
import 'package:inventory_manager/src/presentation/cubits/navigation_cubit/navigation_cubit.dart'
    as _i7;
import 'package:inventory_manager/src/presentation/cubits/splash_cubit/splash_cubit.dart'
    as _i17;
import 'package:inventory_manager/src/utils/resources/encrypt_storage.dart'
    as _i12;

const String _dev = 'dev';
const String _prod = 'prod';
const String _test = 'test';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AuthService>(() => appModule.injectAuthService);
    gh.lazySingleton<_i4.Dio>(
      () => appModule.injectRetrofitAPI,
      registerFor: {
        _dev,
        _prod,
        _test,
      },
    );
    await gh.factoryAsync<_i5.GetStorage>(
      () => appModule.initializeGetStorage,
      preResolve: true,
    );
    gh.factory<_i6.GlobalKey<_i6.NavigatorState>>(
        () => appModule.mainNavigatorKey);
    gh.singleton<_i7.NavigationCubit>(_i7.NavigationCubit());
    gh.lazySingleton<_i8.QrCodeApiService>(() => appModule.injectApiService);
    gh.lazySingleton<_i9.StoreSettingsService>(
        () => appModule.injectStoreSettingsService);
    gh.lazySingleton<_i10.ApiRepository>(() => _i11.ApiRepositoryImpl(
          gh<_i8.QrCodeApiService>(),
          gh<_i3.AuthService>(),
          gh<_i9.StoreSettingsService>(),
        ));
    gh.lazySingleton<_i12.EncryptStorage>(
        () => _i12.EncryptStorageImpl(gh<_i5.GetStorage>()));
    gh.lazySingleton<_i13.DatabaseRepository>(
        () => _i14.DatabaseRepositoryImpl(gh<_i12.EncryptStorage>()));
    gh.factory<_i15.HomeCubit>(() => _i15.HomeCubit(
          gh<_i10.ApiRepository>(),
          gh<_i13.DatabaseRepository>(),
        ));
    gh.factory<_i16.LoginCubit>(() => _i16.LoginCubit(
          gh<_i10.ApiRepository>(),
          gh<_i13.DatabaseRepository>(),
        ));
    gh.factory<_i17.SplashCubit>(
        () => _i17.SplashCubit(gh<_i13.DatabaseRepository>()));
    gh.singleton<_i18.AppCubit>(_i18.AppCubit(gh<_i13.DatabaseRepository>()));
    gh.factory<_i19.CreateQrCubit>(() => _i19.CreateQrCubit(
          gh<_i10.ApiRepository>(),
          gh<_i13.DatabaseRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i20.AppModule {}
