import 'dart:async';
import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmploymentFormPage extends StatefulWidget {
  final Member member;
  const EmploymentFormPage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => _EmploymentFormPageState();
}

class _EmploymentFormPageState extends State<EmploymentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  int previousEmployments = 0;

  Future<List<Employment>> _getEmployment(Member member) async {
    return await _databaseHandler.getEmployment(member);
  }

  @override
  initState() {
    super.initState();
    Member member = widget.member;
    _getEmployment(member).then((result) {
      for (var element in result.reversed) {
        setState(() {
          employmentCards.add(EmploymentCard(element));
          previousEmployments++;
        });
      }
    });
  }

  var employerNames = <TextEditingController>[];
  var employerAddresses = <TextEditingController>[];
  var isCurrentEmployment = <String>[];
  var occupations = <TextEditingController>[];
  var employmentStatus = <String>[];
  var incomes = <TextEditingController>[];
  var employmentDates = <TextEditingController>[];
  var employmentCards = <Card>[];

  Card EmploymentCard(Employment? employment) {
    TextEditingController employerNameController = TextEditingController();
    TextEditingController employerAddressController = TextEditingController();
    String isCurrent = '';
    TextEditingController occupationController = TextEditingController();
    String status = '';
    TextEditingController incomeController = TextEditingController();
    TextEditingController employmentDateController = TextEditingController();
    employerNames.add(employerNameController);
    employerAddresses.add(employerAddressController);
    isCurrentEmployment.add(isCurrent);
    occupations.add(occupationController);
    employmentStatus.add(status);
    incomes.add(incomeController);
    employmentDates.add(employmentDateController);

    if (employment != null) {
      employerNameController.text = employment.employerName;
      employerAddressController.text = employment.employerAddress;
      isCurrent = employment.isCurrentEmployment;
      occupationController.text = employment.occupation;
      status = employment.employmentStatus;
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
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employer Name',
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: employerAddressController,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employer Address',
              ),
            ),
            _customSpacer(),
            DropdownButtonFormField(
              //value: employment?.isCurrentEmployment,
              items: const [
                DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                DropdownMenuItem(value: 'No', child: Text('No')),
              ],
              onChanged: (value) => setState(() {
                isCurrent = value!;
              }),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Currently Employed?',
                border: OutlineInputBorder(),
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: occupationController,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Occupation',
              ),
            ),
            _customSpacer(),
            DropdownButtonFormField(
              //value: employment?.employmentStatus,
              items: const [
                DropdownMenuItem(value: 'Permanent', child: Text('Permanent')),
                DropdownMenuItem(value: 'Casual', child: Text('Casual')),
                DropdownMenuItem(
                    value: 'Contractual', child: Text('Contractual')),
                DropdownMenuItem(
                    value: 'Project-Based', child: Text('Project-Based')),
                DropdownMenuItem(value: 'Part-Time', child: Text('Part-Time')),
              ],
              onChanged: (value) => setState(() {
                status = value!;
              }),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Employment Status',
                border: OutlineInputBorder(),
              ),
            ),
            _customSpacer(),
            TextFormField(
              controller: incomeController,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Total Monthly Income (Php)',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _customSpacer(),
            TextFormField(
              controller: employmentDateController,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                labelText: 'Employment Date',
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
              title: Text('Employment'),
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
                    onPressed: () =>
                        employmentCards.length > previousEmployments
                            ? setState(() {
                                employmentCards.removeLast();
                              })
                            : null,
                    child: const Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(
                            () => employmentCards.add(EmploymentCard(null)));
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
                  return employmentCards[employmentCards.length - index - 1];
                },
                itemCount: employmentCards.length,
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
                    print('form complete');
                    for (int i = 0; i < employmentCards.length; i++) {
                      Employer newEmployer = Employer(
                        employerKey: 0,
                        employerName: employerNames[i].text,
                        employerAddress: employerAddresses[i].text,
                      );
                      print(newEmployer);
                    }
                  } else {
                    print('form not complete');
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
}

Widget _customSpacer() {
  return const SizedBox(height: 12);
}

Widget _customSliverSpacer(double height) {
  return SliverToBoxAdapter(child: SizedBox(height: height));
}
