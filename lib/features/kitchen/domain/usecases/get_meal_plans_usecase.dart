import '../../../../core/utils/typedef.dart';
import '../entities/meal_plan_entity.dart';
import '../repositories/kitchen_repository.dart';

class GetMealPlansUseCase {
  final KitchenRepository repository;

  GetMealPlansUseCase(this.repository);

  ResultFuture<List<MealPlanEntity>> call() {
    return repository.getMealPlans();
  }
}