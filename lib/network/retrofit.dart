import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class Retrofit {
  factory Retrofit(Dio dio, {String? baseUrl}) = _Retrofit;

  @GET("users")
  Future<HttpResponse<dynamic>> getUsers(
  );


}
