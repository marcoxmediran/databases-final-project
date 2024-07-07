import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Simple2 extends StatefulWidget {
  const Simple2({super.key});

  @override
  State<StatefulWidget> createState() => _Simple2State();
}

class _Simple2State extends State<Simple2> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.simple2();
  }

  @override
  void initState() {
    super.initState();
    query().then((result) {
      for (var element in result) {
        setState(() {
          results.add(DataRow(cells: [
            DataCell(Text(element['employerKey'].toString())),
            DataCell(Text(element['employerName'].toString())),
            DataCell(Text(element['employerAddress'].toString())),
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
          const SliverAppBar(title: Text('Simple Problem 2'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text('Display employers who are from Manila.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('employerKey')),
                    DataColumn(label: Text('employerName')),
                    DataColumn(label: Text('employerAddress')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT * 
FROM EMPLOYERS
WHERE employerAddress LIKE ?
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
