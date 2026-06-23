import 'package:dio/dio.dart';
import 'package:latihan_flutter/models/harry_models.dart';
import 'package:retrofit/retrofit.dart';

part 'harry_api_services.g.dart';

@RestApi(baseUrl: 'https://hp-api.onrender.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/characters')
  Future<List<Welcome>> getAllPosts();
}
