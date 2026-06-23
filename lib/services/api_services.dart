import 'package:dio/dio.dart';
import 'package:latihan_flutter/models/harry_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://hp-api.onrender.com/api/characters')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/posts')
  Future<List<Welcome>> getAllPosts();
}
