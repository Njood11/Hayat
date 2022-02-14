import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hayat_gp2_18/encryption.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(SqliteApp());
}

class SqliteApp extends StatefulWidget {
  const SqliteApp() : super();

  @override
  _SqliteAppState createState() => _SqliteAppState();
}

class _SqliteAppState extends State<SqliteApp> {
  int? donorId;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),
        body: FloatingActionButton(
          onPressed: () async {
            donorId != null
                ? await DatabaseHelper.instance.getDonors()
                : await DatabaseHelper.instance.getDonors();
            setState(() {
              textController.clear();
              donorId = null;
            });
          },
        ),
      ),
    );
  }
}

//Donors model
class Donors {
  //columns to store data in
  final int? id;
  final String email;
  final String password;
  final String name;
  final String location;
  final String type;
  final int phone;

  Donors({
    //assing values
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.location,
    required this.type,
    required this.phone,
  });

  factory Donors.fromMap(Map<String, dynamic> json) => new Donors(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        location: json['location'],
        type: json['type'],
        phone: json['phone'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'location': location,
      'type': type,
      'phone': phone,
    };
  }
}

//CHO model
class CHOs {
  //columns to store data in
  final int? id;
  final String email;
  final String password;
  final String name;
  final String location;
  final int phone;
  final int lNumber;

  CHOs({
    //assing values
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.location,
    required this.phone,
    required this.lNumber,
  });

  factory CHOs.fromMap(Map<String, dynamic> json) => new CHOs(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        location: json['location'],
        phone: json['phone'],
        lNumber: json['lNumber'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'location': location,
      'phone': phone,
      'lNumber': lNumber,
    };
  }
}

//offers model
class Offers {
  //columns to store data in
  final int? offerID;

  final String aq;
  final String eDate;
  final String fCategory;
  final String fStatus;
  final String pic;

  Offers({
    //assing values
    this.offerID,
    required this.aq,
    required this.eDate,
    required this.fCategory,
    required this.fStatus,
    required this.pic,
  });

  factory Offers.fromMap(Map<String, dynamic> json) => new Offers(
        offerID: json['offerID'],
        aq: json['aq'],
        eDate: json['eDate'],
        fCategory: json['fCategory'],
        fStatus: json['fStatus'],
        pic: json['pic'],
      );

  Map<String, dynamic> toMap() {
    return {
      'offerID': offerID,
      'aq': aq,
      'eDate': eDate,
      'fCategory': fCategory,
      'fStatus': fStatus,
      'pic': pic,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'H.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _CreateDB,
    );
  }

  Future _CreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE donors (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          password TEXT,
          name TEXT, 
          location TEXT,
          type TEXT, 
          phone INTEGER)
      ''');

    await db.execute('''
      CREATE TABLE CHOs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          password TEXT,
          name TEXT, 
          location TEXT,
          phone INTEGER, 
          lNumber INTEGER)
      ''');

    await db.execute('''
      CREATE TABLE Offers (
          offerID INTEGER PRIMARY KEY AUTOINCREMENT,
          aq TEXT,
          eDate TEXT,
          fCategory TEXT, 
          fStatus TEXT,
          pic TEXT)
          ''');
  }

//Donors function

  Future<List> getDonors() async {
    Database db = await instance.database;
    var sql = "SELECT * FROM donors";
    List result = await db.rawQuery(sql);
    print(result.toList());
    return result.toList();
  }

  Future<int> addDonor(Donors donor) async {
    Database db = await instance.database;

    return await db.insert('donors', donor.toMap());
  }

  /*Future<int> CheckDonor(String e) async {
    Database db = await instance.database;

    var res = await db.rawQuery("SELECT * FROM donors WHERE email = '$e'");
    var res2 = await db.rawQuery("SELECT * FROM CHOs WHERE email = '$e'");

    print(res.length + res2.length);

    if (res.length != 0 || res2.length != 0) {
      return res.length + res2.length;
    } else {
      return 0;
    }
  }*/
  Future<List> CheckDonor() async {
    Database db = await instance.database;

    return db.query('donors');
  }

  Future<List<Donors>> donors() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The donors.
    final List<Map<String, dynamic>> maps = await db.query('donors');

    // Convert the List<Map<String, dynamic> into a List<Donors>.
    return List.generate(maps.length, (i) {
      return Donors(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        location: maps[i]['location'],
        password: maps[i]['password'],
        phone: maps[i]['phone'],
        type: maps[i]['type'],
      );
    });
  }

//CHOs function

  Future<List> getCHOs() async {
    Database db = await instance.database;
    var sql = "SELECT * FROM CHOs";
    List result = await db.rawQuery(sql);
    print(result.toList());
    return result.toList();
  }

  Future<List> CheckCHO() async {
    Database db = await instance.database;

    return db.query('CHOs');
  }

  Future<int> addCHOs(CHOs cho) async {
    //edit from Donor to CHOs and donor to cho
    Database db = await instance.database;
    // print(await db.insert('donors', donor.toMap()));
    //var sql = "SELECT * FROM donors WHERE id =" + donor.id.toString();
    // var result = await db.rawQuery(sql);
    // if (result.length == 0) {
    return await db.insert('CHOs', cho.toMap()); //edit from donor to cho
    // } else {
    //return 0;
    //   return await db.insert('donors', donor.toMap());
    //}
  }

  //OFFERS FUNCTIONS
  Future<int> addOffer(Offers offer) async {
    Database db = await instance.database;
    return await db.insert('Offers', offer.toMap());
  }

  Future<List> getOffers() async {
    Database db = await instance.database;
    var sql = "SELECT * FROM Offers";
    List result = await db.rawQuery(sql);
    print(result.toList());
    return result.toList();
  }

  Future<List> Categorylist() async {
    Database db = await instance.database;

    return db.query('Offers');
  }

  Future<List> getPicID() async {
    Database db = await instance.database;
    return db.query('Offers');
  }

  //closing
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
