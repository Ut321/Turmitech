import '../../../../core/utils/typedef.dart';
import '../entities/kitchen_entity.dart';
import '../repositories/kitchen_repository.dart';

class GetKitchensUseCase {
  final KitchenRepository repository;

  GetKitchensUseCase(this.repository);

  ResultFuture<List<KitchenEntity>> call() {
    return repository.getKitchens();
  }
}