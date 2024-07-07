import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Medium1 extends StatefulWidget {
  const Medium1({super.key});

  @override
  State<StatefulWidget> createState() => _Medium1State();
}

class _Medium1State extends State<Medium1> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.medium1();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['employmentStatus'].toString())),
            DataCell(Text(element['totalIncome'].toString())),
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
          const SliverAppBar(title: Text('Moderate Problem 1'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Sum up the total monthly income of each employment status and show only the employment statuses which have a sum greater than P35,000.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('employmentStatus')),
                    DataColumn(label: Text('totalIncome')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT employmentStatus, SUM(totalMonthlyIncome) AS totalIncome
FROM EMPLOYMENT
GROUP BY employmentStatus
HAVING totalIncome > 35000;
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
