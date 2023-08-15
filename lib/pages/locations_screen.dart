import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_location/data/models/location_model.dart';
import 'package:google_location/providers/google_map_provider.dart';
import 'package:google_location/providers/tabbox_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Locations'),
        actions: [
          IconButton(
              onPressed: () {
                provider.deleteAllAddresses();
              },
              icon: const Icon(CupertinoIcons.trash))
        ],
      ),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          switch (provider.state) {
            case DataState.loading:
              return const Center(child: CircularProgressIndicator());
            case DataState.noData:
              return const Center(child: Text('Addresses list is empty'));
            case DataState.error:
              return Center(
                  child: Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
              ));
            case DataState.hasData:
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: provider.locations.length,
                itemBuilder: (context, index) {
                  Location address = provider.locations[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<TabBoxProvider>().changeIndex = 0;
                      provider.moveCameraToLatLng(LatLng(address.lat, address.long));
                    },
                    child: Dismissible(
                      key: Key(index.toString()),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          provider.deleteLocation(address.id!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.black.withOpacity(0.8),
                            content: const Text('Location deleted'),
                          ));
                        }
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return direction == DismissDirection.endToStart;
                      },
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      background: Container(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, color: Colors.black),
                                  text: 'Place: ',
                                  children: [
                                TextSpan(
                                    text: address.title,
                                    style: const TextStyle(fontWeight: FontWeight.w400))
                              ])),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Place address:',
                          //       style: TextStyle(fontWeight: FontWeight.w600),
                          //     ),
                          //     Flexible(child: Text(address.title)),
                          //   ],
                          // ),
                          Text("Lat: ${address.lat}"),
                          Text("Long: ${address.long}"),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
              );
            default:
              return Center(
                child: Text('Some Error provider state is ${provider.state.name}'),
              );
          }
        },
      ),
    );
  }
}
