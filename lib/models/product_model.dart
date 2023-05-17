import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String id;
  final String name;
  final String detail;
  final String urlImage;
  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'urlImage': urlImage,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      urlImage: (map['urlImage'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
