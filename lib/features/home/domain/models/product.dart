import 'package:flutter/material.dart';
import 'dart:math' show Point;

class Product {
  final String id;
  final String name;
  final String category;
  final Point<int> location; // Grid location of the product

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
  });

  // Sample products with their locations in the grid
  static List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Milk',
      category: 'Dairy',
      location: const Point(4, 14), // Near top-left walkway
    ),
    Product(
      id: '2',
      name: 'Bread',
      category: 'Bakery',
      location: const Point(15, 23), // Middle walkway
    ),
    Product(
      id: '3',
      name: 'Cheese',
      category: 'Dairy',
      location: const Point(20, 33), // Near bottom walkway
    ),
    Product(
      id: '4',
      name: 'Juice',
      category: 'Beverages',
      location: const Point(15, 14), // Upper middle walkway
    ),
    Product(
      id: '5',
      name: 'Snacks',
      category: 'Snacks',
      location: const Point(4, 23), // Left walkway middle
    ),
    Product(
      id: '6',
      name: 'Fruits',
      category: 'Produce',
      location: const Point(20, 14), // Right side, upper walkway
    ),
  ];

  // Search products by name
  static List<Product> search(String query) {
    query = query.toLowerCase();
    return sampleProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
    }).toList();
  }
}
