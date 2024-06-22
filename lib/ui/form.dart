import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPage extends StatefulWidget {
  final Member? member;
  const FormPage({super.key, this.member});

  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final TextEditingController _occupationalStatusController =
      TextEditingController();
  final TextEditingController _frequencyOfPaymentController =
      TextEditingController();
  final TextEditingController _membershipCategoryController =
      TextEditingController();
  final TextEditingController _memberNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _citizenshipController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _tinController = TextEditingController();
  final TextEditingController _sssController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _presentAddressController =
      TextEditingController();
  final TextEditingController _preferredAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Member? member = widget.member;
    var spacing = max(MediaQuery.sizeOf(context).width / 6, 16).toDouble();

    if (member != null) {
      _occupationalStatusController.text = member.occupationalStatus;
      _frequencyOfPaymentController.text = member.frequencyOfPayment;
      _membershipCategoryController.text = member.membershipType;
      _memberNameController.text = member.memberName;
      _motherNameController.text = member.motherName;
      _fatherNameController.text = member.fatherName;
      _spouseNameController.text = member.spouseName;
      _sexController.text = member.sex;
      _maritalStatusController.text = member.maritalStatus;
      _citizenshipController.text = member.citizenship;
      _heightController.text = member.height;
      _weightController.text = member.weight;
      _birthdateController.text = member.dateOfBirth;
      _tinController.text = member.tin;
      _sssController.text = member.sss;
      _contactNumberController.text = member.cellphoneNumber;
      _placeOfBirthController.text = member.placeOfBirth;
      _permanentAddressController.text = member.permanentAddress;
      _presentAddressController.text = member.presentAddress;
      _preferredAddressController.text = member.preferredAddress;
    }

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
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
                member == null ? 'Add Record' : 'Edit ${member.memberName}'),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: spacing, right: spacing),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spacing / 2),
                  const Text('Membership Category',
                      style: TextStyle(fontSize: 26)),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value: member != null
                        ? _occupationalStatusController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                          value: 'Employed', child: Text('Employed')),
                      DropdownMenuItem(
                          value: 'Unemployed', child: Text('Unemployed')),
                    ],
                    onChanged: (value) =>
                        _occupationalStatusController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Occupational Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value: member != null
                        ? _frequencyOfPaymentController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                          value: 'Monthly', child: Text('Monthly')),
                      DropdownMenuItem(
                          value: 'Quarterly', child: Text('Quarterly')),
                    ],
                    onChanged: (value) =>
                        _frequencyOfPaymentController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Frequency of Payment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value: member != null
                        ? _membershipCategoryController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                          value: 'Mandatory Employed',
                          child: Text('Mandatory Employed')),
                      DropdownMenuItem(
                          value: 'Mandatory OFW', child: Text('Mandatory OFW')),
                      DropdownMenuItem(
                          value: 'Mandatory Self-Employed',
                          child: Text('Mandatory Self-Employed')),
                      DropdownMenuItem(
                          value: 'Voluntary Employed',
                          child: Text('Voluntary Employed')),
                      DropdownMenuItem(
                          value: 'Voluntary OFW', child: Text('Voluntary OFW')),
                      DropdownMenuItem(
                          value: 'Voluntary Self-Employed',
                          child: Text('Voluntary Self-Employed')),
                    ],
                    onChanged: (value) =>
                        _membershipCategoryController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Membership Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  _customDivider(),
                  const Text('Personal Details',
                      style: TextStyle(fontSize: 26)),
                  _customSpacer(),
                  TextFormField(
                    controller: _memberNameController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Member\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _motherNameController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mother\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _fatherNameController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Father\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _spouseNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Spouse\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value: member != null ? _sexController.text : null,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                    ],
                    onChanged: (value) => _sexController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value:
                        member != null ? _maritalStatusController.text : null,
                    items: const [
                      DropdownMenuItem(value: 'Single', child: Text('Single')),
                      DropdownMenuItem(
                          value: 'Married', child: Text('Married')),
                      DropdownMenuItem(
                          value: 'Annulled', child: Text('Annulled')),
                      DropdownMenuItem(
                          value: 'Legally Separated',
                          child: Text('Legally Separated')),
                    ],
                    onChanged: (value) =>
                        _maritalStatusController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Marital Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _citizenshipController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Citizenship',
                    ),
                  ),
                  _customSpacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'This field is required'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height (cm)',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'This field is required'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Weight (kg)',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _birthdateController,
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
                            if (birthdate != null) {
                              _birthdateController.text =
                                  birthdate.toString().split(' ')[0];
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Birthdate',
                          ),
                        ),
                      ),
                    ],
                  ),
                  _customSpacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _tinController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'This field is required'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'TIN Number',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _sssController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'This field is required'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'SSS Number',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  _customSpacer(),
                  _customDivider(),
                  const Text('Address and Contact Details',
                      style: TextStyle(fontSize: 26)),
                  _customSpacer(),
                  TextFormField(
                    controller: _contactNumberController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _placeOfBirthController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Place of Birth',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _permanentAddressController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Permanent Address',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    controller: _presentAddressController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Present Address',
                    ),
                  ),
                  _customSpacer(),
                  DropdownButtonFormField(
                    value: member != null
                        ? _preferredAddressController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                          value: 'Permanent Address',
                          child: Text('Permanent Address')),
                      DropdownMenuItem(
                          value: 'Present Address',
                          child: Text('Present Address')),
                    ],
                    onChanged: (value) =>
                        _preferredAddressController.text = value!,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Preferred Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  const SizedBox(height: 64),
                  Center(
                      child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Member toInsert = Member(
                          mid: member == null ? 0 : member.mid,
                          occupationalStatus:
                              _occupationalStatusController.text,
                          membershipType: _membershipCategoryController.text,
                          memberName: _memberNameController.text,
                          motherName: _motherNameController.text,
                          fatherName: _fatherNameController.text,
                          spouseName: _spouseNameController.text,
                          dateOfBirth: _birthdateController.text,
                          placeOfBirth: _placeOfBirthController.text,
                          sex: _sexController.text,
                          height: _heightController.text,
                          weight: _weightController.text,
                          maritalStatus: _maritalStatusController.text,
                          citizenship: _citizenshipController.text,
                          frequencyOfPayment:
                              _frequencyOfPaymentController.text,
                          tin: _tinController.text,
                          sss: _sssController.text,
                          permanentAddress: _permanentAddressController.text,
                          presentAddress: _presentAddressController.text,
                          preferredAddress: _preferredAddressController.text,
                          cellphoneNumber: _contactNumberController.text,
                          dateOfRegistration: member == null
                              ? DateTime.now().toString().split(' ')[0]
                              : member.dateOfRegistration,
                        );

                        if (member == null) {
                          await _databaseHandler.insertMember(toInsert);
                        } else {
                          await _databaseHandler.updateMember(toInsert);
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  )),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}

Widget _customSpacer() {
  return const SizedBox(height: 12);
}

Widget _customDivider() {
  return const Column(
    children: [
      SizedBox(height: 16),
      Divider(),
      SizedBox(height: 16),
    ],
  );
}
