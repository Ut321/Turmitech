import 'package:equatable/equatable.dart';

class KitchenEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final double rating;
  final String image;
  final bool isFavorite;

  const KitchenEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.image,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [id, name, address, rating, image, isFavorite];
}