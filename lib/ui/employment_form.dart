import 'dart:async';
import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employment.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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

  Future<int> _insertEmployer(Employer employer) async {
    return await _databaseHandler.insertEmployer(employer);
  }

  Future<void> _insertEmployment(Employment employment) async {
    await _databaseHandler.insertEmployment(employment);
  }

  Future<void> _deleteEmployments(Member member) async {
    await _databaseHandler.deleteEmployments(member);
  }

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
  var isCurrentEmployment = <SingleValueDropDownController>[];
  var occupations = <TextEditingController>[];
  var employmentStatus = <SingleValueDropDownController>[];
  var incomes = <TextEditingController>[];
  var employmentDates = <TextEditingController>[];
  var employmentCards = <Card>[];

  Card EmploymentCard(Employment? employment) {
    final TextEditingController employerNameController =
        TextEditingController();
    final TextEditingController employerAddressController =
        TextEditingController();
    final SingleValueDropDownController isCurrentController =
        SingleValueDropDownController();
    final TextEditingController occupationController = TextEditingController();
    final SingleValueDropDownController statusController =
        SingleValueDropDownController();
    final TextEditingController incomeController = TextEditingController();
    final TextEditingController employmentDateController =
        TextEditingController();
    employerNames.add(employerNameController);
    employerAddresses.add(employerAddressController);
    isCurrentEmployment.add(isCurrentController);
    occupations.add(occupationController);
    employmentStatus.add(statusController);
    incomes.add(incomeController);
    employmentDates.add(employmentDateController);

    if (employment != null) {
      employerNameController.text = employment.employerName;
      employerAddressController.text = employment.employerAddress;
      isCurrentController.setDropDown(DropDownValueModel(
          name: employment.isCurrentEmployment,
          value: employment.isCurrentEmployment));
      occupationController.text = employment.occupation;
      statusController.setDropDown(DropDownValueModel(
          name: employment.employmentStatus,
          value: employment.employmentStatus));
      incomeController.text = employment.totalMonthlyIncome;
      employmentDateController.text = employment.dateEmployed;
    }

    @override
    void dispose() {
      employerNameController.dispose();
      employerAddressController.dispose();
      isCurrentController.dispose();
      occupationController.dispose();
      statusController.dispose();
      incomeController.dispose();
      employmentDateController.dispose();
      super.dispose();
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employer Address',
              ),
            ),
            _customSpacer(),
            DropDownTextField(
              controller: isCurrentController,
              dropDownList: const [
                DropDownValueModel(name: 'Yes', value: 'Yes'),
                DropDownValueModel(name: 'No', value: 'No'),
              ],
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              textFieldDecoration: const InputDecoration(
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Occupation',
              ),
            ),
            _customSpacer(),
            DropDownTextField(
              controller: statusController,
              dropDownList: const [
                DropDownValueModel(name: 'Regular', value: 'Regular'),
                DropDownValueModel(name: 'Casual', value: 'Casual'),
                DropDownValueModel(name: 'Contractual', value: 'Contractual'),
                DropDownValueModel(
                    name: 'Project-Based', value: 'Project-Based'),
                DropDownValueModel(name: 'Part-Time', value: 'Part-Time'),
              ],
              validator: (value) => (value == null || value.isEmpty)
                  ? 'This field is required'
                  : null,
              textFieldDecoration: const InputDecoration(
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
                    var employments = <Employment>[];
                    for (int i = 0; i < employmentCards.length; i++) {
                      Employer employer = Employer(
                        employerKey: 0,
                        employerName: employerNames[i].text,
                        employerAddress: employerAddresses[i].text,
                      );
                      employer.employerKey = await _insertEmployer(employer);
                      employments.add(Employment(
                        employerKey: employer.employerKey,
                        employerName: employerNames[i].text,
                        employerAddress: employerAddresses[i].text,
                        mid: member.mid,
                        isCurrentEmployment:
                            isCurrentEmployment[i].dropDownValue?.value,
                        occupation: occupations[i].text,
                        employmentStatus:
                            employmentStatus[i].dropDownValue?.value,
                        totalMonthlyIncome: incomes[i].text,
                        dateEmployed: employmentDates[i].text,
                      ));
                    }
                    _deleteEmployments(member);
                    employments
                        .forEach((element) => _insertEmployment(element));
                    Navigator.pop(context);
                    Navigator.pop(context);
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
