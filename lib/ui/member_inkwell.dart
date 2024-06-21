import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/ui/member_profile_page.dart';
import 'package:flutter/material.dart';

class MemberInkwell extends StatefulWidget {
  final Member member;
  const MemberInkwell({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => _MemberInkwellState();
}

class _MemberInkwellState extends State<MemberInkwell> {
  @override
  Widget build(BuildContext context) {
    Member member = widget.member;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MemberProfilePage(member: member)));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: member.generateIcon(),
        ),
        title: Text(member.memberName),
        subtitle: Text(member.formatMid()),
      ),
    );
  }
}
