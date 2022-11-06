import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/coffee_api.dart';

import 'package:admin_dashboard/models/categorie.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier{
  
  List< Categoria > categories = [];
  getCategories() async {
    final resp = await CoffeeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);
    this.categories = [ ...categoriesResp.categorias];
    notifyListeners();
  }

  Future<void> newCategory (String name) async {
    final data = {
      'nombre': name
    };
    try {
      final resp = await CoffeeApi.httpPost('/categorias', data);
      final newCategory = Categoria.fromMap(resp);
      categories.add( newCategory );
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error to create category';
    }
  }
  Future<void> updateCategory(String id, String name) async {
    final data = {
      'nombre': name
    };
    try {
      await CoffeeApi.httpPut('/categorias/$id', data);
      categories = categories.map((category) {
        if (category.id == id) {
          category.nombre = name;
        }
        return category;
      },).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error to update category';
    }
  }
  Future<void> deleteCategory(String id) async {
    try {
      await CoffeeApi.httpDelete('/categorias/$id');
      categories.removeWhere((category) => category.id == id);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}