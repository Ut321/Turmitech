import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/kitchen/data/datasources/kitchen_local_data_source.dart';
import 'features/kitchen/data/datasources/kitchen_remote_data_source.dart';
import 'features/kitchen/data/repositories/kitchen_repository_impl.dart';
import 'features/kitchen/domain/repositories/kitchen_repository.dart';
import 'features/kitchen/domain/usecases/get_kitchens_usecase.dart';
import 'features/kitchen/domain/usecases/get_meal_plans_usecase.dart';
import 'features/kitchen/domain/usecases/search_kitchens_usecase.dart';
import 'features/kitchen/domain/usecases/toggle_favorite_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Kitchen
  // Use cases
  sl.registerLazySingleton(() => GetKitchensUseCase(sl()));
  sl.registerLazySingleton(() => GetMealPlansUseCase(sl()));
  sl.registerLazySingleton(() => SearchKitchensUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));

  // Repository
  sl.registerLazySingleton<KitchenRepository>(
    () => KitchenRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<KitchenRemoteDataSource>(
    () => KitchenRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<KitchenLocalDataSource>(
    () => KitchenLocalDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}