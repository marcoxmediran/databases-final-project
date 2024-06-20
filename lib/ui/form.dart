import 'dart:math';
import 'package:databases_final_project/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            title: Text('Add Record'),
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
                  const DropdownMenu(
                    label: Text('Occupational Status'),
                    width: 256,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'Employed', label: 'Employed'),
                      DropdownMenuEntry(
                          value: 'Unemployed', label: 'Unemployed'),
                    ],
                  ),
                  _customSpacer(),
                  const DropdownMenu(
                    label: Text('Membership Category'),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: 'ME',
                        label: 'Mandatory Employed',
                      ),
                      DropdownMenuEntry(
                          value: 'MOFW',
                          label: 'Mandatory Overseas Filipino Worker'),
                      DropdownMenuEntry(
                        value: 'MSE',
                        label: 'Mandatory Self-Employed',
                      ),
                      DropdownMenuEntry(
                        value: 'VE',
                        label: 'Voluntary Employed',
                      ),
                      DropdownMenuEntry(
                          value: 'VOFW',
                          label: 'Voluntary Overseas Filipino Worker'),
                      DropdownMenuEntry(
                        value: 'VSE',
                        label: 'Voluntary Self-Employed',
                      ),
                    ],
                  ),
                  _customDivider(),
                  const Text('Personal Details',
                      style: TextStyle(fontSize: 26)),
                  _customSpacer(),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Member\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mother\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Father\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Spouse\'s Name',
                    ),
                  ),
                  _customSpacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height(cm)',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Weight(kg)',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
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
                  _customDivider(),
                  const Text('Contact Details', style: TextStyle(fontSize: 26)),
                  _customSpacer(),
                  const SizedBox(height: 64),
                  ElevatedButton(onPressed: () {}, child: Text('Submit')),
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
