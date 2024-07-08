import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Difficult2 extends StatefulWidget {
  const Difficult2({super.key});

  @override
  State<StatefulWidget> createState() => _Difficult2State();
}

class _Difficult2State extends State<Difficult2> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.difficult2();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['memberName'].toString())),
            DataCell(Text(element['employerName'].toString())),
            DataCell(Text(element['totalMonthlyIncome'].toString())),
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
          const SliverAppBar(title: Text('Difficult Problem 2'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Display the names of the members who are regular at work and either an accounting officer or a fashion designer. Show also the name of their employer and their total monthly income per employer. Sort from highest total monthly income.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('memberName')),
                    DataColumn(label: Text('employerName')),
                    DataColumn(label: Text('totalMonthlyIncome')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT M.memberName, ER.employerName, ENT.totalMonthlyIncome
FROM MEMBERS AS M, EMPLOYERS AS ER, EMPLOYMENT AS ENT
WHERE M.mid = ENT.mid AND ENT.employerKey = ER.employerKey
  AND ENT.employmentStatus = 'Regular'
  AND ENT.occupation IN ('Accounting Officer', 'Fashion Designer')
ORDER BY ENT.totalMonthlyIncome DESC;
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
