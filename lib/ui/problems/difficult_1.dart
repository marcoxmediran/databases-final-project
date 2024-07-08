import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Difficult1 extends StatefulWidget {
  const Difficult1({super.key});

  @override
  State<StatefulWidget> createState() => _Difficult1State();
}

class _Difficult1State extends State<Difficult1> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.difficult1();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['mid'].toString())),
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
          const SliverAppBar(title: Text('Difficult Problem 1'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Sum up the total monthly income of member/s who have a regular status and an occupation of Mobile App Developer. Display the pagibig mid number.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('mid')),
                    DataColumn(label: Text('totalMonthlyIncome')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT M.mid, SUM(totalMonthlyIncome) AS totalMonthlyIncome
FROM MEMBERS AS M, EMPLOYMENT AS E
WHERE M.mid = E.mid
  AND E.employmentStatus = 'Regular'
  AND E.occupation = 'Mobile App Developer'
GROUP BY M.mid;
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
