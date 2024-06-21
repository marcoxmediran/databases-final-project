import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/relationship.dart';
import 'package:flutter/material.dart';

class RelationshipBuilder extends StatefulWidget {
  final Member member;
  const RelationshipBuilder({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => _RelationshipBuilderState();
}

class _RelationshipBuilderState extends State<RelationshipBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Relationship>> _getRelationships(Member member) async {
    return await _databaseHandler.getRelationships(member);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //color: const Color(0xffeceef4),
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
              child: Text('Heirs', style: TextStyle(fontSize: 20)),
            ),
            Expanded(
              child: FutureBuilder<List<Relationship>>(
                  future: _getRelationships(widget.member),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Member has no\nheirs yet.',
                        textAlign: TextAlign.center,
                      ));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (contex, index) {
                        Relationship relationship = snapshot.data![index];
                        return InkWell(
                          onTap: () => print(relationship),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.apartment),
                            ),
                            title: Text(relationship.heirName),
                            subtitle: Text(relationship.heirRelationship),
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
