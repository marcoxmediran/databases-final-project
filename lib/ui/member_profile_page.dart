import 'dart:math';

import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/ui/employment_builder.dart';
import 'package:databases_final_project/ui/relationship_builder.dart';
import 'package:flutter/material.dart';

class MemberProfilePage extends StatefulWidget {
  final Member member;
  const MemberProfilePage({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  @override
  Widget build(BuildContext context) {
    Member member = widget.member;
    double widgetSpacing = max((MediaQuery.sizeOf(context).width / 6), 64);
    bool isWidescreen = MediaQuery.sizeOf(context).width >= 1000;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            floating: false,
            expandedHeight: 256,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: FilledButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Text('Edit'),
                    )),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(member.memberName),
              background: Column(
                children: [
                  const SizedBox(height: 64),
                  CircleAvatar(
                    radius: 64,
                    child: Icon(
                      (member.sex == 'Male') ? Icons.face : Icons.face_2,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: widgetSpacing / 8),
                Padding(
                  padding: EdgeInsets.only(
                      right: widgetSpacing, left: widgetSpacing),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, blurRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        direction:
                            isWidescreen ? Axis.horizontal : Axis.vertical,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Membership Information',
                                style: TextStyle(fontSize: 20)),
                              
                              Text('MID: ${member.formatMid()}'),
                              Text('TIN: ${member.tin}'),
                              Text('SSS: ${member.sss}'),
                              Text(
                                  'Occupational Status: ${member.occupationalStatus}'),
                              Text(
                                  'Frequency of Payment: ${member.frequencyOfPayment}'),
                              Text(
                                  'Date of Registration: ${member.dateOfRegistration}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Information',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Name: ${member.memberName}'),
                              Text(
                                  'Cellphone Number: ${member.cellphoneNumber}'),
                              Text('Sex: ${member.sex}'),
                              Text('Citizenship: ${member.citizenship}'),
                              Text('Height: ${member.height}cm'),
                              Text('Weight: ${member.weight}kg'),
                              Text(
                                  'Preffered Address: ${member.getPrefferedAddress()}'),
                              Text('Place of Birth: ${member.placeOfBirth}'),
                              Text(
                                  'Marital Status: ${member.getMaritalStatus()}'),
                              Text('Mother\'s Name: ${member.motherName}'),
                              Text('Father\'s Name: ${member.fatherName}'),
                              Text('Spouse\'s Name: ${member.getSpouse()}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: widgetSpacing / 8),
                Padding(
                  padding: EdgeInsets.only(
                      left: widgetSpacing, right: widgetSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 400,
                          child: EmploymentBuilder(member: member),
                        ),
                      ),
                      SizedBox(width: widgetSpacing / 8),
                      Expanded(
                        child: SizedBox(
                          height: 400,
                          child: RelationshipBuilder(member: member),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
