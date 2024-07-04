import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/ui/employment_builder.dart';
import 'package:databases_final_project/ui/form.dart';
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
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final double textHeight = 2;

  @override
  Widget build(BuildContext context) {
    Member member = widget.member;
    double widgetSpacing = MediaQuery.sizeOf(context).width / 32;
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
              child: Center(
                  child: Text(member.formatMid(),
                      style: const TextStyle(fontSize: 16)))),
          SliverToBoxAdapter(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  IconButton(
                    tooltip: 'Delete Member',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                              'Are you sure you want to delete this member?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _databaseHandler.deleteMember(member);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Edit Member',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormPage(
                                    member: member,
                                  )));
                    },
                    icon: const Icon(Icons.edit_outlined),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Flex(
                    direction: isWidescreen ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                        child: SizedBox(
                          height: 450,
                          width: 360,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Membership Information',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                //Text(
                                //    'MID: ${member.formatMid()}\nTIN: ${member.tin}\nSSS: ${member.sss}\nOccupational Status: ${member.occupationalStatus}\nMembership Category: ${member.membershipType}\nFrequency of Payment: ${member.frequencyOfPayment}\nDate of Registration: ${member.dateOfRegistration}\nAddress: ${member.getPrefferedAddress()}',
                                //    style: const TextStyle(height: 2)),
                                Text('MID: ${member.formatMid()}',
                                    style: TextStyle(height: textHeight)),
                                Text('TIN: ${member.tin}',
                                    style: TextStyle(height: textHeight)),
                                Text('SSS: ${member.sss}',
                                    style: TextStyle(height: textHeight)),
                                Text(
                                    'Occupational Status: ${member.occupationalStatus}',
                                    style: TextStyle(height: textHeight)),
                                Text(
                                    'Membership Category: ${member.membershipType}',
                                    style: TextStyle(height: textHeight)),
                                Text(
                                    'Frequency of Payment: ${member.frequencyOfPayment}',
                                    style: TextStyle(height: textHeight)),
                                Text(
                                    'Date of Registration: ${member.dateOfRegistration}',
                                    style: TextStyle(height: textHeight)),
                                Text(
                                    'Preffered Address: ${member.getPrefferedAddress()}',
                                    style: TextStyle(height: textHeight)),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32, width: 32),
                      Container(
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
                        height: 450,
                        width: 360,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Personal Information',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Name: ${member.memberName}',
                                  style: TextStyle(height: textHeight)),
                              Text(
                                  'Cellphone Number: ${member.cellphoneNumber}',
                                  style: TextStyle(height: textHeight)),
                              Text('Sex: ${member.sex}',
                                  style: TextStyle(height: textHeight)),
                              Text('Citizenship: ${member.citizenship}',
                                  style: TextStyle(height: textHeight)),
                              Text('Height: ${member.height}cm',
                                  style: TextStyle(height: textHeight)),
                              Text('Weight: ${member.weight}kg',
                                  style: TextStyle(height: textHeight)),
                              Text(
                                  'Birthdate: ${member.dateOfBirth} (${member.age} years old)',
                                  style: TextStyle(height: textHeight)),
                              Text('Place of Birth: ${member.placeOfBirth}',
                                  style: TextStyle(height: textHeight)),
                              Text('Marital Status: ${member.maritalStatus}',
                                  style: TextStyle(height: textHeight)),
                              Text('Mother: ${member.motherName}',
                                  style: TextStyle(height: textHeight)),
                              Text('Father: ${member.fatherName}',
                                  style: TextStyle(height: textHeight)),
                              Text('Spouse: ${member.getSpouse()}',
                                  style: TextStyle(height: textHeight)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Flex(
                    direction: isWidescreen ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: isWidescreen
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 450,
                        width: 360,
                        child: EmploymentBuilder(member: member),
                      ),
                      const SizedBox(height: 32, width: 32),
                      SizedBox(
                        height: 450,
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
