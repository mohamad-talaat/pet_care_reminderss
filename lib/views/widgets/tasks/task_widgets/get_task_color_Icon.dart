
import 'package:flutter/material.dart';

Color getTaskColor(String type) {
  switch (type) {
    case 'feeding':
      return Colors.orange;
    case 'walking':
      return Colors.green;
    case 'vet':
      return Colors.red;
    case 'medicine':
      return Colors.blue;
    case 'bathing':
      return Colors.lightBlue;
    case 'shopping':
      return Colors.purple;
    default:
      return Colors.blueGrey;
  }
}

IconData getTaskIcon(String type) {
  switch (type) {
    case 'feeding':
      return Icons.restaurant;
    case 'walking':
      return Icons.directions_walk;
    case 'vet':
      return Icons.local_hospital;
    case 'medicine':
      return Icons.medication;
    case 'bathing':
      return Icons.shower;
    case 'shopping':
      return Icons.shopping_cart;
    default:
      return Icons.pets;
  }
}
