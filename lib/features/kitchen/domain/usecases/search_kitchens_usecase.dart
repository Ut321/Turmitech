import '../../../../core/utils/typedef.dart';
import '../entities/kitchen_entity.dart';
import '../repositories/kitchen_repository.dart';

class SearchKitchensUseCase {
  final KitchenRepository repository;

  SearchKitchensUseCase(this.repository);

  ResultFuture<List<KitchenEntity>> call(String query) {
    return repository.searchKitchens(query);
  }
}