import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/ui/form.dart';
import 'package:databases_final_project/ui/member_inkwell.dart';
import 'package:flutter/material.dart';

class MemberBuilder extends StatefulWidget {
  const MemberBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _MemberState();
}

class _MemberState extends State<MemberBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  late Future<List<Member>> _members;

  Future<List<Member>> _getMembers() async {
    return await _databaseHandler.getMembers();
  }

  @override
  void initState() {
    super.initState();
    _members = _getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: FutureBuilder<List<Member>>(
          future: _members,
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
                return MemberInkwell(member: member);
              },
            );
          }),
    );
  }
}
