import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/kitchen_entity.dart';
import '../../domain/entities/meal_plan_entity.dart';
import '../../domain/usecases/get_kitchens_usecase.dart';
import '../../domain/usecases/get_meal_plans_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

// Use case providers
final getKitchensUseCaseProvider = Provider<GetKitchensUseCase>((ref) => sl());
final getMealPlansUseCaseProvider = Provider<GetMealPlansUseCase>((ref) => sl());
final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) => sl());

// Data providers
final kitchensProvider = FutureProvider<List<KitchenEntity>>((ref) async {
  final useCase = ref.read(getKitchensUseCaseProvider);
  final result = await useCase();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (kitchens) => kitchens,
  );
});

final mealPlansProvider = FutureProvider<List<MealPlanEntity>>((ref) async {
  final useCase = ref.read(getMealPlansUseCaseProvider);
  final result = await useCase();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (mealPlans) => mealPlans,
  );
});

// Search state
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered data providers
final filteredKitchensProvider = Provider<AsyncValue<List<KitchenEntity>>>((ref) {
  final kitchensAsync = ref.watch(kitchensProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  
  return kitchensAsync.when(
    data: (kitchens) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(kitchens);
      }
      final filtered = kitchens.where((kitchen) =>
        kitchen.name.toLowerCase().contains(searchQuery)
      ).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final filteredMealPlansProvider = Provider<AsyncValue<List<MealPlanEntity>>>((ref) {
  final mealPlansAsync = ref.watch(mealPlansProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  
  return mealPlansAsync.when(
    data: (mealPlans) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(mealPlans);
      }
      final filtered = mealPlans.where((mealPlan) =>
        mealPlan.kitchenName.toLowerCase().contains(searchQuery) ||
        mealPlan.title.toLowerCase().contains(searchQuery)
      ).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Kitchen actions provider
final kitchenActionsProvider = Provider<KitchenActions>((ref) {
  return KitchenActions(ref);
});

class KitchenActions {
  final Ref ref;
  
  KitchenActions(this.ref);
  
  Future<void> toggleFavorite(KitchenEntity kitchen) async {
    final useCase = ref.read(toggleFavoriteUseCaseProvider);
    final result = await useCase(kitchen);
    
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.refresh(kitchensProvider),
    );
  }
}