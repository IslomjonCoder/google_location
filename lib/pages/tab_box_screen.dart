import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_location/pages/google_map_screen.dart';
import 'package:google_location/pages/locations_screen.dart';
import 'package:google_location/providers/tabbox_provider.dart';
import 'package:google_location/service/location_service.dart';
import 'package:provider/provider.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({Key? key}) : super(key: key);

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  List<Widget> pages = [
    const GoogleMapScreen(),
    const LocationsScreen(),
  ];
  @override
  void initState() {
    LocationService(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TabBoxProvider>(context);

    return Scaffold(
      body: IndexedStack(index: provider.activeIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => provider.changeIndex = value,
        currentIndex: provider.activeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bookmark), label: "Saved"),
        ],
      ),
    );
  }
}
