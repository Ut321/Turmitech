import '../../../../core/errors/exceptions.dart';
import '../models/kitchen_model.dart';
import '../models/meal_plan_model.dart';

abstract class KitchenLocalDataSource {
  Future<List<KitchenModel>> getCachedKitchens();
  Future<List<MealPlanModel>> getCachedMealPlans();
  Future<void> cacheKitchens(List<KitchenModel> kitchens);
  Future<void> cacheMealPlans(List<MealPlanModel> mealPlans);
}

class KitchenLocalDataSourceImpl implements KitchenLocalDataSource {
  // In a real app, you would use SharedPreferences, Hive, or SQLite
  List<KitchenModel>? _cachedKitchens;
  List<MealPlanModel>? _cachedMealPlans;

  @override
  Future<List<KitchenModel>> getCachedKitchens() async {
    if (_cachedKitchens != null) {
      return _cachedKitchens!;
    } else {
      throw const CacheException('No cached kitchens found');
    }
  }

  @override
  Future<List<MealPlanModel>> getCachedMealPlans() async {
    if (_cachedMealPlans != null) {
      return _cachedMealPlans!;
    } else {
      throw const CacheException('No cached meal plans found');
    }
  }

  @override
  Future<void> cacheKitchens(List<KitchenModel> kitchens) async {
    _cachedKitchens = kitchens;
  }

  @override
  Future<void> cacheMealPlans(List<MealPlanModel> mealPlans) async {
    _cachedMealPlans = mealPlans;
  }
}