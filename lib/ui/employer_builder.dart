import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:flutter/material.dart';

class EmployerBuilder extends StatefulWidget {
  const EmployerBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _EmployerBuilderState();
}

class _EmployerBuilderState extends State<EmployerBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Employer>> _getEmployers() async {
    return await _databaseHandler.getEmployers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Employer>>(
          future: _getEmployers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (contex, index) {
                Employer employer = snapshot.data![index];
                return InkWell(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.apartment),
                    ),
                    title: Text(
                        '${employer.employerName} - ${employer.employerAddress}'),
                    subtitle: Text(employer.formatKey()),
                  ),
                );
              },
            );
          }),
    );
  }
}
