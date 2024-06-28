import 'dart:math';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
  final SingleValueDropDownController _occupationalStatusController =
      SingleValueDropDownController();
  final SingleValueDropDownController _frequencyOfPaymentController =
      SingleValueDropDownController();
  final SingleValueDropDownController _membershipCategoryController =
      SingleValueDropDownController();
  final TextEditingController _memberNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final SingleValueDropDownController _sexController =
      SingleValueDropDownController();
  final SingleValueDropDownController _maritalStatusController =
      SingleValueDropDownController();
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
  final SingleValueDropDownController _preferredAddressController =
      SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    Member? member = widget.member;
    var spacing = max(MediaQuery.sizeOf(context).width / 6, 16).toDouble();

    if (member != null) {
      _occupationalStatusController.setDropDown(DropDownValueModel(
          name: member.occupationalStatus, value: member.occupationalStatus));
      _frequencyOfPaymentController.setDropDown(DropDownValueModel(
          name: member.frequencyOfPayment, value: member.frequencyOfPayment));
      _membershipCategoryController.setDropDown(DropDownValueModel(
          name: member.membershipType, value: member.membershipType));
      _memberNameController.text = member.memberName;
      _motherNameController.text = member.motherName;
      _fatherNameController.text = member.fatherName;
      _spouseNameController.text = member.spouseName;
      _sexController
          .setDropDown(DropDownValueModel(name: member.sex, value: member.sex));
      _maritalStatusController.setDropDown(DropDownValueModel(
          name: member.maritalStatus, value: member.maritalStatus));
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
      _preferredAddressController.setDropDown(DropDownValueModel(
          name: member.preferredAddress, value: member.preferredAddress));
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
                  DropDownTextField(
                    controller: _occupationalStatusController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Employed', value: 'Employed'),
                      DropDownValueModel(
                          name: 'Unemployed', value: 'Unemployed'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
                      labelText: 'Occupational Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropDownTextField(
                    controller: _frequencyOfPaymentController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Monthly', value: 'Monthly'),
                      DropDownValueModel(name: 'Quarterly', value: 'Quarterly'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
                      labelText: 'Frequency of Payment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropDownTextField(
                    controller: _membershipCategoryController,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Mandatory Employed',
                          value: 'Mandatory Employed'),
                      DropDownValueModel(
                          name: 'Mandatory OFW', value: 'Mandatory OFW'),
                      DropDownValueModel(
                          name: 'Mandatory Self-Employed',
                          value: 'Mandatory Self-Employed'),
                      DropDownValueModel(
                          name: 'Voluntary Employed',
                          value: 'Voluntary Employed'),
                      DropDownValueModel(
                          name: 'Voluntary Self-Employed',
                          value: 'Voluntary Self-Employed'),
                      DropDownValueModel(
                          name: 'Voluntary OFW', value: 'Voluntary OFW'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
                      labelText: 'Membership Type',
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
                  DropDownTextField(
                    controller: _sexController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Male', value: 'Male'),
                      DropDownValueModel(name: 'Female', value: 'Female'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _customSpacer(),
                  DropDownTextField(
                    controller: _maritalStatusController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Single', value: 'Single'),
                      DropDownValueModel(name: 'Married', value: 'Married'),
                      DropDownValueModel(name: 'Annulled', value: 'Annulled'),
                      DropDownValueModel(
                          name: 'Legally Separated',
                          value: 'Legally Separated'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
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
                  DropDownTextField(
                    controller: _preferredAddressController,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Permanent Address',
                          value: 'Permanent Address'),
                      DropDownValueModel(
                          name: 'Present Address', value: 'Present Address'),
                    ],
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field is required'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldDecoration: const InputDecoration(
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
                          occupationalStatus: _occupationalStatusController
                              .dropDownValue?.value,
                          membershipType: _membershipCategoryController
                              .dropDownValue?.value,
                          memberName: _memberNameController.text,
                          motherName: _motherNameController.text,
                          fatherName: _fatherNameController.text,
                          spouseName: _spouseNameController.text,
                          dateOfBirth: _birthdateController.text,
                          age: member == null ? 0 : member.age,
                          placeOfBirth: _placeOfBirthController.text,
                          sex: _sexController.dropDownValue?.value,
                          height: _heightController.text,
                          weight: _weightController.text,
                          maritalStatus:
                              _maritalStatusController.dropDownValue?.value,
                          citizenship: _citizenshipController.text,
                          frequencyOfPayment: _frequencyOfPaymentController
                              .dropDownValue?.value,
                          tin: _tinController.text,
                          sss: _sssController.text,
                          permanentAddress: _permanentAddressController.text,
                          presentAddress: _presentAddressController.text,
                          preferredAddress:
                              _preferredAddressController.dropDownValue?.value,
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
