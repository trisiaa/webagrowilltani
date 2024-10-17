import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

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

  @Post(path: 'iot/greenhouse')
  Future<Response> createGreenhouse(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/iot/greenhouse')
  Future<Response> getAllGreenhouses(
    @Header('Authorization') String token,
  );

  @Post(path: '/iot/greenhouse/{id}')
  Future<Response> updateGreenhouse(
    @Header('Authorization') String token,
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: '/iot/greenhouse/{id}')
  Future<Response> deleteGreenhouse(
    @Header('Authorization') String token,
    @Path('id') int id,
  );

  @Get(path: '/iot/perangkat')
  Future<Response> getAllPerangkat(
    @Header('Authorization') String token,
  );

  @Post(path: '/iot/perangkat')
  Future<Response> createPerangkat(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @Put(path: '/iot/perangkat/{id}')
  Future<Response> updatePerangkat(
    @Header('Authorization') String token,
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: '/iot/perangkat/{id}')
  Future<Response> deletePerangkat(
    @Header('Authorization') String token,
    @Path('id') int id,
  );

  @Get(path: '/iot/sensor/{gh_id}/lastest')
  Future<Response> getLatestSensorData(
      @Header('Authorization') String token, @Path('gh_id') int ghId);

  @Get(path: '/iot/sensor/{gh_id}/chart')
  Future<Response> getGraphSensorData(
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
