import '../../domain/entities/meal_plan_entity.dart';

class MealPlanModel extends MealPlanEntity {
  const MealPlanModel({
    required super.id,
    required super.title,
    required super.itemsCount,
    required super.kitchenName,
    required super.image,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      id: _parseToInt(json['id']),
      title: json['title']?.toString() ?? '',
      itemsCount: _parseToInt(json['itemsCount']),
      kitchenName: json['kitchenName']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'itemsCount': itemsCount,
      'kitchenName': kitchenName,
      'image': image,
    };
  }

  // Safe type conversion helper
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}