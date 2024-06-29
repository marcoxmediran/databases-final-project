import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employer.dart';
import 'package:flutter/material.dart';

class EmployerBuilder extends StatefulWidget {
  const EmployerBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _EmployerBuilderState();
}

class _EmployerBuilderState extends State<EmployerBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Employer>> _employers;

  Future<List<Employer>> _getEmployers() async {
    return await _databaseHandler.getEmployers();
  }

  Future<List<Employer>> _searchEmployers(String keyword) async {
    return await _databaseHandler.searchEmployers(keyword);
  }

  Future<List<Map>> _countEmployees(Employer employer) async {
    return await _databaseHandler.countEmployees(employer);
  }

  Future searchEmployers(String keyword) async => setState(() {
        _employers = _searchEmployers(keyword);
      });

  @override
  void initState() {
    super.initState();
    _employers = _getEmployers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverAppBar(
            title: TextField(
              controller: _searchController,
              onChanged: (value) => searchEmployers(value),
              decoration: InputDecoration(
                hintText: 'Search employers',
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 4),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(128),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverFillRemaining(
            child: FutureBuilder<List<Employer>>(
                future: _employers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (contex, index) {
                      Employer employer = snapshot.data![index];
                      return InkWell(
                        onTap: () async {
                          var employeeCount = await _countEmployees(employer);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Dismiss'))
                                    ],
                                    content: FittedBox(
                                      child: SizedBox(
                                        width: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(employer.employerName,
                                                style: const TextStyle(
                                                    fontSize: 28)),
                                            Text(employer.formatKey(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87)),
                                            const SizedBox(height: 32),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Address: ${employer.employerAddress}'),
                                                Text(
                                                    'Currently employed members: ${employeeCount.first['isCurrentEmployment'] == 'Yes' ? employeeCount.first['COUNT(*)'] : 0}'),
                                                Text(
                                                    'Previously employed members: ${employeeCount.last['isCurrentEmployment'] == 'No' ? employeeCount.last['COUNT(*)'] : 0}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ));
                        },
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.apartment),
                          ),
                          title: Text(
                              '${employer.employerName} - ${employer.employerAddress}'),
                          subtitle: Text(employer.formatKey()),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
