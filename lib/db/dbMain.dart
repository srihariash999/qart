import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "qart";
final String columnId = "id";
final String columnName = "name";
final String columnImageUrl = "imageurl";
final String columnOption = "option";
final String columnQrCode = "qrcode";
final String columnMrp = "mrp";
final String columnTechnologyImageUrl = "technologyimageurl";
final String columnLikeability = "likeability";
final String columnBrand = "brand";
final String columnCategory = "category";
final String columnCollection = "collection";
final String columnColor = "color";
final String columnEan = "ean";

final String columnSeason = "season";
final String columnMood = "mood";
final String columnGender = "gender";
final String columnTheme = "theme";
final String columnSubCategory = "subcategory";
final String columnDescription = "description";
final String columnFinish = "finish";
final String columnMaterial = "material";




class DbModel {
  final String name;
  final String imageUrl;
  final String option;
  final String qrCode;
  final String mrp;
  final String technologyImageUrl;
  final String likeability;
  final String brand;
  final String category;
  final String collection;
  final String color;
  final String ean;
  final String season;
  final String mood;
  final String gender;
  final String theme;
  final String subcategory;
  final String description;
  final String finish;
  final String material;

  int id;

  DbModel({
    this.name,
    this.imageUrl,
    this.option,
    this.qrCode,
    this.mrp,
    this.technologyImageUrl,
    this.likeability,
    this.brand,
    this.category,
    this.collection,
    this.color,
    this.ean,
    this.season,
    this.mood,
    this.gender,
    this.theme,
    this.subcategory,
    this.description,
    this.finish,
    this.material,
    this.id,
    
  });

  Map<String, dynamic> toMap() {
    return {
      columnName: this.name,
      columnImageUrl: this.imageUrl,
      columnOption: this.option,
      columnQrCode: this.qrCode,
      columnMrp: this.mrp,
      columnTechnologyImageUrl: this.technologyImageUrl,
      columnLikeability: this.likeability,
      columnBrand: this.brand,
      columnCategory: this.category,
      columnCollection: this.collection,
      columnColor: this.color,
      columnEan: this.ean,
      columnSeason: this.season,
      columnMood: this.mood,
      columnGender: this.gender,
      columnTheme: this.theme,
      columnSubCategory: this.subcategory,
      columnDescription: this.description,
      columnFinish: this.finish,
      columnMaterial: this.material,

    };
  }
}

class DbHelper {
  Database db;

  DbHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnImageUrl Text, $columnOption TEXT, $columnQrCode TEXT, $columnMrp TEXT, $columnTechnologyImageUrl TEXT , $columnLikeability TEXT, $columnBrand TEXT, $columnCategory TEXT, $columnCollection TEXT, $columnColor TEXT, $columnEan TEXT, $columnSeason TEXT, $columnMood TEXT, $columnGender TEXT, $columnTheme TEXT, $columnSubCategory TEXT, $columnDescription TEXT, $columnFinish TEXT, $columnMaterial TEXT)");
    }, version: 1);
  }

  Future<void> insertItem(DbModel task) async {
    try {
      await db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<String> insertBatchOfItems(jsonResponse) async {
    try {
      var batchi = db.batch();

      // print(newEan);
      print(jsonResponse['Products'][10]['Option'].toString());
      for (int i = 1; i < jsonResponse['ProductCount']; i++) {
        List<String> newEan = [];
        for (var k in jsonResponse['Products'][i]['EAN'].keys) {
          newEan.add(k.toString());
        }
        String jsonUser = jsonEncode(newEan);

        DbModel currentItem = DbModel(
          name: jsonResponse['Products'][i]['Name'].toString(),
          imageUrl: jsonResponse['Products'][i]['ImageUrl'].toString(),
          option: jsonResponse['Products'][i]['Option'].toString(),
          qrCode: jsonResponse['Products'][i]['QRCode'].toString(),
          mrp: jsonResponse['Products'][i]['MRP'].toString(),
          technologyImageUrl: jsonResponse['Products'][i]['TechnologyImageUrl'].toString(),
          likeability: jsonResponse['Products'][i]['Likeabilty'].toString(),
          brand: jsonResponse['Products'][i]['Brand'].toString(),
          category: jsonResponse['Products'][i]['Category'].toString(),
          collection: jsonResponse['Products'][i]['Collection'].toString(),
          color: jsonResponse['Products'][i]['Color'].toString(),
          season: jsonResponse['Products'][i]['Season'].toString() ,
          mood: jsonResponse['Products'][i]['Mood'].toString(),
          gender: jsonResponse['Products'][i]['Gender'].toString(),
          theme: jsonResponse['Products'][i]['Theme'].toString(),
          subcategory: jsonResponse['Products'][i]['SubCategory'].toString(),
          description: jsonResponse['Products'][i]['Description'].toString(),
          finish: jsonResponse['Products'][i]['Finish'].toString(),
          material: jsonResponse['Products'][i]['Material'].toString(),
          ean: jsonUser,
        );
        if (i == 10) print(currentItem.toMap());
        batchi.insert(tableName, currentItem.toMap());
      }
      await batchi.commit(noResult: true);
      print("Batch operation done");
      return "Batch operation done";
    } catch (_) {
      print(_);
      return "Batch operation failed";
    }
  }

  Future<void> clearTable() async {
    try {
      await db.execute("DELETE FROM  $tableName");
      print("table $tableName is cleared");
    } catch (_) {
      print(_);
    }
  }

  Future<List<DbModel>> getAllItems() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    var h = List.generate(tasks.length, (i) {
      return DbModel(
          name: tasks[i][columnName],
          id: tasks[i][columnId],
          imageUrl: tasks[i][columnImageUrl],
          option: tasks[i][columnOption],
          qrCode: tasks[i][columnQrCode],
          mrp: tasks[i][columnMrp],
          technologyImageUrl: tasks[i][columnTechnologyImageUrl],
          likeability: tasks[i][columnLikeability],
          brand: tasks[i][columnBrand],
          category: tasks[i][columnCategory],
          collection: tasks[i][columnCollection],
          color: tasks[i][columnColor],
          season: tasks[i][columnSeason],
          mood: tasks[i][columnMood],
          gender: tasks[i][columnGender],
          theme: tasks[i][columnTheme],
          subcategory: tasks[i][columnSubCategory],
          description: tasks[i][columnDescription],
          finish: tasks[i][columnFinish],
          material:tasks[i][columnMaterial],
          ean: tasks[i][columnEan]          
          
          );
    });
    print("no of items in db: " + h.length.toString());
   
    //print(ten[columnEan]);
    return h;
  }
}
