

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CoffeeApi {
  
  static final Dio _dio = Dio();
  static void configureDio() {
    // * Base url
    _dio.options.baseUrl = 'http://localhost:8080/api';
    // * Configure headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.get('token') ?? ''
    };
  }

  static Future httpGet( String path ) async {
    try {
      final response =  await _dio.get(path);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        throw('Error in get');
      }
    }
  }

  static Future httpPost( String path, Map<String, dynamic> data ) async {
    final formData = FormData.fromMap(data);
    try {
      final response =  await _dio.post( path, data: formData);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        throw('Error in post');
      }
    }
  }

  static Future httpPut( String path, Map<String, dynamic> data ) async {
    final formData = FormData.fromMap(data);
    try {
      final response =  await _dio.put( path, data: formData);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        throw('Error in put');
      }
    }
  }

  static Future httpDelete( String path ) async {
    try {
      final response =  await _dio.delete( path);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        throw('Error in delete');
      }
    }
  }

}