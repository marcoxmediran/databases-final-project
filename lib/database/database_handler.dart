import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:databases_final_project/models/relationship.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

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
    var path = 'database.db';
    databaseFactory = databaseFactoryFfiWeb;
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
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
    ''',
    );
    await db.execute(
      '''
      CREATE TABLE "EMPLOYERS" (
	      "employerKey"	INTEGER NOT NULL,
	      "employerName"	TEXT NOT NULL,
	      "employerAddress"	TEXT NOT NULL,
        CHECK(
          employerName != ''
          AND employerAddress != ''
        ),
	      PRIMARY KEY("employerKey" AUTOINCREMENT),
        UNIQUE("employerName","employerAddress")
      )
    ''',
    );
    await db.execute(
      '''
      CREATE TABLE "HEIRS" (
      	"heirKey"	INTEGER NOT NULL,
      	"heirName"	TEXT NOT NULL,
      	"heirDateOfBirth"	TEXT NOT NULL,
        CHECK(
          heirName != ''
          AND heirDateOfBirth != ''
        ),
      	PRIMARY KEY("heirKey" AUTOINCREMENT),
        UNIQUE("heirName","heirDateOfBirth")
      )
    ''',
    );
    await db.execute(
      '''
      CREATE TABLE "EMPLOYMENT" (
      	"mid"	INTEGER NOT NULL,
      	"employerKey"	INTEGER NOT NULL,
      	"isCurrentEmployment"	TEXT NOT NULL,
      	"occupation"	TEXT NOT NULL,
      	"employmentStatus"	TEXT NOT NULL,
      	"totalMonthlyIncome"	TEXT NOT NULL,
      	"dateEmployed"	TEXT NOT NULL,
        CHECK(
          isCurrentEmployment IN ('Yes', 'No')
          AND LENGTH("occupation") > 0
          AND employmentStatus IN ('Regular', 'Casual', 'Contractual', 'Project-Based', 'Part-Time')
          AND totalMonthlyIncome != ''
          AND dateEmployed != ''
        ),
      	PRIMARY KEY("mid","employerKey"),
      	FOREIGN KEY("employerKey") REFERENCES "EMPLOYERS"("employerKey"),
      	FOREIGN KEY("mid") REFERENCES "MEMBERS"("mid")
      )
    ''',
    );
    await db.execute(
      '''
      CREATE TABLE "HEIR_RELATIONSHIPS" (
      	"mid"	INTEGER NOT NULL,
      	"heirKey"	INTEGER NOT NULL,
      	"heirRelationship"	TEXT NOT NULL,
      	PRIMARY KEY("mid","heirKey"),
      	FOREIGN KEY("heirKey") REFERENCES "HEIRS"("heirKey"),
      	FOREIGN KEY("mid") REFERENCES "MEMBERS"("mid")
      )
    ''',
    );
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
      'EMPLOYMENT',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
    await db.delete(
      'HEIR_RELATIONSHIPS',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
    await db.delete(
      'MEMBERS',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
  }

  Future<int> insertEmployer(Employer employer) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'EMPLOYERS',
      employer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    final List<Map<String, dynamic>> maps = await db.query(
      'EMPLOYERS',
      where: 'employerName = ? AND employerAddress = ?',
      whereArgs: [employer.employerName, employer.employerAddress],
      limit: 1,
    );
    return maps[0]['employerKey'];
  }

  Future<int> insertHeir(Heir heir) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'HEIRS',
      heir.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    final List<Map<String, dynamic>> maps = await db.query(
      'HEIRS',
      where: 'heirName = ? AND heirDateOfBirth = ?',
      whereArgs: [heir.heirName, heir.heirDateOfBirth],
      limit: 1,
    );
    return maps[0]['heirKey'];
  }

  Future<List<Member>> getMembers() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
        SELECT *, cast ( (julianday(CURRENT_DATE) - julianday(dateOfBirth)) / 365.25 as int ) AS age
        FROM MEMBERS;
      ''',
    );
    return List.generate(maps.length, (index) => Member.fromMap(maps[index]));
  }

  Future<List<Member>> searchMembers(String keyword) async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("""
        SELECT *, cast ( (julianday(CURRENT_DATE) - julianday(dateOfBirth)) / 365.25 as int ) AS age
        FROM MEMBERS WHERE LOWER(memberName) LIKE ?
          OR mid IN (?);
      """, ['%${keyword.toLowerCase()}%', keyword]);
    return List.generate(maps.length, (index) => Member.fromMap(maps[index]));
  }

  Future<List<Employer>> getEmployers() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('EMPLOYERS');
    return List.generate(maps.length, (index) => Employer.fromMap(maps[index]));
  }

  Future<List<Employer>> searchEmployers(String keyword) async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'EMPLOYERS',
      where:
          'LOWER(employerName) LIKE ? OR LOWER(employerAddress) LIKE ? OR employerKey LIKE ?',
      whereArgs: [
        '%${keyword.toLowerCase()}%',
        '%${keyword.toLowerCase()}%',
        '%$keyword%'
      ],
    );
    return List.generate(maps.length, (index) => Employer.fromMap(maps[index]));
  }

  Future<List<Employment>> getEmployment(Member member) async {
    final db = await _databaseHandler.database;
    final mid = member.mid;
    final List<Map<String, dynamic>> maps = await db.query(
      'EMPLOYERS NATURAL JOIN EMPLOYMENT',
      where: 'mid = ?',
      whereArgs: [mid],
      orderBy: 'isCurrentEmployment DESC, dateEmployed DESC',
    );
    return List.generate(
        maps.length, (index) => Employment.fromMap(maps[index]));
  }

  Future<List<Map>> countEmployees(Employer employer) async {
    final db = await _databaseHandler.database;
    final employerKey = employer.employerKey;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
        SELECT isCurrentEmployment, COUNT(*)
        FROM EMPLOYMENT WHERE employerKey = ?
        GROUP BY isCurrentEmployment
        ORDER BY isCurrentEmployment DESC;
      ''',
      [employerKey],
    );
    return maps;
  }

  Future<void> deleteEmployments(Member member) async {
    final db = await _databaseHandler.database;
    await db.delete(
      'EMPLOYMENT',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
  }

  Future<void> insertEmployment(Employment employment) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'EMPLOYMENT',
      employment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Heir>> getHeirs() async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('HEIRS');
    return List.generate(maps.length, (index) => Heir.fromMap(maps[index]));
  }

  Future<List<Heir>> searchHeirs(String keyword) async {
    final db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'HEIRS',
      where:
          'LOWER(heirName) LIKE ? OR heirDateOfBirth LIKE ? OR heirKey LIKE ?',
      whereArgs: ['%${keyword.toLowerCase()}%', '%$keyword%', '%$keyword%'],
    );
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

  Future<void> deleteRelationships(Member member) async {
    final db = await _databaseHandler.database;
    await db.delete(
      'HEIR_RELATIONSHIPS',
      where: 'mid = ?',
      whereArgs: [member.mid],
    );
  }

  Future<void> insertRelationship(Relationship relationship) async {
    final db = await _databaseHandler.database;
    await db.insert(
      'HEIR_RELATIONSHIPS',
      relationship.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> demoTables() async {
    final db = await _databaseHandler.database;
    await db.execute('DELETE FROM EMPLOYMENT');
    await db.execute('DELETE FROM HEIR_RELATIONSHIPS');
    await db.execute('DELETE FROM EMPLOYERS');
    await db.execute('DELETE FROM HEIRS');
    await db.execute('DELETE FROM MEMBERS');
    await db.execute("DELETE FROM sqlite_sequence WHERE NAME = 'EMPLOYERS'");
    await db.execute("DELETE FROM sqlite_sequence WHERE NAME = 'HEIRS'");
    await db.execute("DELETE FROM sqlite_sequence WHERE NAME = 'MEMBERS'");
    Member memberA = Member(
      mid: 1,
      occupationalStatus: 'Employed',
      membershipType: 'Voluntary Employed',
      memberName: 'John Doe',
      motherName: 'Michelle Robinson Obama',
      fatherName: 'Barrack Hussein Obama',
      spouseName: 'Jane Doe',
      dateOfBirth: '2003-09-23',
      placeOfBirth: 'Rosario, Cavite',
      age: 0,
      sex: 'Male',
      height: '173',
      weight: '53',
      maritalStatus: 'Single',
      citizenship: 'Filipino',
      frequencyOfPayment: 'Quarterly',
      tin: '123123123123',
      sss: '6478911234',
      permanentAddress: 'General Trias City, Cavite',
      presentAddress: 'General Trias City, Cavite',
      preferredAddress: 'Present Address',
      cellphoneNumber: '09490007779',
      dateOfRegistration: '2024-03-12',
    );
    Member memberB = Member(
      mid: 2,
      occupationalStatus: 'Employed',
      membershipType: 'Mandatory Employed',
      memberName: 'Bart JoJo Simpson',
      motherName: 'Marge Jacqueline Simpson',
      fatherName: 'Homer Jay Simpson',
      spouseName: 'Jenda Yellow Simpson',
      dateOfBirth: '1979-04-01',
      placeOfBirth: 'Las Vegas, Nevada, USA',
      age: 0,
      sex: 'Male',
      height: '122',
      weight: '39',
      maritalStatus: 'Legally Separated',
      citizenship: 'American',
      frequencyOfPayment: 'Monthly',
      tin: '456456456456',
      sss: '4789086751',
      permanentAddress: 'Las Vegas, Nevada, USA',
      presentAddress: '742 Evergreen Terrace, Springfields, USA',
      preferredAddress: 'Permanent Address',
      cellphoneNumber: '14577890098',
      dateOfRegistration: '1995-07-18',
    );
    Member memberC = Member(
      mid: 3,
      occupationalStatus: 'Employed',
      membershipType: 'Voluntary OFW',
      memberName: 'Kimiko Sato',
      motherName: 'Nana Sato',
      fatherName: 'Kuro Sato',
      spouseName: '',
      dateOfBirth: '1997-07-07',
      placeOfBirth: 'Furano, Hokkaido, Japan',
      age: 0,
      sex: 'Male',
      height: '184',
      weight: '64',
      maritalStatus: 'Single',
      citizenship: 'Japanese',
      frequencyOfPayment: 'Monthly',
      tin: '108116231282',
      sss: '7392836108',
      permanentAddress: 'Furano, Hokkaido, Japan',
      presentAddress: 'El Dorado, Don Bosco, Paranaque City',
      preferredAddress: 'Present Address',
      cellphoneNumber: '08012345678',
      dateOfRegistration: '2019-05-15',
    );
    Member memberD = Member(
      mid: 4,
      occupationalStatus: 'Employed',
      membershipType: 'Mandatory OFW',
      memberName: 'Shen Quanrui',
      motherName: 'Shen Hao',
      fatherName: 'Shen Hanbin',
      spouseName: 'Shen Gyuvin',
      dateOfBirth: '1998-05-01',
      placeOfBirth: 'Shanghai, China',
      age: 0,
      sex: 'Male',
      height: '183',
      weight: '60',
      maritalStatus: 'Married',
      citizenship: 'Chinese',
      frequencyOfPayment: 'Quarterly',
      tin: '109876543293',
      sss: '7102023253',
      permanentAddress: 'Seoul, South Korea',
      presentAddress: 'Mapo-gu, Seoul, South Korea',
      preferredAddress: 'Present Address',
      cellphoneNumber: '87000000',
      dateOfRegistration: '2024-06-15',
    );
    Member memberE = Member(
      mid: 5,
      occupationalStatus: 'Employed',
      membershipType: 'Mandatory Self-Employed',
      memberName: 'Loi Reyes',
      motherName: 'Joy Ful Reyes',
      fatherName: 'Rich Mound Reyes',
      spouseName: '',
      dateOfBirth: '1993-11-14',
      placeOfBirth: 'Liloan, Cebu City',
      age: 0,
      sex: 'Female',
      height: '165',
      weight: '55',
      maritalStatus: 'Single',
      citizenship: 'Filipino',
      frequencyOfPayment: 'Monthly',
      tin: '462017402023',
      sss: '2836189250',
      permanentAddress: 'Liloan, Cebu City',
      presentAddress: 'Liloan, Cebu City',
      preferredAddress: 'Present Address',
      cellphoneNumber: '9456789921',
      dateOfRegistration: '2021-09-23',
    );

    Employer employerA = Employer(
      employerKey: 1,
      employerName: 'Google Philippines',
      employerAddress: 'Pedro Gil St., Manila',
    );
    Employer employerB = Employer(
      employerKey: 2,
      employerName: 'StaySafe Philippines',
      employerAddress: 'Taguig, Metro Manila',
    );
    Employer employerC = Employer(
      employerKey: 3,
      employerName: 'Nvidia',
      employerAddress: 'Santa Clara, California, USA',
    );
    Employer employerD = Employer(
      employerKey: 4,
      employerName: 'AMD',
      employerAddress: 'Santa Clara, California, USA',
    );
    Employer employerE = Employer(
      employerKey: 5,
      employerName: "City Treasurer's Office of Manila",
      employerAddress: 'Ermita, Manila, Metro Manila',
    );
    Employer employerF = Employer(
      employerKey: 6,
      employerName: 'Polytechnic University of the Philippines',
      employerAddress: 'Teresa St., Sta. Mesa, Manila, Metro Manila',
    );
    Employer employerG = Employer(
      employerKey: 7,
      employerName: 'Philippine General Hospital',
      employerAddress: 'Taft Avenue, Manila, Metro Manila',
    );
    Employer employerH = Employer(
      employerKey: 8,
      employerName: 'Paranaque Doctors Hospital',
      employerAddress: 'Betterliving Subdivision, Dona Soledad, Paranaque',
    );
    Employer employerI = Employer(
      employerKey: 9,
      employerName: 'Ospital ng Paranaque',
      employerAddress: 'Quirino Ave., Paranaque',
    );
    Employer employerJ = Employer(
      employerKey: 10,
      employerName: 'WakeOne Entertainment',
      employerAddress: '153 Tojeon-ro, Mapo-gu, Seoul, South Korea',
    );
    Employer employerK = Employer(
      employerKey: 11,
      employerName: 'Northeast Dental Clinic',
      employerAddress:
          'Panphil B Frasco New Liloan Public Market, Liloan, Cebu City',
    );
    Employer employerL = Employer(
      employerKey: 12,
      employerName: 'AZOTI Cafe',
      employerAddress: 'Purok Tugas, North Road, Liloan, 6002 Cebu',
    );

    Heir heirA = Heir(
      heirKey: 0,
      heirName: 'Baby Love Bird',
      heirDateOfBirth: '2023-02-26',
    );
    Heir heirB = Heir(
      heirKey: 1,
      heirName: 'Lisa Marie Simpson',
      heirDateOfBirth: '1980-12-17',
    );
    Heir heirC = Heir(
      heirKey: 2,
      heirName: 'Margaret Lenny Simpson',
      heirDateOfBirth: '1986-01-14',
    );
    Heir heirD = Heir(
      heirKey: 3,
      heirName: 'Yves Sato',
      heirDateOfBirth: '2000-08-18',
    );
    Heir heirE = Heir(
      heirKey: 4,
      heirName: 'Miks Sato',
      heirDateOfBirth: '2009-12-14',
    );
    Heir heirF = Heir(
      heirKey: 5,
      heirName: 'Shen Jiwoong',
      heirDateOfBirth: '1998-10-14',
    );
    Heir heirG = Heir(
      heirKey: 6,
      heirName: 'Sheen Reyes',
      heirDateOfBirth: '2015-05-19',
    );
    Heir heirH = Heir(
      heirKey: 7,
      heirName: 'Jo Lim',
      heirDateOfBirth: '1990-10-30',
    );

    Employment employmentA = Employment(
      employerKey: 1,
      employerName: '',
      employerAddress: '',
      mid: 1,
      isCurrentEmployment: 'Yes',
      occupation: 'Mobile App Developer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '45000',
      dateEmployed: '2024-01-04',
    );
    Employment employmentB = Employment(
      employerKey: 2,
      employerName: '',
      employerAddress: '',
      mid: 1,
      isCurrentEmployment: 'Yes',
      occupation: 'Mobile App Developer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '32000',
      dateEmployed: '2020-05-06',
    );
    Employment employmentC = Employment(
      employerKey: 3,
      employerName: '',
      employerAddress: '',
      mid: 1,
      isCurrentEmployment: 'No',
      occupation: 'Systems Design Engineer',
      employmentStatus: 'Project-Based',
      totalMonthlyIncome: '35000',
      dateEmployed: '2014-12-14',
    );
    Employment employmentD = Employment(
      employerKey: 4,
      employerName: '',
      employerAddress: '',
      mid: 1,
      isCurrentEmployment: 'No',
      occupation: 'Program Manager',
      employmentStatus: 'Part-Time',
      totalMonthlyIncome: '41000',
      dateEmployed: '2009-09-17',
    );
    Employment employmentE = Employment(
      employerKey: 5,
      employerName: '',
      employerAddress: '',
      mid: 2,
      isCurrentEmployment: 'Yes',
      occupation: 'City Treasurer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '35000',
      dateEmployed: '2021-10-29',
    );
    Employment employmentF = Employment(
      employerKey: 6,
      employerName: '',
      employerAddress: '',
      mid: 2,
      isCurrentEmployment: 'No',
      occupation: 'Accounting Officer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '28000',
      dateEmployed: '2016-12-15',
    );
    Employment employmentG = Employment(
      employerKey: 7,
      employerName: '',
      employerAddress: '',
      mid: 2,
      isCurrentEmployment: 'No',
      occupation: 'Accounting Officer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '22000',
      dateEmployed: '2005-01-19',
    );
    Employment employmentH = Employment(
      employerKey: 8,
      employerName: '',
      employerAddress: '',
      mid: 3,
      isCurrentEmployment: 'Yes',
      occupation: 'Anesthesiologist',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '50000',
      dateEmployed: '2017-02-18',
    );
    Employment employmentI = Employment(
      employerKey: 9,
      employerName: '',
      employerAddress: '',
      mid: 3,
      isCurrentEmployment: 'No',
      occupation: 'Anesthetic Physician',
      employmentStatus: 'Part-Time',
      totalMonthlyIncome: '30000',
      dateEmployed: '2021-04-21',
    );
    Employment employmentJ = Employment(
      employerKey: 10,
      employerName: '',
      employerAddress: '',
      mid: 4,
      isCurrentEmployment: 'Yes',
      occupation: 'Fashion Designer',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '50000',
      dateEmployed: '2023-07-10',
    );
    Employment employmentK = Employment(
      employerKey: 11,
      employerName: '',
      employerAddress: '',
      mid: 5,
      isCurrentEmployment: 'Yes',
      occupation: 'Dental Technician',
      employmentStatus: 'Regular',
      totalMonthlyIncome: '55000',
      dateEmployed: '2014-12-15',
    );
    Employment employmentL = Employment(
      employerKey: 12,
      employerName: '',
      employerAddress: '',
      mid: 5,
      isCurrentEmployment: 'Yes',
      occupation: 'Barista',
      employmentStatus: 'Part-Time',
      totalMonthlyIncome: '23000',
      dateEmployed: '2023-10-24',
    );

    Relationship relationshipA = Relationship(
      heirKey: 1,
      heirName: '',
      heirDateOfBirth: '',
      mid: 1,
      heirRelationship: 'Pet',
    );
    Relationship relationshipB = Relationship(
      heirKey: 2,
      heirName: '',
      heirDateOfBirth: '',
      mid: 2,
      heirRelationship: 'Sister',
    );
    Relationship relationshipC = Relationship(
      heirKey: 3,
      heirName: '',
      heirDateOfBirth: '',
      mid: 2,
      heirRelationship: 'Sister',
    );
    Relationship relationshipD = Relationship(
      heirKey: 1,
      heirName: '',
      heirDateOfBirth: '',
      mid: 2,
      heirRelationship: 'Neighbor',
    );
    Relationship relationshipE = Relationship(
      heirKey: 4,
      heirName: '',
      heirDateOfBirth: '',
      mid: 3,
      heirRelationship: 'Sister',
    );
    Relationship relationshipF = Relationship(
      heirKey: 5,
      heirName: '',
      heirDateOfBirth: '',
      mid: 3,
      heirRelationship: 'Sister',
    );
    Relationship relationshipG = Relationship(
      heirKey: 6,
      heirName: '',
      heirDateOfBirth: '',
      mid: 4,
      heirRelationship: 'Brother',
    );
    Relationship relationshipH = Relationship(
      heirKey: 7,
      heirName: '',
      heirDateOfBirth: '',
      mid: 5,
      heirRelationship: 'Sister',
    );
    Relationship relationshipI = Relationship(
      heirKey: 8,
      heirName: '',
      heirDateOfBirth: '',
      mid: 5,
      heirRelationship: 'Cousin',
    );

    insertMember(memberA);
    insertMember(memberB);
    insertMember(memberC);
    insertMember(memberD);
    insertMember(memberE);

    insertEmployer(employerA);
    insertEmployer(employerB);
    insertEmployer(employerC);
    insertEmployer(employerD);
    insertEmployer(employerE);
    insertEmployer(employerF);
    insertEmployer(employerG);
    insertEmployer(employerH);
    insertEmployer(employerI);
    insertEmployer(employerJ);
    insertEmployer(employerK);
    insertEmployer(employerL);

    insertHeir(heirA);
    insertHeir(heirB);
    insertHeir(heirC);
    insertHeir(heirD);
    insertHeir(heirE);
    insertHeir(heirF);
    insertHeir(heirG);
    insertHeir(heirH);

    insertEmployment(employmentA);
    insertEmployment(employmentB);
    insertEmployment(employmentC);
    insertEmployment(employmentD);
    insertEmployment(employmentE);
    insertEmployment(employmentF);
    insertEmployment(employmentG);
    insertEmployment(employmentH);
    insertEmployment(employmentI);
    insertEmployment(employmentJ);
    insertEmployment(employmentK);
    insertEmployment(employmentL);

    insertRelationship(relationshipA);
    insertRelationship(relationshipB);
    insertRelationship(relationshipC);
    insertRelationship(relationshipD);
    insertRelationship(relationshipE);
    insertRelationship(relationshipF);
    insertRelationship(relationshipG);
    insertRelationship(relationshipH);
    insertRelationship(relationshipI);
  }

  Future<void> rawQuery(String query) async {
    final db = await _databaseHandler.database;
    await db.rawQuery(query);
  }

  Future<List<Map>> simple1() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT mid, memberName, membershipType
        FROM MEMBERS
        WHERE maritalStatus = ?
      ''',
      ['Single'],
    );
  }

  Future<List<Map>> simple2() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT * 
        FROM EMPLOYERS
        WHERE employerAddress LIKE ?
      ''',
      ['%Manila%'],
    );
  }

  Future<List<Map>> simple3() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT * 
        FROM HEIRS
        WHERE heirName LIKE ?
      ''',
      ['%Sato%'],
    );
  }

  Future<List<Map>> medium1() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT employmentStatus, SUM(totalMonthlyIncome) AS totalIncome
        FROM EMPLOYMENT
        GROUP BY employmentStatus
        HAVING totalIncome > 35000;
      ''',
    );
  }

  Future<List<Map>> medium2() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT membershipType, COUNT(*) AS memberCount
        FROM MEMBERS
        WHERE presentAddress NOT LIKE ? 
        GROUP BY membershipType;
      ''',
      ['%Cavite%'],
    );
  }

  Future<List<Map>> medium3() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT occupation, COUNT(*) AS countHiredInDecember
        FROM EMPLOYMENT
        WHERE dateEmployed LIKE ?
        GROUP BY occupation
        ORDER BY occupation;
      ''',
      ['%-12-%'],
    );
  }

  Future<List<Map>> medium4() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
          SELECT strftime(?, heirDateOfBirth) AS birthMonth, COUNT(*) AS numOfHeirs
          FROM HEIRS
          GROUP BY birthMonth
          HAVING numOfHeirs > 1
          ORDER BY birthMonth;
        ''',
      ['%m'],
    );
  }

  Future<List<Map>> difficult1() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT M.mid, SUM(totalMonthlyIncome) AS totalMonthlyIncome
        FROM MEMBERS AS M, EMPLOYMENT AS E
        WHERE M.mid = E.mid AND E.employmentStatus = ?
          AND E.occupation = ?;
      ''',
      ['Regular', 'Mobile App Developer'],
    );
  }

  Future<List<Map>> difficult2() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT M.memberName, ER.employerName, ENT.totalMonthlyIncome
        FROM MEMBERS AS M, EMPLOYERS AS ER, EMPLOYMENT AS ENT
        WHERE M.mid = ENT.mid AND ENT.employerKey = ER.employerKey
          AND ENT.employmentStatus = ?
          AND ENT.occupation IN (?, ?)
        ORDER BY ENT.totalMonthlyIncome DESC;
      ''',
      ['Regular', 'Accounting Officer', 'Fashion Designer'],
    );
  }

  Future<List<Map>> difficult3() async {
    final db = await _databaseHandler.database;
    return await db.rawQuery(
      '''
        SELECT M.mid, M.memberName, M.citizenship, ENT.dateEmployed
        FROM MEMBERS AS M, EMPLOYMENT AS ENT
        WHERE M.mid = ENT.mid
          AND 
            (
              M.citizenship = ? AND substr(ENT.dateEmployed, 1, 4) < ?
              OR M.citizenship != ? AND substr(ENT.dateEmployed, 1, 4) >= ?
            )
        ORDER BY M.citizenship;
      ''',
      ['Filipino', '2020', 'Filipino', '2020'],
    );
  }
}
