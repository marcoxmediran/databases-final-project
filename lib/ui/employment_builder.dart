import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/ui/employment_form.dart';
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
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text('Employment', style: TextStyle(fontSize: 20)),
            ),
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
                          child: Text(
                        'Member has no\nemployment details.',
                        textAlign: TextAlign.center,
                      ));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (contex, index) {
                        Employment employment = snapshot.data![index];
                        return Tooltip(
                          message: 'Tap for more info',
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Dismiss'))
                                        ],
                                        content: SizedBox(
                                          width: 400,
                                          height: 220,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(employment.employerName,
                                                  style: const TextStyle(
                                                      fontSize: 28)),
                                              Text(employment.employerAddress,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87)),
                                              const SizedBox(height: 32),
                                              Column(
                                                children: [
                                                  Text(employment.getSummary()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ));
                            },
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.apartment),
                              ),
                              title: Text(employment.employerName),
                              subtitle: Text(employment.occupation),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EmploymentFormPage(member: widget.member)));
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
