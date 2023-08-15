import 'package:google_location/data/models/yandex_location_info/feature_member_model.dart';
import 'package:google_location/data/models/yandex_location_info/geo_object_collection_meta_data_property.dart';

class GeoObjectCollection {
  final GeoObjectCollectionMetaDataProperty metaDataProperty;
  final List<FeatureMember> featureMember;

  GeoObjectCollection({
    required this.metaDataProperty,
    required this.featureMember,
  });

  factory GeoObjectCollection.fromJson(Map<String, dynamic> json) {
    print("ok9");
    return GeoObjectCollection(
      metaDataProperty: GeoObjectCollectionMetaDataProperty.fromJson(
          json["metaDataProperty"]),
      featureMember: List<FeatureMember>.from(
          json["featureMember"].map((x) => FeatureMember.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "metaDataProperty": metaDataProperty.toJson(),
        "featureMember":
            List<dynamic>.from(featureMember.map((x) => x.toJson())),
      };
}
