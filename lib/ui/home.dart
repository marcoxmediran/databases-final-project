import 'package:databases_final_project/ui/employer_builder.dart';
import 'package:databases_final_project/ui/heir_builder.dart';
import 'package:databases_final_project/ui/member_builder.dart';
import 'package:flutter/material.dart';
import 'package:databases_final_project/ui/problems.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int screenIndex = 0;
  late Widget screen;
  late bool drawerMode;

  @override
  Widget build(BuildContext context) {
    switch (screenIndex) {
      case 0:
        screen = const MemberBuilder();
        break;
      case 1:
        screen = const EmployerBuilder();
        break;
      case 2:
        screen = const HeirBuilder();
        break;
      case 3:
        screen = const ProblemsPage();
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
              backgroundColor: Theme.of(context).hoverColor,
              leading: SizedBox(
                height: 40,
                child: Image.asset('assets/images/pagibig_fund_logo.png'),
              ),
              destinations: destinations.map((ScaffoldDestination destination) {
                return NavigationRailDestination(
                  label: Text(destination.label),
                  icon: destination.icon,
                  selectedIcon: destination.selectedIcon,
                );
              }).toList(),
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextButton(
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Pag-Ibig Database Management',
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'A graphical database management software for\nPag-Ibig Fund Membership forms developed in\npartial fulfillment for the course COMP 010 -\nInformation Management.',
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 16),
                                Text('Members:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text('Lopez, Jenna Mae C.'),
                                Text('Marquez, Jashlein Leanne T.'),
                                Text('Mediran, Marcox C.'),
                                Text('Serapio, Alessandra Nicole L.'),
                              ],
                            ),
                          ],
                        );
                      },
                      child: const Text(
                        'About Project',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              selectedIndex: screenIndex,
              useIndicator: true,
              onDestinationSelected: (int index) {
                setState(() {
                  screenIndex = index;
                });
              },
            ),
            Expanded(child: screen),
          ],
        ),
      ),
    );
  }

  // Scaffold for mobile devices
  Widget buildBottomBarScaffold() {
    Color navColor = ElevationOverlay.applySurfaceTint(
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surfaceTint,
      3,
    );
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarColor: navColor,
        systemNavigationBarDividerColor: navColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
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
  ScaffoldDestination('Records', Icon(Icons.face_outlined), Icon(Icons.face)),
  ScaffoldDestination('Employers', Icon(Icons.work_outline), Icon(Icons.work)),
  ScaffoldDestination('Heirs', Icon(Icons.group_outlined), Icon(Icons.group)),
  ScaffoldDestination('Problems', Icon(Icons.task_outlined), Icon(Icons.task)),
];
