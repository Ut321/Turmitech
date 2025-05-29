import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/kitchen_model.dart';
import '../models/meal_plan_model.dart';

abstract class KitchenRemoteDataSource {
  Future<List<KitchenModel>> getKitchens();
  Future<List<MealPlanModel>> getMealPlans();
  Future<List<KitchenModel>> searchKitchens(String query);
  Future<List<MealPlanModel>> searchMealPlans(String query);
  Future<KitchenModel> updateKitchen(KitchenModel kitchen);
}

class KitchenRemoteDataSourceImpl implements KitchenRemoteDataSource {
  final http.Client client;

  KitchenRemoteDataSourceImpl({required this.client});

  @override
  Future<List<KitchenModel>> getKitchens() async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.kitchensEndpoint}';
      print('🌐 Fetching kitchens from: $url');
      
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(ApiConstants.connectTimeout);

      print('📡 Response status: ${response.statusCode}');
      print('📄 Raw response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print('🔍 Parsed response type: ${responseData.runtimeType}');
        print('🔍 Parsed response data: $responseData');
        
        List<dynamic> kitchensList;
        
        if (responseData is List) {
          // Direct list response
          kitchensList = responseData;
        } else if (responseData is Map<String, dynamic>) {
          // Response wrapped in an object
          if (responseData.containsKey('kitchens')) {
            kitchensList = responseData['kitchens'] as List<dynamic>;
          } else if (responseData.containsKey('data')) {
            kitchensList = responseData['data'] as List<dynamic>;
          } else {
            // Try to find the list in the response
            final possibleList = responseData.values.firstWhere(
              (value) => value is List,
              orElse: () => null,
            );
            if (possibleList != null) {
              kitchensList = possibleList as List<dynamic>;
            } else {
              throw ServerException('No list found in response: $responseData');
            }
          }
        } else {
          throw ServerException('Unexpected response format: ${responseData.runtimeType}');
        }
        
        print('🍽️ Kitchens list length: ${kitchensList.length}');
        
        return kitchensList.map((item) {
          print('🔍 Processing kitchen item: $item (${item.runtimeType})');
          
          if (item is Map<String, dynamic>) {
            return KitchenModel.fromJson(item);
          } else {
            throw ServerException('Kitchen item is not a Map: ${item.runtimeType}');
          }
        }).toList();
        
      } else {
        throw ServerException('Server returned status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw NetworkException('No internet connection: ${e.message}');
    } on TimeoutException catch (e) {
      throw NetworkException('Connection timeout: ${e.message}');
    } on FormatException catch (e) {
      throw ServerException('Invalid JSON response: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw NetworkException('Unexpected error: $e');
    }
  }

  @override
  Future<List<MealPlanModel>> getMealPlans() async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.mealPlansEndpoint}';
      print('🌐 Fetching meal plans from: $url');
      
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(ApiConstants.connectTimeout);

      print('📡 Response status: ${response.statusCode}');
      print('📄 Raw response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print('🔍 Parsed response type: ${responseData.runtimeType}');
        print('🔍 Parsed response data: $responseData');
        
        List<dynamic> mealPlansList;
        
        if (responseData is List) {
          // Direct list response
          mealPlansList = responseData;
        } else if (responseData is Map<String, dynamic>) {
          // Response wrapped in an object
          if (responseData.containsKey('meal-plans')) {
            mealPlansList = responseData['meal-plans'] as List<dynamic>;
          } else if (responseData.containsKey('mealPlans')) {
            mealPlansList = responseData['mealPlans'] as List<dynamic>;
          } else if (responseData.containsKey('data')) {
            mealPlansList = responseData['data'] as List<dynamic>;
          } else {
            // Try to find the list in the response
            final possibleList = responseData.values.firstWhere(
              (value) => value is List,
              orElse: () => null,
            );
            if (possibleList != null) {
              mealPlansList = possibleList as List<dynamic>;
            } else {
              throw ServerException('No list found in response: $responseData');
            }
          }
        } else {
          throw ServerException('Unexpected response format: ${responseData.runtimeType}');
        }
        
        print('🍽️ Meal plans list length: ${mealPlansList.length}');
        
        return mealPlansList.map((item) {
          print('🔍 Processing meal plan item: $item (${item.runtimeType})');
          
          if (item is Map<String, dynamic>) {
            return MealPlanModel.fromJson(item);
          } else {
            throw ServerException('Meal plan item is not a Map: ${item.runtimeType}');
          }
        }).toList();
        
      } else {
        throw ServerException('Server returned status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw NetworkException('No internet connection: ${e.message}');
    } on TimeoutException catch (e) {
      throw NetworkException('Connection timeout: ${e.message}');
    } on FormatException catch (e) {
      throw ServerException('Invalid JSON response: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw NetworkException('Unexpected error: $e');
    }
  }

  @override
  Future<List<KitchenModel>> searchKitchens(String query) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.kitchensEndpoint}?name_like=$query';
      final response = await client.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => KitchenModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to search kitchens: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<List<MealPlanModel>> searchMealPlans(String query) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.mealPlansEndpoint}?kitchenName_like=$query';
      final response = await client.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => MealPlanModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to search meal plans: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<KitchenModel> updateKitchen(KitchenModel kitchen) async {
    try {
      final url = '${ApiConstants.baseUrl}${ApiConstants.kitchensEndpoint}/${kitchen.id}';
      final response = await client.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(kitchen.toJson()),
      );
      
      if (response.statusCode == 200) {
        return KitchenModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException('Failed to update kitchen: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: $e');
    }
  }
}