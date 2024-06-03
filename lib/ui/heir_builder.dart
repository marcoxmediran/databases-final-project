import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:flutter/material.dart';

class HeirBuilder extends StatefulWidget {
  const HeirBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _HeirState();
}

class _HeirState extends State<HeirBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Heir>> _getHeirs() async {
    return await _databaseHandler.getHeirs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Heir>>(
          future: _getHeirs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (contex, index) {
                Heir heir = snapshot.data![index];
                return InkWell(
                  onTap: () => print(heir.toString()),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.work_outline),
                    ),
                    title: Text('${heir.heirKey}: ${heir.heirName}'),
                    subtitle: Text(heir.heirDateOfBirth),
                  ),
                );
              },
            );
          }),
    );
  }
}
