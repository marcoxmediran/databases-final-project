import 'package:databases_final_project/database/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Simple1 extends StatefulWidget {
  const Simple1({super.key});

  @override
  State<StatefulWidget> createState() => _Simple1State();
}

class _Simple1State extends State<Simple1> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final results = <DataRow>[];

  Future<List<Map>> query() async {
    return await _databaseHandler.simple1();
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
            DataCell(Text(element['membershipType'].toString())),
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
          const SliverAppBar(title: Text('Simple Problem 1'), pinned: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: padding, right: padding),
                  child: const Text(
                      'Display the mid, name, and membership type of all members that are single.'),
                ),
                const SizedBox(height: 32),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('mid')),
                    DataColumn(label: Text('memberName')),
                    DataColumn(label: Text('membershipType')),
                  ],
                  rows: results,
                ),
                const SizedBox(height: 32),
                Text(
                  '''
-- SQL Query
SELECT mid, memberName, membershipType
FROM MEMBERS
WHERE maritalStatus = ?
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
