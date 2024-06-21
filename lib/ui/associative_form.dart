import 'dart:async';
import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/models/relationship.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssociativeFormPage extends StatefulWidget {
  final Member member;
  const AssociativeFormPage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => _AssociativeFormPageState();
}

class _AssociativeFormPageState extends State<AssociativeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  Future<List<Employment>> _getEmployment(Member member) async {
    return await _databaseHandler.getEmployment(member);
  }

  Future<List<Relationship>> _getRelationships(Member member) async {
    return await _databaseHandler.getRelationships(member);
  }

  @override
  initState() {
    super.initState();
    Member member = widget.member;
    _getEmployment(member).then((result) {
      result.forEach((element) => setState(() {
            employmentCards.add(EmploymentCard(element));
          }));
    });
    _getRelationships(member).then((result) {
      result.forEach((element) => setState(() {
            heirCards.add(HeirCard(element));
          }));
    });
  }

  var employerNames = <TextEditingController>[];
  var employerAddresses = <TextEditingController>[];
  var isCurrentEmployment = <TextEditingController>[];
  var occupations = <TextEditingController>[];
  var employmentStatus = <TextEditingController>[];
  var incomes = <TextEditingController>[];
  var employmentDates = <TextEditingController>[];
  var employmentCards = <Card>[];

  Card EmploymentCard(Employment? employment) {
    TextEditingController employerNameController = TextEditingController();
    TextEditingController employerAddressController = TextEditingController();
    TextEditingController isCurrentController = TextEditingController();
    TextEditingController occupationController = TextEditingController();
    TextEditingController employmentStatusController = TextEditingController();
    TextEditingController incomeController = TextEditingController();
    TextEditingController employmentDateController = TextEditingController();
    employerNames.add(employerNameController);
    employerAddresses.add(employerAddressController);
    isCurrentEmployment.add(isCurrentController);
    occupations.add(occupationController);
    incomes.add(incomeController);
    employmentDates.add(employmentDateController);

    if (employment != null) {
      employerNameController.text = employment.employerName;
      employerAddressController.text = employment.employerAddress;
      isCurrentController.text = employment.isCurrentEmployment;
      occupationController.text = employment.occupation;
      employmentStatusController.text = employment.employmentStatus;
      incomeController.text = employment.totalMonthlyIncome;
      employmentDateController.text = employment.dateEmployed;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employment ${employmentCards.length + 1}'),
            _customSpacer(),
            TextFormField(
              controller: employerNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employer Name',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: employerAddressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employer Address',
              ),
            ),
            _customSpacer(),
            DropdownMenu(
              controller: isCurrentController,
              label: const Text('Currently Employed?'),
              width: 256,
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: '1', label: 'Yes'),
                DropdownMenuEntry(value: '0', label: 'No'),
              ],
            ),
            _customSpacer(),
            TextFormField(
              controller: occupationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Occupation',
              ),
            ),
            _customSpacer(),
            DropdownMenu(
              controller: employmentStatusController,
              label: const Text('Employment Status'),
              width: 256,
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Permanent', label: 'Permanent'),
                DropdownMenuEntry(value: 'Casual', label: 'Casual'),
                DropdownMenuEntry(value: 'Contractual', label: 'Contractual'),
                DropdownMenuEntry(
                    value: 'Project-Based', label: 'Project-Based'),
                DropdownMenuEntry(value: 'Part-Time', label: 'Part-Time'),
              ],
            ),
            _customSpacer(),
            TextFormField(
              controller: incomeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Total Monthly Income (Php)',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _customSpacer(),
            TextFormField(
              controller: employmentDateController,
              readOnly: true,
              onTap: () async {
                DateTime? birthdate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                employmentDateController.text =
                    birthdate.toString().split(' ')[0];
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Birthdate',
              ),
            ),
          ],
        ),
      ),
    );
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: heirBirthdateController,
              readOnly: true,
              onTap: () async {
                DateTime? birthdate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                heirBirthdateController.text =
                    birthdate.toString().split(' ')[0];
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Birthdate',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: heirRelationshipController,
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
              title: Text('Employment and Heirs'),
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
                    child: Text('Employment', style: TextStyle(fontSize: 26)),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => employmentCards.isEmpty
                        ? null
                        : setState(() => employmentCards.removeLast()),
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () => setState(
                        () => employmentCards.add(EmploymentCard(null))),
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            //sliver: SliverList(delegate: SliverChildListDelegate(heirCards)),
            sliver: SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return employmentCards[index];
              },
              itemCount: employmentCards.length,
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
                        : setState(() => heirCards.removeLast()),
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () =>
                        setState(() => heirCards.add(HeirCard(null))),
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            //sliver: SliverList(delegate: SliverChildListDelegate(heirCards)),
            sliver: SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return heirCards[index];
              },
              itemCount: heirCards.length,
            ),
          ),
          _customSliverSpacer(64),
          SliverPadding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            sliver: SliverToBoxAdapter(
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
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
}

Widget _customSpacer() {
  return const SizedBox(height: 12);
}

Widget _customSliverSpacer(double height) {
  return SliverToBoxAdapter(child: SizedBox(height: height));
}
