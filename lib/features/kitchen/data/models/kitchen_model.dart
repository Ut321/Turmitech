import '../../domain/entities/kitchen_entity.dart';

class KitchenModel extends KitchenEntity {
  const KitchenModel({
    required super.id,
    required super.name,
    required super.address,
    required super.rating,
    required super.image,
    required super.isFavorite,
  });

  factory KitchenModel.fromJson(Map<String, dynamic> json) {
    return KitchenModel(
      id: _parseToInt(json['id']),
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      rating: _parseToDouble(json['rating']),
      image: json['image']?.toString() ?? '',
      isFavorite: _parseToBool(json['isFavorite']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'rating': rating,
      'image': image,
      'isFavorite': isFavorite,
    };
  }

  // Safe type conversion helpers
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static bool _parseToBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    if (value is int) return value == 1;
    return false;
  }

  KitchenModel copyWith({
    int? id,
    String? name,
    String? address,
    double? rating,
    String? image,
    bool? isFavorite,
  }) {
    return KitchenModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}