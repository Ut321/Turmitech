import 'package:equatable/equatable.dart';

class MealPlanEntity extends Equatable {
  final int id;
  final String title;
  final int itemsCount;
  final String kitchenName;
  final String image;

  const MealPlanEntity({
    required this.id,
    required this.title,
    required this.itemsCount,
    required this.kitchenName,
    required this.image,
  });

  @override
  List<Object> get props => [id, title, itemsCount, kitchenName, image];
}