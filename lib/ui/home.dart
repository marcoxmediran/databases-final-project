import 'package:flutter/material.dart';
import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/employer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  int screenIndex = 0;
  late bool drawerMode;

  @override
  Widget build(BuildContext context) {
    return drawerMode ? buildSideBarScaffold() : buildBottomBarScaffold();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    drawerMode = MediaQuery.of(context).size.width >= 700;
  }

  // Scaffold for desktops
  Widget buildSideBarScaffold() {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          children: <Widget>[
            NavigationRail(
              extended: true,
              minWidth: 80,
              minExtendedWidth: 180,
              backgroundColor: const Color(0xfff2ecf4),
              leading: const SizedBox(
                height: 32,
                child: Text(
                  'Pag-IBIG Logo Bla Bla',
                  textAlign: TextAlign.end,
                ),
              ),
              destinations: destinations.map((ScaffoldDestination destination) {
                return NavigationRailDestination(
                  label: Text(destination.label),
                  icon: destination.icon,
                  selectedIcon: destination.selectedIcon,
                );
              }).toList(),
              selectedIndex: screenIndex,
              useIndicator: true,
              onDestinationSelected: (int index) {
                setState(() {
                  screenIndex = index;
                });
              },
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text('UI for Desktops'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Employer a = Employer(
            employerName: 'Google Philippines',
            employerAddress: 'Taguig, Metro Manila',
          );
          await _databaseHandler.insertEmployer(a);
          print('Added employer: ' + a.toString());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Member'),
      ),
    );
  }

  // Scaffold for mobile devices
  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: const Center(
        child: Text("UI for Mobile Devices"),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: destinations.map((ScaffoldDestination destination) {
          return NavigationDestination(
            label: destination.label,
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            tooltip: destination.label,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(await _databaseHandler.getEmployers());
          //await _databaseHandler.deleteAllRows();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// NavigationBar Classes
class ScaffoldDestination {
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const ScaffoldDestination(this.label, this.icon, this.selectedIcon);
}

const List<ScaffoldDestination> destinations = <ScaffoldDestination>[
  ScaffoldDestination('Home', Icon(Icons.home_outlined), Icon(Icons.home)),
  ScaffoldDestination(
      'Records', Icon(Icons.inventory_2_outlined), Icon(Icons.inventory_2)),
  ScaffoldDestination('Query', Icon(Icons.code_outlined), Icon(Icons.code)),
];
