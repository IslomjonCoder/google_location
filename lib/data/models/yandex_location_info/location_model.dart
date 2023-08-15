import 'package:google_location/data/models/yandex_location_info/response_model.dart';

class AddressModel {
  final Response response;

  AddressModel({
    required this.response,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    print("ok14");
    return AddressModel(
      response: Response.fromJson(json["response"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}
