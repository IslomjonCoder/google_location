import 'package:google_location/data/models/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  factory DatabaseHelper() => instance;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'my_db.db');
    return await openDatabase(dbPath, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY,
        title TEXT,
        lat DOUBLE,
        long DOUBLE
      );
      ''');
    await db.execute('''CREATE TABLE latlng (
        id INTEGER PRIMARY KEY,
        lat DOUBLE,
        long DOUBLE
      );
    ''');
  }

  // ============================== CRUD latlng ==============================
  Future<void> insertDotLatlng(LatLng latLng) async {
    final db = await database;
    await db.insert('latlng', {"lat": latLng.latitude, "long": latLng.longitude});
  }

  getLatlngs() async {
    final db = await database;
    return await db.query('latlng');
  }
  // ============================== CRUD ==============================

  Future<List<Location>> getLocations() async {
    final db = await database;
    final addresses = await db.query('locations');

    return addresses.map((e) => Location.fromJson(e)).toList();
  }

  Future<void> insertLocation(Location address) async {
    final db = await database;
    await db.insert('locations', address.toJson());
    print('ok2');
  }

  Future<void> updateLocation(Location newAddress) async {
    final db = await database;
    await db.update('locations', newAddress.toJson(), where: 'id=?', whereArgs: [newAddress.id]);
  }

  Future<void> deleteAddressByID(int id) async {
    final db = await database;
    db.delete("locations", where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteAllAddresses() async {
    final db = await database;
    db.delete("locations");
  }
}
