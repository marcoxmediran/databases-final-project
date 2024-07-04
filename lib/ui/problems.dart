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
          const SliverAppBar.large(
            title: Center(child: Text('Problem Statements')),
          ),
          SliverList.list(
            children: [
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Simple Problem 1'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Simple Problem 2'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Simple Problem 3'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Moderate Problem 1'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Moderate Problem 2'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Moderate Problem 3'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Moderate Problem 4'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Difficult Problem 1'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Difficult Problem 2'),
                  subtitle: Text('Problem Description'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Difficult Problem 3'),
                  subtitle: Text('Problem Description'),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => await _databaseHandler.demoTables(),
        icon: const Icon(Icons.terminal_outlined),
        label: const Text('Demo Insertion'),
      ),
    );
  }
}
