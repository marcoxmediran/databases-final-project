import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:flutter/material.dart';

class EmploymentBuilder extends StatefulWidget {
  final Member member;
  const EmploymentBuilder({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => _EmploymentBuilderState();
}

class _EmploymentBuilderState extends State<EmploymentBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Employment>> _getEmployment(Member member) async {
    return await _databaseHandler.getEmployment(member);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Text('Member Employment'),
            Expanded(
              child: FutureBuilder<List<Employment>>(
                  future: _getEmployment(widget.member),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (contex, index) {
                        Employment employment = snapshot.data![index];
                        return InkWell(
                          onTap: () => print(employment),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.apartment),
                            ),
                            title: Text(employment.employerName),
                            subtitle: Text(employment.occupation),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
