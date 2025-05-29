import '../../../../core/utils/typedef.dart';
import '../entities/kitchen_entity.dart';
import '../repositories/kitchen_repository.dart';

class ToggleFavoriteUseCase {
  final KitchenRepository repository;

  ToggleFavoriteUseCase(this.repository);

  ResultFuture<KitchenEntity> call(KitchenEntity kitchen) {
    return repository.toggleFavorite(kitchen);
  }
}