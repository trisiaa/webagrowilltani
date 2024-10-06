import 'package:chopper/chopper.dart';
import 'api_service.dart'; // Import your API service

class ApiClient {
  // Singleton pattern (Optional): To ensure there's only one instance of ApiClient
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  late ChopperClient _chopperClient;
  var uri = Uri.parse("http://192.168.1.6:8000/api");

  // Initialize the ChopperClient with a base URL
  void initialize() {
    _chopperClient = ChopperClient(
      baseUrl: uri, // Your base URL here
      services: [
        ApiService.create(), // Attach your ApiService
      ],
      converter: const JsonConverter(), // To handle JSON serialization/deserialization
    );
  }

  // Access the ApiService
  ApiService get apiService => _chopperClient.getService<ApiService>();
}
