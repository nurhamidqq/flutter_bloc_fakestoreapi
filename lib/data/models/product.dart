import 'package:flutter_bloc_fakestoreapi/data/models/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/category.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/product.dart';

class ProductModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final CategoryModel category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  ProductModel(this.id, this.title, this.price, this.description, this.category,
      this.images, this.creationAt, this.updatedAt);

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      map['id'],
      map['title'],
      map['price'],
      map['description'],
      CategoryModel.fromJson(map['category']),
      List<String>.from(map['images']),
      map['creationAt'],
      map['updatedAt'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id,
      title,
      price,
      description,
      CategoryEntity(
        category.id,
        category.name,
        category.image,
        category.creationAt,
        category.updatedAt,
        category.isSelected,
      ),
      images,
      creationAt,
      updatedAt,
    );
  }
}
