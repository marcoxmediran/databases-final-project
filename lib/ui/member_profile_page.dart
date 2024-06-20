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
    bool isWidescreen = MediaQuery.sizeOf(context).width >= 1130;

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
                    child: member.generateIconWithSize(80.toDouble()),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.only(left: widgetSpacing, right: widgetSpacing),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Flex(
                      direction: isWidescreen ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Membership Information',
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
                            Text(
                                'Preffered Address: ${member.getPrefferedAddress()}'),
                            const SizedBox(height: 16),
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
                            Text('Cellphone Number: ${member.cellphoneNumber}'),
                            Text('Sex: ${member.sex}'),
                            Text('Citizenship: ${member.citizenship}'),
                            Text('Height: ${member.height}cm'),
                            Text('Weight: ${member.weight}kg'),
                            Text('Birthdate: ${member.dateOfBirth}'),
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
                  const SizedBox(height: 32),
                  Flex(
                    direction: isWidescreen ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 400,
                        width: 360,
                        child: EmploymentBuilder(member: member),
                      ),
                      const SizedBox(height: 16, width: 16),
                      SizedBox(
                        height: 400,
                        width: 360,
                        child: RelationshipBuilder(member: member),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
