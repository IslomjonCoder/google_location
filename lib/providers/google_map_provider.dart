import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_location/data/api/api_service.dart';
import 'package:google_location/data/models/location_model.dart';
import 'package:google_location/data/models/result_model.dart';
import 'package:google_location/data/models/yandex_location_info/location_model.dart';
import 'package:google_location/repository/database_helper.dart';
import 'package:google_location/service/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DataState {
  loading,
  noData,
  hasData,
  error,
}

class LocationProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final ApiService apiService = ApiService();
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  Set<Polyline> polylines = {
    Polyline(
      polylineId: PolylineId('user'),
      color: Colors.red,
      width: 10,
      points: [],
      visible: true,
    )
  };

  LocationProvider() {
    currentLocation();
    getAddress();
  }

  List<LatLng> points = [];

  DataState state = DataState.loading;
  String errorMessage = '';
  List<Location> _locations = [];
  Set<Marker> _markers = {};

  MapType mapType = MapType.normal;

  setMaptype(MapType map) {
    mapType = map;
    notifyListeners();
  }

  List<Location> get locations => _locations;

  final defaultLatLng = const LatLng(41.311081, 69.240562);

  Set<Marker> get markers => _markers;

  // Utility function to update state and notify listeners
  void updateStateAndNotify(DataState value) {
    state = value;
    notifyListeners();
  }

  void deleteAllAddresses() async {
    await _databaseHelper.deleteAllAddresses();
    getAddress();
  }

  void deleteLocation(int id) async {
    await _databaseHelper.deleteAddressByID(id);
    getAddress();
  }

  Future<void> locationChanged(LatLng latLng) async {
    // await addOrUpdateAddress(latLng);
    print('ok1');
    await _databaseHelper
        .insertLocation(Location(title: '', lat: latLng.latitude, long: latLng.longitude));
    await getAddress();
    updateMarkers();
    // notifyListeners();
  }

  Future<void> getAddress() async {
    updateStateAndNotify(DataState.loading);
    try {
      _locations = await _databaseHelper.getLocations();

      (locations.isEmpty)
          ? updateStateAndNotify(DataState.noData)
          : updateStateAndNotify(DataState.hasData);
    } catch (e) {
      errorMessage = e.toString();
      updateStateAndNotify(DataState.error);
    }
    updateMarkers();
  }

  Future<void> addOrUpdateAddress(LatLng latLng, {int? id}) async {
    updateStateAndNotify(DataState.loading);
    String geocoding = _convertLatLngString(latLng);
    Result response = await apiService.fetchSingleLocationData(geocoding: geocoding);

    Location addressModel;
    if (response.isSuccess) {
      AddressModel location = response.data as AddressModel;
      final (short, full) = _getLocationName(location);
      addressModel = Location(title: full, lat: latLng.latitude, long: latLng.longitude);
    } else {
      addressModel = Location(title: 'Nomsiz joy', lat: latLng.latitude, long: latLng.longitude);
      errorMessage = response.errorMessage!;
    }

    (id != null)
        ? await _databaseHelper.updateLocation(addressModel.copyWith(id: id))
        : await _databaseHelper.insertLocation(addressModel);

    await getAddress();
    updateMarkers();
    updateStateAndNotify(DataState.hasData);
  }

  String _convertLatLngString(LatLng latLng) => '${latLng.longitude}, ${latLng.latitude}';

  (String, String) _getLocationName(AddressModel location) {
    return (
      location.response.geoObjectCollection.featureMember.first.geoObject.name,
      location.response.geoObjectCollection.featureMember.first.geoObject.metaDataProperty
          .geocoderMetaData.text,
    );
  }

  LatLng userLocation = const LatLng(41.311158, 69.279737);

  void updateMarkers() {
    _markers = locations
        .map((e) => Marker(
            markerId: MarkerId(e.id.toString()),
            position: LatLng(e.lat, e.long),
            draggable: true,
            onDragEnd: (value) {
              addOrUpdateAddress(value, id: e.id!);
            },
            infoWindow: InfoWindow(title: e.title)))
        .toSet();
  }

  void moveCameraToLatLng(LatLng latLng) async {
    final _mapController = await controller.future;
    _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void currentLocation() async {
    final GoogleMapController userCurrentLocationController = await controller.future;
    LatLng currentLocation = await LocationService.getCurrentLocation() ?? defaultLatLng;
    userCurrentLocationController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 15)));
    notifyListeners();
  }
}
