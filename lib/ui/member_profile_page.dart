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
                    right: widgetSpacing,
                    left: widgetSpacing,
                  ),
                  child: Container(
                    height: 512,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          )
                        ]),
                    child: const SizedBox.expand(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                SizedBox(height: widgetSpacing / 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: widgetSpacing),
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
                    SizedBox(width: widgetSpacing),
                  ],
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
