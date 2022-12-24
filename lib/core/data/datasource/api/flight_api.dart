import 'package:challenge1/core/data/model/flight/flight.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import '../../model/api_response.dart';

part '../../../../gen/core/data/datasource/api/flight_api.g.dart';

@RestApi()
@Injectable() // dependensi yang diperlukan oleh kelas dengan anotasi injectable akan diresolve otomatis
abstract class FlightApi {
  @factoryMethod // diperlukan anotasi factoryMethod jika objek dibuat menggunakan factory
  factory FlightApi(Dio dio) = _FlightApi;

  // sisanya sama persis seperti retrofit di android
  @GET('/dummy_/station.json')
  Future<ApiResponse<List<Flight>>> getFlight();
}
