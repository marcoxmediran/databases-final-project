import 'package:flutter/material.dart';
import 'package:databases_final_project/database/database_handler.dart';

class Query extends StatefulWidget {
  const Query({super.key});

  @override
  State<StatefulWidget> createState() => _QueryState();
}

class _QueryState extends State<Query> {
  final TextEditingController _queryController = TextEditingController();
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          SizedBox(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'SQLite command',
              ),
              controller: _queryController,
              onSubmitted: (String text) async {
                await _databaseHandler.rawQuery(text);
                _queryController.clear();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              var members = await _databaseHandler.getMembers();
              var employers = await _databaseHandler.getEmployers();
              var heirs = await _databaseHandler.getHeirs();
              print('MEMBERS');
              members.forEach((element) => print(element));
              print('EMPLOYERS');
              employers.forEach((element) => print(element));
              print('HEIRS');
              heirs.forEach((element) => print(element));
            },
            icon: const Icon(Icons.print_outlined),
            label: const Text('Print'),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            onPressed: () async {
              await _databaseHandler.rawQuery(_queryController.text);
              _queryController.clear();
            },
            icon: const Icon(Icons.terminal_outlined),
            label: const Text('Execute'),
          ),
        ],
      ),
    );
  }
}
