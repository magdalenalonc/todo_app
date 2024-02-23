import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>(
            (context, signedIn) {
              context.pushNamed(
                HomePage.pageConfig.name,
                pathParameters: {'tab': OverviewPage.pageConfig.name},
              );
            },
          ),
          AuthStateChangeAction<UserCreated>(
            (context, signedIn) {
              context.pushNamed(
                HomePage.pageConfig.name,
                pathParameters: {'tab': DashboardPage.pageConfig.name},
              );
            },
          ),
        ],
      ),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => ProfileScreen(
        actions: [
          SignedOutAction(
            (context) {
              context.goNamed(
                HomePage.pageConfig.name,
                pathParameters: {'tab': OverviewPage.pageConfig.name},
              );
            },
          ),
        ],
      ),
    ),
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePageProvider(
            key: state.pageKey,
            tab: state.pathParameters['tab']!,
          ),
        ),
      ],
    ),
    GoRoute(
      name: CreateToDoCollectionPage.pageConfig.name,
      path: '$_basePath/overview/${CreateToDoCollectionPage.pageConfig.name}',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('collection_title'.tr()),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: SafeArea(
            child: CreateToDoCollectionPage.pageConfig.child,
          ),
        );
      },
    ),
    GoRoute(
      name: CreateToDoEntryPage.pageConfig.name,
      path: '$_basePath/overview/${CreateToDoEntryPage.pageConfig.name}',
      builder: (context, state) {
        final castedExtras = state.extra as CreateToDoEntryPageExtra;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Create entry'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: SafeArea(
            child: CreateToDoEntryPageProvider(
              toDoEntryItemAddedCallback:
                  castedExtras.toDoEntryItemAddedCallback,
              collectionId: castedExtras.collectionId,
            ),
          ),
        );
      },
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: ToDoDetailPageProvider(
            collectionId: CollectionId.fromUniqueString(
              state.pathParameters['collectionId'] ?? '',
            ),
          ),
        );
      },
    ),
  ],
);
