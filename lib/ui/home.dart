import 'package:databases_final_project/models/heir.dart';
import 'package:databases_final_project/models/member.dart';
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
  late Widget screen;
  late bool drawerMode;

  @override
  Widget build(BuildContext context) {
    switch (screenIndex) {
      case 0:
        screen = const Placeholder();
        break;
      case 1:
        screen = const Placeholder();
        break;
      case 2:
        screen = const Placeholder();
        break;
      default:
        throw UnimplementedError('No widget for Screen $screenIndex');
    }
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
            screen,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Member a = Member(
            mid: 0,
            occupationalStatus: 'Employed',
            membershipType: '',
            memberName: 'Marcox Caldejon Mediran',
            motherName: 'Michelle Robinson Obama',
            fatherName: 'Barack Hussein Obama',
            spouseName: null,
            dateOfBirth: '2003-09-23',
            placeOfBirth: 'General Trias, Cavite',
            sex: 'Male',
            height: '173',
            weight: '53',
            maritalStatus: 'S',
            citizenship: 'Filipino',
            frequencyOfPayment: 'Quarterly',
            tin: '123123123',
            sss: '647891123345',
            permanentAddress: 'General Trias City, Cavite',
            presentAddress: 'General Trias City, Cavite',
            preferredAddress: 'PHA',
            cellphoneNumber: '+639490007779',
            dateOfRegistration: '2024-03-12',
          );
          await _databaseHandler.insertMember(a);
          print('Added member: ' + a.toString());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Member'),
      ),
    );
  }

  // Scaffold for mobile devices
  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: screen,
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
          print(await _databaseHandler.getMembers());
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
