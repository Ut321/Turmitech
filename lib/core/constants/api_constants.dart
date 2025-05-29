class ApiConstants {
  static const String baseUrl = 'http://192.168.99.199:3000';
  static const String kitchensEndpoint = '/kitchens';
  static const String mealPlansEndpoint = '/mealPlans';
  
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}