import 'package:databases_final_project/models/member.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(member.memberName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: CustomScrollView(),
    );
  }
}
