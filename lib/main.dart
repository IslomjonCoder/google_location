import 'package:flutter/material.dart';
import 'package:google_location/pages/tab_box_screen.dart';
import 'package:google_location/providers/google_map_provider.dart';
import 'package:google_location/providers/locations_provider.dart';
import 'package:google_location/providers/tabbox_provider.dart';
import 'package:google_location/service/location_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => LocationsProvider()),
        ChangeNotifierProvider(create: (context) => TabBoxProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabBoxScreen(),
      ),
    );
  }
}
