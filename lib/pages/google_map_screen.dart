import 'package:flutter/material.dart';
import 'package:google_location/providers/google_map_provider.dart';
import 'package:google_location/utils/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/style.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleMapProvider = Provider.of<LocationProvider>(context);
    print("yangilandi");
    print(googleMapProvider.polylines.first.points.length);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          AppImages.google,
          // fit: BoxFit.scaleDown,
          height: 100,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              compassEnabled: true,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              mapType: googleMapProvider.mapType,
              markers: googleMapProvider.markers,
              polylines: googleMapProvider.polylines,
              onLongPress: (argument) {
                googleMapProvider.addOrUpdateAddress(argument);
              },
              initialCameraPosition:
                  CameraPosition(target: googleMapProvider.userLocation, zoom: 12),
              onMapCreated: (controller) => googleMapProvider.controller.complete(controller),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  showMapType(context);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.layers_outlined),
                ),
              ),
            ),
            if (googleMapProvider.state == DataState.loading)
              Center(child: CircularProgressIndicator())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => googleMapProvider.currentLocation(),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

Future<dynamic> showMapType(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Xarita turi",
                style: AppStyle.body1,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MapTypeButton(
                onTap: () {
                  context.read<LocationProvider>().setMaptype(MapType.normal);
                  Navigator.pop(context);
                },
                title: 'Standart',
                imageUrl: AppImages.normal,
                mapType: MapType.normal,
              ),
              MapTypeButton(
                onTap: () {
                  context.read<LocationProvider>().setMaptype(MapType.hybrid);
                  Navigator.pop(context);
                },
                title: 'Sputnik',
                imageUrl: AppImages.transport,
                mapType: MapType.hybrid,
              ),
              MapTypeButton(
                onTap: () {
                  context.read<LocationProvider>().setMaptype(MapType.terrain);
                  Navigator.pop(context);
                },
                title: 'Terrain',
                imageUrl: AppImages.terrain,
                mapType: MapType.terrain,
              ),
            ],
          )
        ],
      ),
    ),
  );
}
// }

class MapTypeButton extends StatelessWidget {
  MapTypeButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.imageUrl,
      required this.mapType});

  VoidCallback? onTap;
  String title;
  String imageUrl;
  MapType mapType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Provider.of<LocationProvider>(context).mapType == mapType
                    ? Border.all(color: Colors.blue, width: 3)
                    : null),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Provider.of<LocationProvider>(context).mapType == mapType
                ? const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)
                : null,
          )
        ],
      ),
    );
  }
}
//
