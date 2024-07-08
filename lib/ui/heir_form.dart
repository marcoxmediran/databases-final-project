import 'dart:async';
import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/relationship.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:flutter/material.dart';

class HeirFormPage extends StatefulWidget {
  final Member member;
  const HeirFormPage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => _HeirFormPageState();
}

class _HeirFormPageState extends State<HeirFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<int> _insertHeir(Heir heir) async {
    return await _databaseHandler.insertHeir(heir);
  }

  Future<List<Relationship>> _getRelationships(Member member) async {
    return await _databaseHandler.getRelationships(member);
  }

  Future<void> _insertRelationship(Relationship relationship) async {
    await _databaseHandler.insertRelationship(relationship);
  }

  Future<void> _deleteRelationships(Member member) async {
    await _databaseHandler.deleteRelationships(member);
  }

  @override
  initState() {
    super.initState();
    Member member = widget.member;
    _getRelationships(member).then((result) {
      result.forEach((element) => setState(() {
            heirCards.add(HeirCard(element));
          }));
    });
  }

  var heirNames = <TextEditingController>[];
  var heirBirthdates = <TextEditingController>[];
  var heirRelationships = <TextEditingController>[];
  var heirCards = <Card>[];
  Card HeirCard(Relationship? relationship) {
    TextEditingController heirNameController = TextEditingController();
    TextEditingController heirBirthdateController = TextEditingController();
    TextEditingController heirRelationshipController = TextEditingController();
    heirNames.add(heirNameController);
    heirBirthdates.add(heirBirthdateController);
    heirRelationships.add(heirRelationshipController);

    if (relationship != null) {
      heirNameController.text = relationship.heirName;
      heirBirthdateController.text = relationship.heirDateOfBirth;
      heirRelationshipController.text = relationship.heirRelationship;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Heir ${heirCards.length + 1}'),
            _customSpacer(),
            TextFormField(
              controller: heirNameController,
              validator: (value) {
                if ((value == null || value.isEmpty)) {
                  return 'This field is required';
                } else if (value.length > 255) {
                  return 'Maximum length reached';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: heirBirthdateController,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              readOnly: true,
              onTap: () async {
                DateTime? birthdate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (birthdate != null) {
                  heirBirthdateController.text =
                      birthdate.toString().split(' ')[0];
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Birthdate',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: heirRelationshipController,
              validator: (value) {
                if ((value == null || value.isEmpty)) {
                  return 'This field is required';
                } else if (value.length > 255) {
                  return 'Maximum length reached';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Relationship',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Member member = widget.member;
    var spacing = max(MediaQuery.sizeOf(context).width / 6, 16).toDouble();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            floating: true,
            expandedHeight: 128,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Heirs'),
            ),
          ),
          _customSliverSpacer(64),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('Heirs', style: TextStyle(fontSize: 26)),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => heirCards.isEmpty
                        ? null
                        : setState(() {
                            heirCards.removeLast();
                          }),
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          heirCards.add(HeirCard(null));
                        });
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            sliver: Form(
              key: _formKey,
              child: SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return heirCards[heirCards.length - index - 1];
                },
                itemCount: heirCards.length,
              ),
            ),
          ),
          _customSliverSpacer(64),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            sliver: SliverToBoxAdapter(
              child: Center(
                  child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (validateForm()) {
                      var relationships = <Relationship>[];
                      for (int i = 0; i < heirCards.length; i++) {
                        Heir heir = Heir(
                          heirKey: -1,
                          heirName: heirNames[i].text,
                          heirDateOfBirth: heirBirthdates[i].text,
                        );
                        heir.heirKey = await _insertHeir(heir);
                        relationships.add(Relationship(
                          heirKey: heir.heirKey,
                          heirName: heirNames[i].text,
                          heirDateOfBirth: heirBirthdates[i].text,
                          mid: member.mid,
                          heirRelationship: heirRelationships[i].text,
                        ));
                      }
                      _deleteRelationships(member);
                      relationships
                          .forEach((element) => _insertRelationship(element));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Submit'),
              )),
            ),
          ),
          _customSliverSpacer(64),
        ],
      ),
    );
  }

  bool validateForm() {
    for (int i = 0; i < heirCards.length; i++) {
      if (heirNames[i].text.isEmpty ||
          heirBirthdates[i].text.isEmpty ||
          heirRelationships[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }
}

Widget _customSpacer() {
  return const SizedBox(height: 12);
}

Widget _customSliverSpacer(double height) {
  return SliverToBoxAdapter(child: SizedBox(height: height));
}
