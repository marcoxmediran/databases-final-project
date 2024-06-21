import 'dart:ui';

import 'package:databases_final_project/ui/employer_builder.dart';
import 'package:databases_final_project/ui/heir_builder.dart';
import 'package:databases_final_project/ui/loading_page.dart';
import 'package:databases_final_project/ui/member_builder.dart';
import 'package:flutter/material.dart';
import 'package:databases_final_project/ui/query.dart';
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
        screen = const LoadingPage();
        break;
      case 1:
        screen = const MemberBuilder();
        break;
      case 2:
        screen = const EmployerBuilder();
        break;
      case 3:
        screen = const HeirBuilder();
        break;
      case 4:
        screen = const Query();
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(destinations[screenIndex].label),
          ),
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
  ScaffoldDestination('Records', Icon(Icons.face_outlined), Icon(Icons.face)),
  ScaffoldDestination('Employers', Icon(Icons.work_outline), Icon(Icons.work)),
  ScaffoldDestination('Heirs', Icon(Icons.group_outlined), Icon(Icons.group)),
  ScaffoldDestination('Debug', Icon(Icons.code_outlined), Icon(Icons.code)),
];
