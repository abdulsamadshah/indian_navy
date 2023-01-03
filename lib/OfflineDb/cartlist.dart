import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Model/Cart.dart';

class Cartdbhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productid VARCHAR UNIQUE,productname TEXT,productimage TEXT,productprice TEXT, finaltotalprice TEXT , quantity INTEGER,pack_size INTEGER,userid INTEGER )');
  }

  Future<Cart> insertcartdata(Cart cart) async {
    print(cart.toMap());
    var dbClient = await db;
    await dbClient?.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getcartdata() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deletecartdata(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCartdata(Cart cart) async {
    var dbClient = await db;
    return await dbClient!
        .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }


}
