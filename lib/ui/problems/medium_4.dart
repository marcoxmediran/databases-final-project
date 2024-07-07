import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Medium4 extends StatefulWidget {
  const Medium4({super.key});

  @override
  State<StatefulWidget> createState() => _Medium4State();
}

class _Medium4State extends State<Medium4> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.medium4();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['birthMonth'].toString())),
            DataCell(Text(element['numOfHeirs'].toString())),
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
          const SliverAppBar(title: Text('Medium Problem 4'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Display the number of heirs born in each month and only show the months where more than one heir was born. Show the results in ascending order by month.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('birthMonth')),
                    DataColumn(label: Text('numOfHeirs')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT strftime(?, heirDateOfBirth) AS birthMonth, COUNT(*) AS numOfHeirs
FROM HEIRS
GROUP BY birthMonth
HAVING numOfHeirs > 1
ORDER BY birthMonth;
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
