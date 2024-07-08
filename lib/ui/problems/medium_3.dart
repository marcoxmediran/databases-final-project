import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Medium3 extends StatefulWidget {
  const Medium3({super.key});

  @override
  State<StatefulWidget> createState() => _Medium3State();
}

class _Medium3State extends State<Medium3> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.medium3();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['occupation'].toString())),
            DataCell(Text(element['countHiredInDecember'].toString())),
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
          const SliverAppBar(title: Text('Moderate Problem 3'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Count how many were hired in the month of December. Sort by occupation.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('occupation')),
                    DataColumn(label: Text('countHiredInDecember')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT occupation, COUNT(*) AS countHiredInDecember
FROM EMPLOYMENT
WHERE dateEmployed LIKE '%-12-%'
GROUP BY occupation
ORDER BY occupation;
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
