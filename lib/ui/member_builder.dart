import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:flutter/material.dart';

class MemberBuilder extends StatefulWidget {
  const MemberBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _MemberState();
}

class _MemberState extends State<MemberBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Member>> _getMembers() async {
    return await _databaseHandler.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Member>>(
          future: _getMembers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (contex, index) {
                Member member = snapshot.data![index];
                return InkWell(
                  onTap: () => print(member.toString()),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.work_outline),
                    ),
                    title: Text('${member.mid}: ${member.memberName}'),
                    subtitle: Text(member.dateOfRegistration),
                  ),
                );
              },
            );
          }),
    );
  }
}
