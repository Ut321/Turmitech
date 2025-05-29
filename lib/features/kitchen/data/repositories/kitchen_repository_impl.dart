// lib/features/kitchen/data/repositories/kitchen_repository_impl.dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/kitchen_entity.dart';
import '../../domain/entities/meal_plan_entity.dart';
import '../../domain/repositories/kitchen_repository.dart';
import '../datasources/kitchen_local_data_source.dart';
import '../datasources/kitchen_remote_data_source.dart';
import '../models/kitchen_model.dart';

class KitchenRepositoryImpl implements KitchenRepository {
  final KitchenRemoteDataSource remoteDataSource;
  final KitchenLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  KitchenRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<KitchenEntity>> getKitchens() async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        try {
          final kitchens = await remoteDataSource.getKitchens();
          // Cache the fresh data
          await localDataSource.cacheKitchens(kitchens);
          return Right(kitchens);
        } on ServerException catch (e) {
          // If server fails but we have cache, use cache
          try {
            final cachedKitchens = await localDataSource.getCachedKitchens();
            return Right(cachedKitchens);
          } on CacheException {
            return Left(ServerFailure(e.message));
          }
        } on NetworkException catch (e) {
          // Network error, try cache
          try {
            final cachedKitchens = await localDataSource.getCachedKitchens();
            return Right(cachedKitchens);
          } on CacheException {
            return Left(NetworkFailure(e.message));
          }
        }
      } else {
        // No internet, use cache
        try {
          final cachedKitchens = await localDataSource.getCachedKitchens();
          return Right(cachedKitchens);
        } on CacheException catch (e) {
          return Left(NetworkFailure('No internet connection and no cached data available'));
        }
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  ResultFuture<List<MealPlanEntity>> getMealPlans() async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        try {
          final mealPlans = await remoteDataSource.getMealPlans();
          // Cache the fresh data
          await localDataSource.cacheMealPlans(mealPlans);
          return Right(mealPlans);
        } on ServerException catch (e) {
          // If server fails but we have cache, use cache
          try {
            final cachedMealPlans = await localDataSource.getCachedMealPlans();
            return Right(cachedMealPlans);
          } on CacheException {
            return Left(ServerFailure(e.message));
          }
        } on NetworkException catch (e) {
          // Network error, try cache
          try {
            final cachedMealPlans = await localDataSource.getCachedMealPlans();
            return Right(cachedMealPlans);
          } on CacheException {
            return Left(NetworkFailure(e.message));
          }
        }
      } else {
        // No internet, use cache
        try {
          final cachedMealPlans = await localDataSource.getCachedMealPlans();
          return Right(cachedMealPlans);
        } on CacheException catch (e) {
          return Left(NetworkFailure('No internet connection and no cached data available'));
        }
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  ResultFuture<List<KitchenEntity>> searchKitchens(String query) async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        try {
          final kitchens = await remoteDataSource.searchKitchens(query);
          return Right(kitchens);
        } on ServerException catch (e) {
          // Fallback to local search
          try {
            final cachedKitchens = await localDataSource.getCachedKitchens();
            final filtered = cachedKitchens.where((kitchen) =>
              kitchen.name.toLowerCase().contains(query.toLowerCase())
            ).toList();
            return Right(filtered);
          } on CacheException {
            return Left(ServerFailure(e.message));
          }
        }
      } else {
        // Offline search
        try {
          final cachedKitchens = await localDataSource.getCachedKitchens();
          final filtered = cachedKitchens.where((kitchen) =>
            kitchen.name.toLowerCase().contains(query.toLowerCase())
          ).toList();
          return Right(filtered);
        } on CacheException catch (e) {
          return Left(NetworkFailure('No internet connection and no cached data available'));
        }
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  ResultFuture<List<MealPlanEntity>> searchMealPlans(String query) async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        try {
          final mealPlans = await remoteDataSource.searchMealPlans(query);
          return Right(mealPlans);
        } on ServerException catch (e) {
          // Fallback to local search
          try {
            final cachedMealPlans = await localDataSource.getCachedMealPlans();
            final filtered = cachedMealPlans.where((mealPlan) =>
              mealPlan.kitchenName.toLowerCase().contains(query.toLowerCase()) ||
              mealPlan.title.toLowerCase().contains(query.toLowerCase())
            ).toList();
            return Right(filtered);
          } on CacheException {
            return Left(ServerFailure(e.message));
          }
        }
      } else {
        // Offline search
        try {
          final cachedMealPlans = await localDataSource.getCachedMealPlans();
          final filtered = cachedMealPlans.where((mealPlan) =>
            mealPlan.kitchenName.toLowerCase().contains(query.toLowerCase()) ||
            mealPlan.title.toLowerCase().contains(query.toLowerCase())
          ).toList();
          return Right(filtered);
        } on CacheException catch (e) {
          return Left(NetworkFailure('No internet connection and no cached data available'));
        }
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  ResultFuture<KitchenEntity> toggleFavorite(KitchenEntity kitchen) async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        final kitchenModel = KitchenModel(
          id: kitchen.id,
          name: kitchen.name,
          address: kitchen.address,
          rating: kitchen.rating,
          image: kitchen.image,
          isFavorite: !kitchen.isFavorite,
        );
        
        try {
          final updatedKitchen = await remoteDataSource.updateKitchen(kitchenModel);
          return Right(updatedKitchen);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        } on NetworkException catch (e) {
          return Left(NetworkFailure(e.message));
        }
      } else {
        return const Left(NetworkFailure('Cannot update favorites without internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}