import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart'; // Part file for generated code

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: '/data')
  Future<Response> fetchData();

  // Login endpoint
  @Post(path: '/login')
  Future<Response> login(
    @Body() Map<String, dynamic> body,
  );

  // Register endpoint
  @Post(path: '/register')
  Future<Response> register(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: '/logout')
  Future<Response> logout(
    @Header('Authorization') String token, // Add the authorization header
  );

  static ApiService create([ChopperClient? client]) => _$ApiService(client);
}
