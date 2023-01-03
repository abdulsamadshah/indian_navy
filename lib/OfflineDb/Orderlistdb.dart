import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Model/Cart.dart';
import '../Model/Orderlist.dart';

class Orderdbhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'order.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE order (cartid INTEGER PRIMARY KEY , order_number VARCHAR UNIQUE,productname TEXT,customer_name TEXT,customer_address TEXT, Sub_total TEXT,total_amount TEXT,product_name TEXT,status TEXT,Deliverytime TEXT, qty INTEGER,Rate INTEGER,Total INTEGER )');
  }

  Future<Orderlist> insertorderdata(Orderlist order) async {
    print(order.toMap());
    var dbClient = await db;
    await dbClient?.insert('order', order.toMap());
    return order;
  }

  Future<List<Orderlist>> getorderdata() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('order');
    return queryResult.map((e) => Orderlist.fromMap(e)).toList();
  }
}
