import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart'; // Part file for generated code

@ChopperApi()
abstract class ApiService extends ChopperService {
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

  @Post(path: '/greenhouse')
  Future<Response> createGreenhouse(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/iot/greenhouse')
  Future<Response> getAllGreenhouses(
    @Header('Authorization') String token,
  );

  @Get(path: '/iot/sensor/{gh_id}/lastest')
  Future<Response> getLatestSensorData(
      @Header('Authorization') String token, @Path('gh_id') int ghId);

  @Put(path: '/iot/pompa/{id}')
  Future<Response> updatePompa(
    @Header('Authorization') String token,
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/iot/pompa/{id}')
  Future<Response> getLatestPompaData(
      @Header('Authorization') String token, @Path('id') int id);

  @Get(path: '/iot/jenis-tanaman')
  Future<Response> getTanaman(@Header('Authorization') String token);

  @Get(path: '/iot/kontrol/{id}')
  Future<Response> getKontrolData(
    @Header('Authorization') String token,
    @Path('id') int id,
  );

  @Put(path: '/iot/kontrol/{id}')
  Future<Response> updateKontrolData(
    @Header('Authorization') String token,
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  static ApiService create([ChopperClient? client]) => _$ApiService(client);
}
