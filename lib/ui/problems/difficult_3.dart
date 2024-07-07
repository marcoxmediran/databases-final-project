import 'package:databases_final_project/database/database_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Difficult3 extends StatefulWidget {
  const Difficult3({super.key});

  @override
  State<StatefulWidget> createState() => _Difficult3State();
}

class _Difficult3State extends State<Difficult3> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.difficult3();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['mid'].toString())),
            DataCell(Text(element['memberName'].toString())),
            DataCell(Text(element['citizenship'].toString())),
            DataCell(Text(element['dateEmployed'].toString())),
          ]));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.sizeOf(context).width / 6;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Difficult Problem 3'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Display all pagibig member id, name, citizenship, and date of employment of members whose citizenship is equal to ‘Filipino’, and year of employment is below 2020 and all the other citizenships with year of employment is 2020 and above. Sort by their citizenship.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('mid')),
                    DataColumn(label: Text('memberName')),
                    DataColumn(label: Text('citizenship')),
                    DataColumn(label: Text('dateEmployed')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
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
                  style: GoogleFonts.jetBrainsMono(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
