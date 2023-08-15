import 'dart:io';

import 'package:dio/dio.dart';
import 'package:google_location/data/models/yandex_location_info/location_model.dart';
import 'package:google_location/data/models/result_model.dart';
import 'package:google_location/utils/constants.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<Result> fetchSingleLocationData(
      {required String geocoding, String language = 'uz_UZ', String kind = 'house'}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: {
        'geocode': geocoding,
        'apikey': apiKey,
        'format': 'json',
        'lang': language,
        'kind': kind,
        'results': 1,
      });
      if (response.statusCode == HttpStatus.ok) {
        return Result.success(AddressModel.fromJson(response.data));
      }
      return Result.fail(
          "Status code not equal to 200. Status code now equal to ${response.statusCode}");
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
