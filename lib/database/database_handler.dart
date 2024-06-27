import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:databases_final_project/models/relationship.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  // Singleton pattern
  static final DatabaseHandler _databaseHandler = DatabaseHandler._internal();
  factory DatabaseHandler() => _databaseHandler;
  DatabaseHandler._internal();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var path = join(await getDatabasesPath(), 'database.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> deleteTables() async {
    final path = join(await getDatabasesPath(), 'database.db');
    await deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "MEMBERS" (
      	"mid"	INTEGER NOT NULL,
      	"occupationalStatus"	TEXT NOT NULL,
      	"membershipType"	TEXT NOT NULL,
      	"memberName"	TEXT NOT NULL,
      	"motherName"	TEXT NOT NULL,
      	"fatherName"	TEXT NOT NULL,
      	"spouseName"	TEXT,
      	"dateOfBirth"	TEXT NOT NULL,
      	"placeOfBirth"	TEXT NOT NULL,
      	"sex"	TEXT NOT NULL,
      	"height"	TEXT NOT NULL,
      	"weight"	TEXT NOT NULL,
      	"maritalStatus"	TEXT NOT NULL,
      	"citizenship"	TEXT NOT NULL,
      	"frequencyOfPayment"	TEXT NOT NULL,
      	"tin"	TEXT NOT NULL,
      	"sss"	TEXT NOT NULL,
      	"permanentAddress"	TEXT NOT NULL,
      	"presentAddress"	TEXT NOT NULL,
      	"preferredAddress"	TEXT NOT NULL,
      	"cellphoneNumber"	TEXT NOT NULL,
      	"dateOfRegistration"	TEXT NOT NULL,
      	UNIQUE("mid"),
      	PRIMARY KEY("mid" AUTOINCREMENT),
        UNIQUE("occupationalStatus","membershipType","memberName","motherName","fatherName","spouseName","dateOfBirth","placeOfBirth","sex","height","weight","maritalStatus","citizenship","frequencyOfPayment","tin","sss","permanentAddress","presentAddress","preferredAddress","cellphoneNumber","dateOfRegistration")
      )
    ''');
    await db.execute('''
      CREATE TABLE "EMPLOYERS" (
	      "employerKey"	INTEGER NOT NULL,
	      "employerName"	TEXT NOT NULL,
	      "employerAddress"	TEXT NOT NULL,
	      PRIMARY KEY("employerKey" AUTOINCREMENT),
        UNIQUE("employerName","employerAddress")
      )
    ''');
    await db.execute('''
      CREATE TABLE "HEIRS" (
      	"heirKey"	INTEGER NOT NULL,
      	"heirName"	TEXT NOT NULL,
      	"heirDateOfBirth"	TEXT NOT NULL,
      	PRIMARY KEY("heirKey" AUTOINCREMENT),
        UNIQUE("heirName","heirDateOfBirth")
      )
    ''');
    await db.execute('''
      CREATE TABLE "EMPLOYMENT" (
      	"mid"	INTEGER NOT NULL,
      	"employerKey"	INTEGER NOT NULL,
      	"isCurrentEmployment"	TEXT NOT NULL,
      	"occupation"	TEXT NOT NULL,
      	"employmentStatus"	TEXT NOT NULL,
      	"totalMonthlyIncome"	TEXT NOT NULL,
      	"dateEmployed"	TEXT NOT NULL,
      	PRIMARY KEY("mid","employerKey"),
      	FOREIGN KEY("employerKey") REFERENCES "EMPLOYERS"("employerKey"),
      	FOREIGN KEY("mid") REFERENCES "MEMBERS"("mid")
      )
    ''');
    await db.execute('''
      CREATE TABLE "HEIR_RELATIONSHIPS" (
      	"mid"	INTEGER NOT NULL,
      	"heirKey"	INTEGER NOT NULL,
      	"heirRelationship"	TEXT NOT NULL,
      	PRIMARY KEY("mid","heirKey"),
      	FOREIGN KEY("heirKey") REFERENCES "HEIRS"("heirKey"),
      	FOREIGN KEY("mid") REFERENCES "MEMBERS"("mid")
      )
    ''');
  }

  Future<void> insertMember(Member member) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'MEMBERS',
      member.toMap(),
    );
  }

  Future<void> updateMember(Member member) async {
    final db = await _databaseHandler.database;
    await db.update(
      'MEMBERS',
      member.toMap(),
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
  }

  Future<void> deleteMember(Member member) async {
    final db = await _databaseHandler.database;
    await db.delete(
      'MEMBERS',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
  }

  Future<void> insertEmployer(Employer employer) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'EMPLOYERS',
      employer.toMap(),
    );
  }

  Future<void> insertHeir(Heir heir) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'HEIRS',
      heir.toMap(),
    );
  }

  Future<List<Member>> getMembers() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('MEMBERS');
    return List.generate(maps.length, (index) => Member.fromMap(maps[index]));
  }

  Future<List<Employer>> getEmployers() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('EMPLOYERS');
    return List.generate(maps.length, (index) => Employer.fromMap(maps[index]));
  }

  Future<List<Employment>> getEmployment(Member member) async {
    final db = await _databaseHandler.database;
    final mid = member.mid;
    final List<Map<String, dynamic>> maps = await db.query(
      'EMPLOYERS NATURAL JOIN EMPLOYMENT',
      where: '"mid" = ?',
      whereArgs: [mid],
      orderBy: 'dateEmployed DESC',
    );
    return List.generate(
        maps.length, (index) => Employment.fromMap(maps[index]));
  }

  Future<List<Heir>> getHeirs() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('HEIRS');
    return List.generate(maps.length, (index) => Heir.fromMap(maps[index]));
  }

  Future<List<Relationship>> getRelationships(Member member) async {
    final db = await _databaseHandler.database;
    final mid = member.mid;
    final List<Map<String, dynamic>> maps = await db.query(
      'HEIRS NATURAL JOIN HEIR_RELATIONSHIPS',
      where: '"mid" = ?',
      whereArgs: [mid],
    );
    return List.generate(
        maps.length, (index) => Relationship.fromMap(maps[index]));
  }

  Future<void> deleteAllRows() async {
    final db = await _databaseHandler.database;
    await db.execute('DELETE FROM MEMBERS');
    await db.execute('DELETE FROM EMPLOYERS');
    await db.execute('DELETE FROM HEIRS');
    await db.execute('DELETE FROM EMPLOYMENT');
    await db.execute('DELETE FROM HEIR_RELATIONSHIPS');
  }

  Future<void> rawQuery(String query) async {
    final db = await _databaseHandler.database;
    await db.rawQuery(query);
  }
}
