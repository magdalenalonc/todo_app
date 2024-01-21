import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  // list of all tabs that should be displayed inside our navigation bar
  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) =>
            NavigationDestination(icon: Icon(page.icon), label: page.name),
      )
      .toList();

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.go('/home/${HomePage.tabs[index].name}');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  selectedLabelTextStyle:
                      TextStyle(color: theme.colorScheme.onBackground),
                  selectedIconTheme:
                      IconThemeData(color: theme.colorScheme.onBackground),
                  unselectedIconTheme: IconThemeData(
                      color: theme.colorScheme.onBackground.withOpacity(0.5)),
                  onDestinationSelected: (index) =>
                      _tapOnNavigationDestination(context, index),
                  selectedIndex: widget.index,
                  destinations: destinations
                      .map((element) =>
                          AdaptiveScaffold.toRailDestination(element))
                      .toList(),
                ),
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-navigation-small'),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                  onDestinationSelected: (value) =>
                      _tapOnNavigationDestination(context, value),
                  currentIndex: widget.index,
                  destinations: destinations,
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body'),
                builder: AdaptiveScaffold.emptyBuilder,
              )
            },
          ),
        ),
      ),
    );
  }
}
