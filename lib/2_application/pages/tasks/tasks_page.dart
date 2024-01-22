import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.task,
    name: 'tasks',
    child: TasksPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.push('/home/dashboard'),
            child: const Text('Go to dashboard page'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => context.push('/home/overview'),
            child: const Text('Go to overview page'),
          ),
        ],
      ),
    );
  }
}
