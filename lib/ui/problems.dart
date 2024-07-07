import 'package:databases_final_project/ui/problems/difficult_1.dart';
import 'package:databases_final_project/ui/problems/difficult_2.dart';
import 'package:databases_final_project/ui/problems/difficult_3.dart';
import 'package:databases_final_project/ui/problems/medium_3.dart';
import 'package:databases_final_project/ui/problems/medium_1.dart';
import 'package:databases_final_project/ui/problems/medium_2.dart';
import 'package:databases_final_project/ui/problems/medium_4.dart';
import 'package:databases_final_project/ui/problems/simple_1.dart';
import 'package:databases_final_project/ui/problems/simple_2.dart';
import 'package:databases_final_project/ui/problems/simple_3.dart';
import 'package:flutter/material.dart';
import 'package:databases_final_project/database/database_handler.dart';

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Center(child: Text('Problem Statements')),
            pinned: true,
          ),
          SliverList.list(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Simple1()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Simple Problem 1'),
                  subtitle: Text(
                      'Display the mid, name, and membership type of all employees that are single.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Simple2()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Simple Problem 2'),
                  subtitle: Text('Display employers who are from Manila.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Simple3()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Simple Problem 3'),
                  subtitle: Text(
                      'Display heirs whose name contains the string ‘Sato’.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Medium1()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Moderate Problem 1'),
                  subtitle: Text(
                      'Sum up the total monthly income of each employment status and show only the employment statuses which have a sum greater than P35,000.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Medium2()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Moderate Problem 2'),
                  subtitle: Text(
                      'Count the number of members who are not from Cavite in each membership type.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Medium3()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Moderate Problem 3'),
                  subtitle: Text(
                      'Count how many were hired in the month of December. sort by occupation.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Medium4()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Moderate Problem 4'),
                  subtitle: Text(
                      'Display the number of heirs born in each month and only show the months where more than one heir was born. Show the results in ascending order by month.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Difficult1()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Difficult Problem 1'),
                  subtitle: Text(
                      'Sum up the total monthly income of member/s who have a regular status and an occupation of Mobile App Developer. Display the pagibig mid number.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Difficult2()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Difficult Problem 2'),
                  subtitle: Text(
                      'Display the names of the members who are regular at work and either an accounting officer or a fashion designer. Show also the name of their employer and their total monthly income per employer. Sort from highest total monthly income.'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Difficult3()));
                },
                child: const ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.description_outlined)),
                  title: Text('Difficult Problem 3'),
                  subtitle: Text(
                      'Display all pagibig member id, name, citizenship, and date of employment of members whose citizenship is equal to ‘Filipino’, and year of employment is below 2020 and all the other citizenships with year of employment is 2020 and above. Sort by their citizenship.'),
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 64)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Confirm Table Reset'),
                    content: const Text(
                        'Are you sure you want to delete all rows and insert prepared dummy data?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _databaseHandler.demoTables();
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ));
        },
        icon: const Icon(Icons.terminal_outlined),
        label: const Text('Demo Insertion'),
      ),
    );
  }
}
