import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => context.push('/home/start'),
                child: const Text('Go to start'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/start');
                  }
                },
                child: const Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/home/task',
      builder: (context, state) {
        return Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.push('/home/settings'),
                child: const Text('Go to settings page'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => context.push('/home/start'),
                child: const Text('Go to start page'),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
