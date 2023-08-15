import 'package:google_location/data/models/yandex_location_info/address_details.dart';
import 'package:google_location/data/models/yandex_location_info/address_model.dart';

class GeocoderMetaData {
  final String precision;
  final String text;
  final String kind;
  final Address address;
  final AddressDetails addressDetails;

  GeocoderMetaData({
    required this.precision,
    required this.text,
    required this.kind,
    required this.address,
    required this.addressDetails,
  });

  factory GeocoderMetaData.fromJson(Map<String, dynamic> json) {
    print("ok12");
    return GeocoderMetaData(
      precision: json["precision"],
      text: json["text"],
      kind: json["kind"],
      address: Address.fromJson(json["Address"]),
      addressDetails: AddressDetails.fromJson(json["AddressDetails"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "precision": precision,
        "text": text,
        "kind": kind,
        "Address": address.toJson(),
        "AddressDetails": addressDetails.toJson(),
      };
}
