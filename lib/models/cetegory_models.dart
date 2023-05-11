// To parse this JSON data, do
//
//     final cetegorymodel = cetegorymodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cetegorymodel cetegorymodelFromJson(String str) =>
    Cetegorymodel.fromJson(json.decode(str));

class Cetegorymodel {
  List<Category> categories;

  Cetegorymodel({
    required this.categories,
  });

  factory Cetegorymodel.fromJson(Map<String, dynamic> json) => Cetegorymodel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );
}
