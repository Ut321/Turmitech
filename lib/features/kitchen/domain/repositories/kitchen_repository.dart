import '../../../../core/utils/typedef.dart';
import '../entities/kitchen_entity.dart';
import '../entities/meal_plan_entity.dart';

abstract class KitchenRepository {
  ResultFuture<List<KitchenEntity>> getKitchens();
  ResultFuture<List<MealPlanEntity>> getMealPlans();
  ResultFuture<List<KitchenEntity>> searchKitchens(String query);
  ResultFuture<List<MealPlanEntity>> searchMealPlans(String query);
  ResultFuture<KitchenEntity> toggleFavorite(KitchenEntity kitchen);
}